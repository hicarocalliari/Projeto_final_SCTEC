UPDATE silver_viagem
SET 
    valor_total = 
        COALESCE(valor_diarias, 0) 
        + COALESCE(valor_passagens, 0) 
        + COALESCE(valor_outros_gastos, 0) 
        - COALESCE(valor_devolucao, 0),
        
    duracao_dias = DATEDIFF(data_fim, data_inicio);