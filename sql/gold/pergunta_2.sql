SELECT 
    destinos, AVG(valor_total) AS media
FROM
    silver_viagem
WHERE
    destinos <> ''
GROUP BY destinos
HAVING COUNT(*) >= 30
ORDER BY media DESC
LIMIT 3;