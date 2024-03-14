/*{{ 
    config(
        
        materialized='table'
       
    ) 
}}*/

-- somente o primeiro recebe o with
with customers as (

    select * from {{ ref('dim_customers')}}

),
orders as (

    select * from {{ ref('stg_js_orders')}}

),
payments as (

    select * from {{ ref('stg_js_payments')}}

),

final as (
    select 
      c.customer_id,
      p.order_id,
      sum(p.amount) as amount
    from payments p
    inner join orders o on p.order_id = o.order_id 
    inner join customers c on o.customer_id = c.customer_id
    group by 
      c.customer_id,
      p.order_id

) 

select * from final

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