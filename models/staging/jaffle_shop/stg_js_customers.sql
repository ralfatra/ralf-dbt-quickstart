with src as (

-- tipo source
SELECT * FROM {{ source ('raw','customers') }}

--SELECT * FROM `csf-lab.raw.customers` 

),

stg_fim as (
  
  select 
  id as customer_id,
  first_name as primeiro_nome,
  last_name as ultimo_nome
  from src
)

select * from stg_fim