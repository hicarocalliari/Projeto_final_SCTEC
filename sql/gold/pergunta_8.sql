SELECT
    st.meio_transporte,
    AVG(sv.valor_total) AS custo_medio
FROM silver_trecho st
INNER JOIN silver_viagem sv
    ON st.id_viagem = sv.id_viagem
WHERE st.meio_transporte IS NOT NULL
GROUP BY st.meio_transporte
ORDER BY custo_medio DESC;