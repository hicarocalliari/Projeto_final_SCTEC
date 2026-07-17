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