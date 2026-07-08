"""
config.py
---------
"""

import os
from pathlib import Path


# ---------------------------------------------------------------------------
# Caminhos do projeto
# ---------------------------------------------------------------------------
# PASTA_RAIZ = .../desafio_transparencia (a pasta deste arquivo)
PASTA_RAIZ = Path(__file__).resolve().parents[1]
# onde o .zip e os .csv ficam (ignorada pelo Git)
PASTA_DADOS = PASTA_RAIZ / "data"


# ---------------------------------------------------------------------------
# Leitura simples do arquivo .env (sem biblioteca externa)
# ---------------------------------------------------------------------------
def carregar_env():
    """Le o arquivo .env (se existir) e joga as variaveis para os.environ."""
    arquivo_env = PASTA_RAIZ / ".env"
    if not arquivo_env.exists():
        return
    for linha in arquivo_env.read_text(encoding="utf-8").splitlines():
        linha = linha.strip()
        # ignora linhas vazias e comentarios
        if not linha or linha.startswith("#") or "=" not in linha:
            continue
        chave, valor = linha.split("=", 1)
        os.environ.setdefault(chave.strip(), valor.strip())


carregar_env()


# ---------------------------------------------------------------------------
# Credenciais do MySQL (vem do .env)
# ---------------------------------------------------------------------------
MYSQL_CONFIG = {
    "host": os.environ.get("MYSQL_HOST", "localhost"),
    "port": int(os.environ.get("MYSQL_PORT", "3306")),
    "user": os.environ.get("MYSQL_USER", "root"),
    "password": os.environ.get("MYSQL_PASSWORD", ""),
    "database": os.environ.get("MYSQL_DATABASE", "transparencia"),
}


# ---------------------------------------------------------------------------
# O que vamos baixar e processar
# ---------------------------------------------------------------------------
ANO = "2025"

# ---- De onde baixar o .zip ----
DRIVE_FILE_ID = "1Sru-TYSYo-cn-L9WW2DUwhyIUdkM3fIe"

# Tamanho do bloco de leitura/insercao (numero de linhas por vez).

TAMANHO_BLOCO = 50_000

# ---------------------------------------------------------------------------
# Mapeamento: cada arquivo CSV dentro do .zip -> tabela RAW correspondente
# (o nome do CSV usa o ANO como prefixo, ex.: 2025_Viagem.csv)
# ---------------------------------------------------------------------------
ARQUIVOS = {
    "viagem": {"csv": f"{ANO}_Viagem.csv", "tabela_raw": "raw_viagem"},
    "pagamento": {"csv": f"{ANO}_Pagamento.csv", "tabela_raw": "raw_pagamento"},
    "passagem": {"csv": f"{ANO}_Passagem.csv", "tabela_raw": "raw_passagem"},
    "trecho": {"csv": f"{ANO}_Trecho.csv", "tabela_raw": "raw_trecho"},
}

# Caracteristicas dos arquivos CSV do Portal da Transparencia:
CSV_SEPARADOR = ";"
CSV_ENCODING = "latin-1"  # acentuacao no padrao ISO-8859-1
