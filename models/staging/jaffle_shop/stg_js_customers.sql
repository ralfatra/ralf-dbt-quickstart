with src as (

-- tipo source
SELECT * FROM {{ source ('raw','customers') }}

--SELECT * FROM `csf-lab.raw.customers` 

),

stg_fim as (
  
  select 
  id as customer_id,
  first_name,
  last_name,
  current_timestamp() as _etl_loaded_at
  from src
)

select * from stg_fim