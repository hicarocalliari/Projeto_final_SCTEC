CREATE VIEW top5_orgao_maior_custo AS
SELECT 
    nome_orgao_superior, SUM(valor_total) AS custo_total
FROM
    silver_viagem
GROUP BY nome_orgao_superior
ORDER BY custo_total DESC
LIMIT 5;

CREATE VIEW top3_destinos_maior_custo_medio AS
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

CREATE VIEW viagem_maior_duracao_custo_total AS
SELECT 
    id_viagem,
    nome_viajante,
    data_inicio,
    data_fim,
    duracao_dias,
    valor_total
FROM
    silver_viagem
ORDER BY duracao_dias DESC
LIMIT 1;