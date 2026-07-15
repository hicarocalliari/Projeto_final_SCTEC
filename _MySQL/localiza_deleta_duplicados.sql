SELECT 
    id_viagem,
    num_proposta,
    nome_orgao_pagador,
    nome_ug_pagadora,
    tipo_pagamento,
    valor,
    COUNT(*) AS quantidade
FROM silver_pagamento
GROUP BY 
    id_viagem,
    num_proposta,
    nome_orgao_pagador,
    nome_ug_pagadora,
    tipo_pagamento,
    valor
HAVING COUNT(*) > 1;

DELETE p1
FROM silver_pagamento p1
INNER JOIN silver_pagamento p2
ON 
    p1.id_viagem = p2.id_viagem
    AND p1.num_proposta = p2.num_proposta
    AND p1.nome_orgao_pagador = p2.nome_orgao_pagador
    AND p1.nome_ug_pagadora = p2.nome_ug_pagadora
    AND p1.tipo_pagamento = p2.tipo_pagamento
    AND p1.valor = p2.valor
    AND p1.id_pagamento > p2.id_pagamento;
    
#####################################

SELECT 
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
    data_emissao,
    COUNT(*) AS quantidade
FROM silver_passagem
GROUP BY
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
    data_emissao
HAVING COUNT(*) > 1;

DELETE p1
FROM silver_passagem p1
INNER JOIN silver_passagem p2
ON
    p1.id_viagem = p2.id_viagem
    AND p1.meio_transporte = p2.meio_transporte
    AND p1.pais_origem_ida = p2.pais_origem_ida
    AND p1.uf_origem_ida = p2.uf_origem_ida
    AND p1.cidade_origem_ida = p2.cidade_origem_ida
    AND p1.pais_destino_ida = p2.pais_destino_ida
    AND p1.uf_destino_ida = p2.uf_destino_ida
    AND p1.cidade_destino_ida = p2.cidade_destino_ida
    AND p1.valor_passagem = p2.valor_passagem
    AND p1.taxa_servico = p2.taxa_servico
    AND p1.data_emissao = p2.data_emissao
    AND p1.id_passagem > p2.id_passagem;