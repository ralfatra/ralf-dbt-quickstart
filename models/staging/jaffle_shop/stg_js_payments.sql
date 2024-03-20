with src as (
    
    select * from {{ source('raw', 'payments') }}
    
),

stg_fim as (

        select
            orderid as order_id,
            paymentmethod as metodo_pagamento,
            status,
            amount,
            created as data_criacao
        from src

)

select *
from stg_fim


/*select 
orderid as order_id,
paymentmethod as metodo_pagamento,
status,
amount,
created as data_criacao
from `csf-lab.raw.payments`*/
