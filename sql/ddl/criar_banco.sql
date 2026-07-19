DROP DATABASE IF EXISTS transparencia;
CREATE DATABASE transparencia
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
use transparencia;

SHOW VARIABLES LIKE 'secure_file_priv';
SET lc_time_names = 'pt_BR';

DROP TABLE IF EXISTS raw_pagamento;
CREATE TABLE raw_pagamento (
    id_viagem VARCHAR(20),
    num_proposta VARCHAR(20),
    cod_orgao_superior VARCHAR(20),
    nome_orgao_superior VARCHAR(255),
    cod_orgao_pagador VARCHAR(20),
    nome_orgao_pagador VARCHAR(255),
    cod_ug_pagadora VARCHAR(20),
    nome_ug_pagadora VARCHAR(255),
    tipo_pagamento VARCHAR(50),
    valor VARCHAR(30)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS raw_passagem;
CREATE TABLE raw_passagem (
    id_viagem VARCHAR(20),
    num_proposta VARCHAR(20),
    meio_transporte VARCHAR(50),
    pais_origem_ida VARCHAR(60),
    uf_origem_ida VARCHAR(40),
    cidade_origem_ida VARCHAR(80),
    pais_destino_ida VARCHAR(60),
    uf_destino_ida VARCHAR(40),
    cidade_destino_ida VARCHAR(80),
    pais_origem_volta VARCHAR(50),
    uf_origem_volta VARCHAR(30),
    cidade_origem_volta VARCHAR(50),
    pais_destino_volta VARCHAR(50),
    uf_destino_volta VARCHAR(30),
    cidade_destino_volta VARCHAR(50),
    valor_passagem VARCHAR(30),
    taxa_servico VARCHAR(30),
    data_emissao VARCHAR(20),
    hora_emissao VARCHAR(10)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS raw_trecho;
CREATE TABLE raw_trecho (
    id_viagem VARCHAR(20),
    num_proposta VARCHAR(20),
    sequencia_trecho VARCHAR(10),
    origem_data VARCHAR(20),
    origem_pais VARCHAR(50),
    origem_uf VARCHAR(40),
    origem_cidade VARCHAR(80),
    destino_data VARCHAR(20),
    destino_pais VARCHAR(50),
    destino_uf VARCHAR(40),
    destino_cidade VARCHAR(80),
    meio_transporte VARCHAR(50),
    numero_diarias VARCHAR(10),
    missao VARCHAR(5)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS raw_viagem;
CREATE TABLE raw_viagem (
    id_viagem VARCHAR(20),
    num_proposta VARCHAR(20),
    situacao VARCHAR(20),
    viagem_urgente VARCHAR(5),
    justificativa_urgencia_viagem VARCHAR(1200),
    cod_orgao_superior VARCHAR(20),
    nome_orgao_superior VARCHAR(255),
    cod_orgao_solicitante VARCHAR(20),
    nome_orgao_solicitante VARCHAR(120),
    cpf_viajante VARCHAR(20),
    nome_viajante VARCHAR(255),
    cargo VARCHAR(255),
    funcao VARCHAR(30),
    descricao_funcao VARCHAR(50),
    data_inicio VARCHAR(20),
    data_fim VARCHAR(20),
    destinos VARCHAR(4000),
    motivo VARCHAR(4000),
    valor_diarias VARCHAR(30),
    valor_passagens VARCHAR(30),
    valor_devolucao VARCHAR(30),
    valor_outros_gastos VARCHAR(30)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS silver_viagem;
CREATE TABLE silver_viagem (
    id_viagem VARCHAR(20) NOT NULL,
    num_proposta VARCHAR(20),
    situacao VARCHAR(50),
    viagem_urgente VARCHAR(5),
    cod_orgao_superior VARCHAR(20),
    nome_orgao_superior VARCHAR(255) NOT NULL,
    nome_viajante VARCHAR(255),
    cargo VARCHAR(255),
    data_inicio DATE,
    data_fim DATE,
    destinos VARCHAR(4000),
    motivo VARCHAR(4000),
    valor_diarias DECIMAL(10 , 2 ),
    valor_passagens DECIMAL(10 , 2 ),
    valor_devolucao DECIMAL(10 , 2 ),
    valor_outros_gastos DECIMAL(10 , 2 ),
    valor_total DECIMAL(12 , 2 ),
    duracao_dias INT,
    CONSTRAINT pk_silver_viagem PRIMARY KEY (id_viagem),
    CONSTRAINT ck_valor_diarias CHECK (valor_diarias >= 0)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS silver_passagem;
CREATE TABLE silver_passagem (
    id_passagem INT AUTO_INCREMENT,
    id_viagem VARCHAR(20) NOT NULL,
    meio_transporte VARCHAR(50),
    pais_origem_ida VARCHAR(60),
    uf_origem_ida VARCHAR(40),
    cidade_origem_ida VARCHAR(80),
    pais_destino_ida VARCHAR(60),
    uf_destino_ida VARCHAR(40),
    cidade_destino_ida VARCHAR(80),
    valor_passagem DECIMAL(10 , 2 ),
    taxa_servico DECIMAL(10 , 2 ),
    data_emissao DATE,
    CONSTRAINT pk_silver_passagem PRIMARY KEY (id_passagem),
    CONSTRAINT fk_silver_passagem_viagem FOREIGN KEY (id_viagem)
        REFERENCES silver_viagem (id_viagem),
    CONSTRAINT ck_valor_passagem CHECK (valor_passagem >= 0),
    CONSTRAINT ck_taxa_servico CHECK (taxa_servico >= 0)
)ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS silver_pagamento;
CREATE TABLE silver_pagamento (
    id_pagamento INT AUTO_INCREMENT,
    id_viagem VARCHAR(20) NOT NULL,
    num_proposta VARCHAR(20),
    nome_orgao_pagador VARCHAR(255),
    nome_ug_pagadora VARCHAR(255),
    tipo_pagamento VARCHAR(50) NOT NULL,
    valor DECIMAL(10 , 2 ),
    CONSTRAINT pk_silver_pagamento PRIMARY KEY (id_pagamento),
    CONSTRAINT fk_silver_pagamento_viagem FOREIGN KEY (id_viagem)
		REFERENCES silver_viagem(id_viagem),
	CONSTRAINT ck_valor_pagamento CHECK (valor >=0)
)ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS silver_trecho;
CREATE TABLE silver_trecho (
    id_trecho INT AUTO_INCREMENT,
    id_viagem VARCHAR(20) NOT NULL,
    sequencia_trecho INT,
    origem_data DATE,
    origem_uf VARCHAR(40),
    origem_cidade VARCHAR(80),
    destino_data DATE,
    destino_uf VARCHAR(40),
    destino_cidade VARCHAR(80),
    meio_transporte VARCHAR(50),
    numero_diarias DECIMAL(10 , 2 ),
    CONSTRAINT pk_silver_trecho PRIMARY KEY (id_trecho),
    CONSTRAINT fk_silver_trecho_viagem FOREIGN KEY (id_viagem)
        REFERENCES silver_viagem (id_viagem),
	CONSTRAINT ck_numero_diarias CHECK (numero_diarias >= 0),
    CONSTRAINT uq_id_viagem_sequencia UNIQUE (id_viagem,sequencia_trecho)
)ENGINE=InnoDB ROW_FORMAT=DYNAMIC;








