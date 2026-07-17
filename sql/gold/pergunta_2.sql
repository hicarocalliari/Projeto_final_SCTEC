SELECT
    CONCAT(t.destino_cidade, '/', t.destino_uf) AS destino,
    AVG(sv.valor_total) AS custo_medio
FROM silver_viagem sv
INNER JOIN silver_trecho t
    ON sv.id_viagem = t.id_viagem
WHERE 
    t.destino_cidade IS NOT NULL
    AND TRIM(t.destino_cidade) <> ''
    AND t.destino_uf IS NOT NULL
GROUP BY
    t.destino_cidade,
    t.destino_uf
ORDER BY custo_medio DESC
LIMIT 3;