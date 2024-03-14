select 
orderid as order_id,
paymentmethod as metodo_pagamento,
status,
amount,
created as data_criacao
from `csf-lab.raw.payments`
