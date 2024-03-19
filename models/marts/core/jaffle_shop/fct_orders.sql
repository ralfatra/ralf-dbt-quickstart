/*{{ 
    config(
        
        materialized='table'
       
    ) 
}}*/

-- somente o primeiro recebe o with
with orders as (

    select * from {{ ref('stg_js_orders')}}

),
payments as (

    select * from {{ ref('stg_js_payments')}}

),

customers as (

    select * from {{ ref('dim_customers')}}

),

final as (
    select 
      o.order_date,
      c.customer_id,
      p.order_id,
      sum(p.amount) as amount,
      FORMAT_DATE('%Y-%m-%d %H:%M:%S',CURRENT_TIMESTAMP()) AS dt_proccess
    from payments p
    inner join orders o on p.order_id = o.order_id 
    inner join customers c on o.customer_id = c.customer_id
    group by 
      o.order_date,
      c.customer_id,
      p.order_id

)

select * from final
order by order_date

/*SELECT
  O.ID AS order_id,
  C.ID AS customer_id,
  SUM(P.amount) AS amount
FROM
  `csf-lab.raw.payments` P
  inner join `csf-lab.raw.orders` O on P.ORDERID = O.ID
  inner join `csf-lab.raw.customers` C on O.user_id = C.ID
GROUP BY
  O.ID,
  C.ID */