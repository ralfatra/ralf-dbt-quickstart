with src as (
    
    select * from {{ source('raw', 'orders') }}
    
),

stg_fim as (

        select
            id as order_id,
            user_id as customer_id,
            order_date,
            status--,
            --current_timestamp() as _etl_loaded_at
        from src

)

select *
from stg_fim
