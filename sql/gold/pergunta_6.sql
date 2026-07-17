SELECT 
    destino_uf, COUNT(*) AS quantidade
FROM
    silver_trecho
GROUP BY destino_uf
ORDER BY quantidade DESC
LIMIT 1;
