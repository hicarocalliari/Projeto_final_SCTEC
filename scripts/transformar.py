from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from database import banco

PASTA_SQL = Path("sql") / "silver"

lista_limpar_silver = [
    "silver_pagamento",
    "silver_passagem",
    "silver_trecho",
    "silver_viagem",
]

lista_carga_silver = [
    "insert_silver_viagem",
    "update_silver_viagem",
    "insert_silver_passagem",
    "insert_silver_pagamento",
    "insert_silver_trecho",
]


def carregar_sql(caminho):
    with open(caminho, "r", encoding="utf-8") as arquivo:
        return arquivo.read()


def limpar_silver(conexao, lista_silver):

    print("Iniciando a limpeza das tabelas Silver...")
    contador_silver = 0
    for silver in lista_silver:
        banco.executar(conexao, f"DELETE FROM {silver}")
        contador_silver += 1
    print(f"Limpeza concluída\n" f"Foram limpas {contador_silver} tabelas")


def main():

    conexao = None

    try:
        conexao = banco.conectar()
        limpar_silver(conexao, lista_limpar_silver)
        conexao.close()
    except Exception as erro:
        print("[ERRO] Algo deu errado:", erro)
        raise

    conexao = None

    try:
        conexao = banco.conectar()

        for tabela in lista_carga_silver:
            arquivo_sql = PASTA_SQL / f"{tabela}.sql"
            print (f"Executando o arquivo: {tabela}.sql")
            sql = carregar_sql(arquivo_sql)
            banco.executar(conexao,sql)
            #etl.executar_sql(conexao, f"Carga {tabela}", sql)
            

    except Exception as erro:
        print("[ERRO] Algo deu errado:", erro)
        raise

    finally:

        if conexao:
            conexao.close()
            print("Arquivos Carregados com sucesso !")


if __name__ == "__main__":
    main()
