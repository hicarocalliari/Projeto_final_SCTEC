INSERT INTO silver_passagem( 
    id_viagem, 
    meio_transporte, 
    pais_origem_ida, 
    uf_origem_ida, 
    cidade_origem_ida, 
    pais_destino_ida, 
    uf_destino_ida, 
    cidade_destino_ida, 
    valor_passagem, 
    taxa_servico, 
    data_emissao ) 
    SELECT 
    sv.id_viagem, 
    UPPER(NULLIF(TRIM(r.meio_transporte), '')),
    UPPER(NULLIF(TRIM(r.pais_origem_ida), '')),
    UPPER(NULLIF(TRIM(r.uf_origem_ida), '')),
    UPPER(NULLIF(TRIM(r.cidade_origem_ida), '')),
    UPPER(NULLIF(TRIM(r.pais_destino_ida), '')),
    UPPER(NULLIF(TRIM(r.uf_destino_ida), '')),
    UPPER(NULLIF(TRIM(r.cidade_destino_ida), '')),
CAST(
	REPLACE(
		REPLACE(NULLIF(TRIM(r.valor_passagem), ''), '.', ''),
        ',', 
        '.') 
        AS DECIMAL(10,2)), 
CAST(
	REPLACE(
		REPLACE(NULLIF(TRIM(r.taxa_servico), ''), '.', ''),
        ',', '.') 
        AS DECIMAL(10,2)), 
STR_TO_DATE(NULLIF(TRIM(r.data_emissao), ''), '%d/%m/%Y') 
FROM 
	raw_passagem r 
INNER JOIN 
	silver_viagem sv 
    ON r.id_viagem = sv.id_viagem;
