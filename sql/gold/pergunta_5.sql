SELECT 
    meio_transporte, COUNT(*) AS qtde_viagens
FROM
    silver_trecho
GROUP BY meio_transporte
ORDER BY qtde_viagens DESC
LIMIT 1;
