SELECT 
    nome_orgao_pagador,
    SUM(valor) AS total_pago
FROM silver_pagamento
WHERE nome_orgao_pagador IS NOT NULL
GROUP BY nome_orgao_pagador
ORDER BY total_pago DESC
LIMIT 1;
