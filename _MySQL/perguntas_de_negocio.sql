
# Os 3 destinos com maior custo médio por viagem? 
# A viagem de maior duração e seu custo total? 
# Qual o tipo de pagamento com maior valor médio? 
# Qual o meio de transporte mais usado nos trechos? 
# Qual UF de destino aparece em mais trechos? 
# Qual órgão pagou mais no total? 
use transparencia;
### 
# Os 5 órgãos com maior custo total? 
SELECT * from silver_viagem;
SELECT 
    nome_orgao_superior, SUM(valor_total) AS custo_total
FROM
    silver_viagem
GROUP BY nome_orgao_superior
ORDER BY custo_total DESC
LIMIT 5;

####
#A viagem de maior duração e seu custo total? 
SELECT
    id_viagem,
    nome_viajante,
    data_inicio,
    data_fim,
    duracao_dias,
    valor_total
FROM silver_viagem
ORDER BY duracao_dias DESC
LIMIT 1;

