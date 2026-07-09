import datetime

def limpar_dinheiro(valor):
    texto = str(valor).strip().replace("R$", "").strip()
    if "," in texto:
        texto = texto.replace(".", "").replace(",", ".")
    return round(float(texto), 2)

def limpar_texto(valor):
    return str(valor).strip().title()

def limpar_data(valor):
    """PRATICA 2.2 · data em texto BR (dd/mm/aaaa) -> objeto date (ISO).
    Esperado: '03/03/2017' -> 2017-03-03.
    """
    return datetime.strptime(str(valor).strip(), "%d/%m/%Y").date()

def testeImportacao():
    print ("teste")