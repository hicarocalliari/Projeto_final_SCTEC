SELECT
    st.destino,
    SUM(sv.valor_total) AS custo_total
FROM (
    SELECT DISTINCT
        id_viagem,
        CONCAT(destino_cidade, '/', destino_uf) AS destino
    FROM silver_trecho
    WHERE destino_cidade IS NOT NULL
) st
INNER JOIN silver_viagem sv
    ON st.id_viagem = sv.id_viagem
GROUP BY
    st.destino
ORDER BY
    custo_total DESC
LIMIT 10;