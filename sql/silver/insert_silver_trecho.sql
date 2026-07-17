INSERT INTO silver_trecho(
	id_viagem,
	sequencia_trecho,
    origem_data,
    origem_uf,
    origem_cidade,
    destino_data,
    destino_uf,
    destino_cidade,
    meio_transporte,
    numero_diarias
)
SELECT
    sv.id_viagem,
    CAST(NULLIF(TRIM(rt.sequencia_trecho), '') AS UNSIGNED),
    STR_TO_DATE(NULLIF(TRIM(rt.origem_data), ''),'%d/%m/%Y'),
    UPPER(NULLIF(TRIM(rt.origem_uf), '')),
    UPPER(NULLIF(TRIM(rt.origem_cidade), '')),
    STR_TO_DATE(NULLIF(TRIM(rt.destino_data), ''),'%d/%m/%Y'),
    UPPER(NULLIF(TRIM(rt.destino_uf), '')),
    UPPER(NULLIF(TRIM(rt.destino_cidade), '')),
    UPPER(NULLIF(TRIM(rt.meio_transporte), '')),
    CAST(
        REPLACE(
            REPLACE(NULLIF(TRIM(rt.numero_diarias), ''), '.', ''),
            ',',
            '.'
        ) AS DECIMAL(10,2)
    )

FROM raw_trecho rt

    INNER JOIN 
        silver_viagem sv
    ON rt.id_viagem = sv.id_viagem;