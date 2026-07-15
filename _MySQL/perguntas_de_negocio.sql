#1- Os 5 órgãos com maior custo total? 
#2- Os 3 destinos com maior custo médio por viagem? 
#3- A viagem de maior duração e seu custo total? 
#4- Qual o tipo de pagamento com maior valor médio? 
#5- Qual o meio de transporte mais usado nos trechos? 
#6-  Qual UF de destino aparece em mais trechos? 
#7- Qual órgão pagou mais no total? 

use transparencia;
####################################################################################
#1- Os 5 órgãos com maior custo total? 
SELECT 
    *
FROM
    silver_viagem;
SELECT 
    nome_orgao_superior, SUM(valor_total) AS custo_total
FROM
    silver_viagem
GROUP BY nome_orgao_superior
ORDER BY custo_total DESC
LIMIT 5;

####################################################################################
#2- Os 3 destinos com maior custo médio por viagem? 

SELECT 
    destinos, AVG(valor_total) AS media
FROM
    silver_viagem
WHERE
    destinos <> ''
GROUP BY destinos
HAVING COUNT(*) >= 30
ORDER BY media DESC
LIMIT 3;

####################################################################################

#3- A viagem de maior duração e seu custo total? 
SELECT 
    id_viagem,
    nome_viajante,
    data_inicio,
    data_fim,
    duracao_dias,
    valor_total
FROM
    silver_viagem
ORDER BY duracao_dias DESC
LIMIT 1;

####################################################################################

#4- Qual o tipo de pagamento com maior valor médio?

SELECT 
    tipo_pagamento, AVG(valor) AS valor_medio
FROM
    silver_pagamento
GROUP BY tipo_pagamento
ORDER BY valor_medio DESC
LIMIT 1;

####################################################################################

#5- Qual o meio de transporte mais usado nos trechos? 

SELECT 
    meio_transporte, COUNT(*) AS soma
FROM
    silver_trecho
GROUP BY meio_transporte
ORDER BY soma DESC
LIMIT 1;

####################################################################################

#6-  Qual UF de destino aparece em mais trechos? 

SELECT 
    destino_uf, COUNT(*) AS soma
FROM
    silver_trecho
GROUP BY destino_uf
ORDER BY soma DESC
LIMIT 1;

####################################################################################

#7- Qual órgão pagou mais no total? 

SELECT 
    nome_orgao_pagador, SUM(valor) AS soma
FROM
    silver_pagamento
GROUP BY nome_orgao_pagador
ORDER BY soma DESC
LIMIT 1;