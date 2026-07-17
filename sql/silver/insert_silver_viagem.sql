INSERT INTO silver_viagem
(
    id_viagem,
    num_proposta,
    situacao,
    viagem_urgente,
    cod_orgao_superior,
    nome_orgao_superior,
    nome_viajante,
    cargo,
    data_inicio,
    data_fim,
    destinos,
    motivo,
    valor_diarias,
    valor_passagens,
    valor_devolucao,
    valor_outros_gastos
)
SELECT
    UPPER(TRIM(r.id_viagem)),
    UPPER(TRIM(r.num_proposta)),
    UPPER(NULLIF(TRIM(r.situacao), '')),
    UPPER(NULLIF(TRIM(r.viagem_urgente), '')),
    UPPER(TRIM(r.cod_orgao_superior)),
    UPPER(NULLIF(TRIM(r.nome_orgao_superior), '')),
    UPPER(NULLIF(TRIM(r.nome_viajante), '')),
    UPPER(NULLIF(TRIM(r.cargo), '')),
    STR_TO_DATE(NULLIF(TRIM(r.data_inicio), ''), '%d/%m/%Y'),
    STR_TO_DATE(NULLIF(TRIM(r.data_fim), ''), '%d/%m/%Y'),
    UPPER(NULLIF(TRIM(r.destinos), '')),
    UPPER(NULLIF(TRIM(r.motivo), '')),
    CAST(REPLACE(REPLACE(NULLIF(TRIM(r.valor_diarias), ''), '.', ''), ',', '.') AS DECIMAL(10,2)),
    CAST(REPLACE(REPLACE(NULLIF(TRIM(r.valor_passagens), ''), '.', ''), ',', '.') AS DECIMAL(10,2)),
    CAST(REPLACE(REPLACE(NULLIF(TRIM(r.valor_devolucao), ''), '.', ''), ',', '.') AS DECIMAL(10,2)),
    CAST(REPLACE(REPLACE(NULLIF(TRIM(r.valor_outros_gastos), ''), '.', ''), ',', '.') AS DECIMAL(10,2))

FROM raw_viagem r;
