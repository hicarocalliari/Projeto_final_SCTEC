import sys
import warnings
import zipfile
from pathlib import Path

import gdown
import pandas as pd
from _MySQL import banco


def limpar_silver(conexao, lista_silver):
    print("Iniciando a limpeza das tabelas Silver...")
    contador_silver = 0
    for silver in lista_silver:
        banco.executar(conexao, "DELETE FROM " + silver)
        contador_silver += 1
    print(f"Limpeza Concluída\nForam limpas o total de {contador_silver} tabelas")


def popular_silver(conexao,silver,sql):
    banco.executar(conexao,silver,sql)
