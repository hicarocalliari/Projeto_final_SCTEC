SELECT
    CONCAT(st.destino_cidade, '/', st.destino_uf) AS destino,
    SUM(sv.valor_total) AS custo_total
FROM silver_trecho st
INNER JOIN silver_viagem sv
    ON st.id_viagem = sv.id_viagem
WHERE 
    st.destino_cidade IS NOT NULL
GROUP BY
    st.destino_cidade,
    st.destino_uf
ORDER BY custo_total DESC
LIMIT 10;