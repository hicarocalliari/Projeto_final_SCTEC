from pathlib import Path
import sys
import zipfile
import pandas as pd
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import gdown
from database import banco
from database import config
from database.config import PASTA_DADOS
from database.config import DRIVE_FILE_ID

def baixar_base_drive():

    config.PASTA_DADOS.mkdir(exist_ok=True)

    destino = PASTA_DADOS / "viagens_2025_6meses.zip"

    if destino.exists():
        print ("O arquivo já foi baixado antes, não será necessário baixá-lo novamente")
    else:
        print ("Iniciando o Download...")
        gdown.download(id=DRIVE_FILE_ID,output=str(destino))


def localizar_zip():
    """Aponta para o viagens_2025_6meses.zip que foi feito o download do drive."""
    caminho = config.PASTA_DADOS / "viagens_2025_6meses.zip"
    if not caminho.exists():
        raise FileNotFoundError(
            "Arquivo nao encontrado: baixe o 'viagens_2025_6meses.zip' do Drive e "
            f"coloque-o na pasta '{config.PASTA_DADOS}' antes de rodar este script."
        )
    return caminho


def carregar_csv(conexao, zip_aberto, nome_csv, tabela):
    """Le um CSV de dentro do zip e insere todas as linhas na tabela do MySQL.

    As colunas do CSV estao na MESMA ordem das colunas da tabela
    (definidas no 0_criar_banco.txt). Por isso conseguimos inserir "na ordem",
    sem precisar escrever o nome de cada coluna.
    """
    print("      Carregando", tabela, "...")

    # esvazia a tabela antes de carregar (assim, rodar de novo nao duplica dados)
    banco.executar(conexao, f"TRUNCATE TABLE {tabela}")

    total = 0
    with zip_aberto.open(nome_csv) as arquivo:
        # le o CSV em pedacos, para nao encher a memoria do PC em bases grandes
        pedacos = pd.read_csv(
            arquivo,
            sep=config.CSV_SEPARADOR,    # colunas separadas por ponto-e-virgula
            encoding=config.CSV_ENCODING,  # acentuacao em latin-1
            dtype=str,                   # tudo como texto (camada RAW)
            keep_default_na=False,       # campo vazio continua "" (nao vira "NaN")
            chunksize=config.TAMANHO_BLOCO,
        )
        for pedaco in pedacos:
            linhas = pedaco.values.tolist()
            # um "%s" para cada coluna do CSV
            marcadores = ", ".join(["%s"] * len(pedaco.columns))
            comando = f"INSERT INTO {tabela} VALUES ({marcadores})"
            banco.inserir_em_lote(conexao, comando, linhas)
            total += len(linhas)

    print("      ->", total, "linhas em", tabela)  


def main():
    print("=== FASE 1: EXTRACAO + CAMADA RAW ===\n")
    print ("Realizando o Download da base de dados do Drive\n")
    baixar_base_drive()
    print ("\nRealizando a Ingestão dos dados nas suas respectivas tabelas RAW\n")
    try:
        conexao = banco.conectar()
        caminho_zip = localizar_zip()

        with zipfile.ZipFile(caminho_zip) as zip_aberto:
            for arquivo in config.ARQUIVOS.values():
                carregar_csv(
                    conexao, zip_aberto, arquivo["csv"], arquivo["tabela_raw"]
                )
        conexao.close()
        print("\n=== Camada RAW concluida com sucesso! ===")
    except Exception as erro:
        print("[ERRO] Algo deu errado:", erro)
        raise

if __name__ == "__main__":
    main()
