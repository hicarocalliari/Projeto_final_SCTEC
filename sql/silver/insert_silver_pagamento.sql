INSERT INTO silver_pagamento
(
    id_viagem,
    num_proposta,
    nome_orgao_pagador,
    nome_ug_pagadora,
    tipo_pagamento,
    valor
)
SELECT 
    sv.id_viagem,
    UPPER(NULLIF(TRIM(rp.num_proposta), '')),
    UPPER(NULLIF(TRIM(rp.nome_orgao_pagador), '')),
    UPPER(NULLIF(TRIM(rp.nome_ug_pagadora), '')),
    UPPER(NULLIF(TRIM(rp.tipo_pagamento), '')),
    CAST(REPLACE(REPLACE(NULLIF(TRIM(rp.valor), ''),
                '.',
                ''),
            ',',
            '.')
        AS DECIMAL (10 , 2 ))

FROM raw_pagamento rp
INNER JOIN silver_viagem sv 
	on rp.id_viagem = sv.id_viagem
