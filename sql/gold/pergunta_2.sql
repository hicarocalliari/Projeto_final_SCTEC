SELECT
    destino,
    AVG(valor_total) AS custo_medio,
    COUNT(*) AS quantidade_viagens
FROM (
    SELECT DISTINCT
        st.id_viagem,
        CONCAT(st.destino_cidade, '/', st.destino_uf) AS destino,
        sv.valor_total
    FROM silver_viagem sv
    INNER JOIN silver_trecho st
        ON sv.id_viagem = st.id_viagem
    WHERE 
        st.destino_cidade IS NOT NULL
        AND TRIM(st.destino_cidade) <> ''
        AND st.destino_uf IS NOT NULL
        AND sv.valor_total > 0
) AS viagens_destino
GROUP BY destino
HAVING COUNT(*) >= 30
ORDER BY custo_medio DESC
LIMIT 3;