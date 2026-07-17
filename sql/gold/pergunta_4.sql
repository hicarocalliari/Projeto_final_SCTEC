SELECT 
    tipo_pagamento, AVG(valor) AS valor_medio
FROM
    silver_pagamento
GROUP BY tipo_pagamento
ORDER BY valor_medio DESC
LIMIT 1;
