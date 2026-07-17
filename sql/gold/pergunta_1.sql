SELECT 
    nome_orgao_superior, SUM(valor_total) AS custo_total
FROM
    silver_viagem
GROUP BY nome_orgao_superior
ORDER BY custo_total DESC
LIMIT 5;