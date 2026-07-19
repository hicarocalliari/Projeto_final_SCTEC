"""
banco.py
--------
"""

import mysql.connector
import sys
from pathlib import Path
from mysql.connector import Error

from database.config import MYSQL_CONFIG


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


def consultar(conexao, sql):
    """
    Executa uma consulta SQL e retorna todos os registros encontrados.

    A função cria um cursor, executa a consulta SQL informada,
    recupera todos os registros utilizando `fetchall()` e fecha o
    cursor antes de retornar os resultados.

    Args:
        conexao: Objeto de conexão ativo com o banco de dados.
        sql (str): Consulta SQL a ser executada.

    Returns:
        list[tuple]: Lista de tuplas contendo os registros retornados
            pela consulta.

    Raises:
        Exception: Repassa qualquer exceção gerada durante a execução
            da consulta SQL.
    """
    cursor = conexao.cursor()
    cursor.execute(sql)
    resultado = cursor.fetchall()
    cursor.close()
    return resultado


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
