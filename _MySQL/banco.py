"""
banco.py
--------
"""

import mysql.connector
import sys
from pathlib import Path
from mysql.connector import Error

from _MySQL.config import MYSQL_CONFIG

def conectar():
    """
    Abre uma conexao com o MySQL (no database configurado no .env) e a retorna.
    Em caso de falha, lanca um erro claro (tratado por quem chama).
    """
    try:
        return mysql.connector.connect(**MYSQL_CONFIG)
    except Error as erro:
        raise RuntimeError(
            f"Nao foi possivel conectar ao MySQL em "
            f"{MYSQL_CONFIG['host']}:{MYSQL_CONFIG['port']} / database "
            f"'{MYSQL_CONFIG['database']}'. Verifique o .env e se voce ja rodou "
            f"o script '0_criar_banco.sql'. Detalhe: {erro}"
        )


def executar(conexao, sql):
    """Executa um comando SQL simples (CREATE, DROP, INSERT...SELECT, etc.)."""
    cursor = conexao.cursor()
    cursor.execute(sql)
    conexao.commit()
    cursor.close()


def inserir_em_lote(conexao, sql_insert, linhas):
    """
    Insere varias linhas de uma vez (mais rapido que uma a uma).
    'linhas' e uma lista de tuplas; 'sql_insert' usa %s nos valores.
    """
    if not linhas:
        return
    cursor = conexao.cursor()
    cursor.executemany(sql_insert, linhas)
    conexao.commit()
    cursor.close()

