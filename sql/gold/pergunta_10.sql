SELECT
    sv.nome_viajante,
    COUNT(DISTINCT sv.id_viagem) AS quantidade_viagens,
    SUM(sp.valor) AS custo_total
FROM silver_viagem sv
INNER JOIN silver_pagamento sp
    ON sv.id_viagem = sp.id_viagem
WHERE sv.nome_viajante IS NOT NULL
GROUP BY sv.nome_viajante
ORDER BY custo_total DESC
LIMIT 10;