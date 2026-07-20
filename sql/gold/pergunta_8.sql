SELECT
    st.meio_transporte,
    AVG(v.valor_total) AS custo_medio
FROM (
    SELECT DISTINCT
        id_viagem,
        meio_transporte
    FROM silver_trecho
    WHERE meio_transporte IS NOT NULL
) st
INNER JOIN silver_viagem v
    ON st.id_viagem = v.id_viagem
GROUP BY
    st.meio_transporte
ORDER BY
    custo_medio DESC;