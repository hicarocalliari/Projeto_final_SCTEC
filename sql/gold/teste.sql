SELECT
    CONCAT(st.destino_cidade, '/', st.destino_uf) AS destino,
    AVG(sv.valor_total) AS custo_medio
FROM silver_viagem sv
INNER JOIN silver_trecho st
    ON sv.id_viagem = st.id_viagem
WHERE 
    st.destino_cidade <> ''
GROUP BY
    st.destino_cidade,
    st.destino_uf
HAVING 
    COUNT(*) >= 30
ORDER BY 
    custo_medio DESC
LIMIT 3;


###

SELECT
    CONCAT(t.destino_cidade, '/', t.destino_uf) AS destino,
    AVG(v.valor_total) AS custo_medio
FROM silver_viagem v
INNER JOIN silver_trecho t
    ON v.id_viagem = t.id_viagem
GROUP BY
    t.destino_cidade,
    t.destino_uf
ORDER BY custo_medio DESC
LIMIT 3;


###


SELECT
    CONCAT(t.destino_cidade, '/', t.destino_uf) AS destino,
    AVG(v.valor_total) AS custo_medio
FROM silver_viagem v
INNER JOIN silver_trecho t
    ON v.id_viagem = t.id_viagem
WHERE 
    t.destino_cidade IS NOT NULL
    AND TRIM(t.destino_cidade) <> ''
    AND t.destino_uf IS NOT NULL
GROUP BY
    t.destino_cidade,
    t.destino_uf
ORDER BY custo_medio DESC
LIMIT 3;


####

SELECT
    destinos,
    AVG(valor_total) AS custo_medio,
    COUNT(*) AS quantidade_viagens
FROM silver_viagem
WHERE destinos <> ''
GROUP BY destinos
HAVING COUNT(*) >= 30
ORDER BY custo_medio DESC
LIMIT 3;


###


SELECT
    CONCAT(st.destino_cidade, '/', st.destino_uf) AS destino,
    AVG(sv.valor_total) AS custo_medio,
    COUNT(*) AS quantidade_viagens
FROM silver_viagem sv
INNER JOIN silver_trecho st
    ON sv.id_viagem = st.id_viagem
WHERE 
    st.destino_cidade <> ''
GROUP BY
    st.destino_cidade,
    st.destino_uf
HAVING 
    COUNT(*) >= 30
ORDER BY 
    custo_medio DESC
LIMIT 3;


###
