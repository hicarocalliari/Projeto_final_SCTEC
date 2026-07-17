## Projeto Final SCTEC Módulo 01 - Hicaro Calliari Bottenberg - ANÁLISE DE DADOS T2

Projeto de Análise de Dados desenvolvido com o objetivo de aplicar, na prática, os conhecimentos adquiridos na construção de um pipeline de dados completo (ETL) e na implementação da Arquitetura Medallion, utilizando as camadas Raw, Silver e Gold com Python e SQL.

O projeto contempla todas as etapas do fluxo de dados, desde a extração e ingestão dos dados brutos até o tratamento, transformação, modelagem e geração de análises estratégicas para apoio à tomada de decisão.

Foi utilizada uma base de dados real, disponibilizada para download pelo portal do Senai, composta por informações provenientes de quatro tabelas do Portal da Transparência. Os dados inicialmente desestruturados passaram por processos de limpeza, padronização, integração e organização, resultando em uma estrutura analítica preparada para consultas e geração de indicadores.

## OBJETIVO

* Baixar os dados de Viagens a Serviço direto da fonte oficial, sem intervenção manual;
* Preservar o dado original fielmente na camada Raw, garantindo rastreabilidade e auditoria de qualquer transformação futura;
* Limpar e organiza os dados na camada Silver, com tipagem correta e integridade referencial entre as tabelas , eliminando inconsistências, duplicidades e erros de formato;
* Responder perguntas de negócio reais na camada Gold, tudo isso apoiado por métricas e gráficos que tornam a informação acessível para quem for tomar decisões.

## Tecnologias Utilizadas
- Python
- Pandas
- Jupyter Notebook

## Estrutura do projeto
```text
├── data
│   └── viagens_2025_6meses.zip
├── database
│   ├── banco.py
│   ├── config.py
│   └── __pycache__
├── notebooks
│   └── analise.ipynb
├── README.md
├── scripts
│   ├── extrair.py
│   ├── __pycache__
│   └── transformar.py
├── sql
    ├── ddl
    ├── gold
    └── silver
```
## Como Executar o Projeto

```text
1º Clone o repositório através da URL:
    https://github.com/hicarocalliari/Projeto_final_SCTEC.git

2º Acesse a pasta do projeto e navegue até o diretório:
    Projeto_final_SCTEC

3º Crie e ative o ambiente virtual (venv):

    Linux:
        python3 -m venv venv
        source venv/bin/activate

    Windows (Prompt de Comando):
        python -m venv venv
        venv\Scripts\activate

4º Instale as dependências necessárias executando o comando:

    pip install -r requirements.txt

    O arquivo requirements.txt contém todos os pacotes necessários para execução do projeto, como pandas, matplotlib e demais bibliotecas utilizadas.

```
## Estrutura da Camada Bronze
### Composta pelas tabelas Raw, responsáveis pela ingestão dos dados originais provenientes da fonte oficial, mantendo sua estrutura inicial e garantindo a rastreabilidade das informações.

<img width="928" height="569" alt="image" src="https://github.com/user-attachments/assets/000d55d8-aacd-41d2-93d9-3dc30666283e" />

## Estrutura da Camada Silver
### Baseada nos dados da camada Bronze, aplicando tipagem correta, tratamento, padronização e enriquecimento das tabelas com novas informações relevantes.

<img width="883" height="767" alt="image" src="https://github.com/user-attachments/assets/e10bbcb3-b978-4e67-b0b1-639e6dbcb6ec" />

## Perguntas a serem respondidas:
1. Os 5 órgãos com maior custo total?
2. Os 3 destinos com maior custo médio por viagem?
3. A viagem de maior duração e seu custo total?
4. Qual o tipo de pagamento com maior valor médio?
5. Qual o meio de transporte mais usado nos trechos?
6. Qual UF de destino aparece em mais trechos?
7. Qual órgão pagou mais no total?

## Respostas:

1. Os 5 órgãos com maior custo total?

<img width="1076" height="641" alt="image" src="https://github.com/user-attachments/assets/e90ba61b-8b7d-4837-a54a-9c7ae3b665f2" />
<img width="624" height="196" alt="image" src="https://github.com/user-attachments/assets/6f506aad-e780-4eae-8fe1-5b399a228e57" />

2. Os 3 destinos com maior custo médio por viagem?
<img width="1077" height="639" alt="image" src="https://github.com/user-attachments/assets/cd7e972e-97ca-45a5-bfd8-e7cec61f8c7d" />
<img width="356" height="133" alt="image" src="https://github.com/user-attachments/assets/dfdc7334-93ab-46fa-bced-5987ce365fa5" />

3. A viagem de maior duração e seu custo total?
<img width="1074" height="640" alt="image" src="https://github.com/user-attachments/assets/de294a6b-d536-4117-8bda-4789c791f9b9" />
<img width="985" height="73" alt="image" src="https://github.com/user-attachments/assets/edced213-f881-4d69-b41e-6fa4eeafd3d2" />

4. Qual o tipo de pagamento com maior valor médio?
<img width="855" height="699" alt="image" src="https://github.com/user-attachments/assets/cb86fa61-53b0-435a-aea8-635710770281" />
<img width="337" height="138" alt="image" src="https://github.com/user-attachments/assets/62a2bb6d-2dfd-4785-a09d-365a704b8391" />

5. Qual o meio de transporte mais usado nos trechos?
<img width="792" height="515" alt="image" src="https://github.com/user-attachments/assets/c043a63e-9ff0-4169-bc96-e50786a39f04" />
<img width="261" height="157" alt="image" src="https://github.com/user-attachments/assets/27effead-de31-4e94-a2bb-bb7cbd933e31" />

6. Qual UF de destino aparece em mais trechos?
<img width="572" height="519" alt="image" src="https://github.com/user-attachments/assets/d6c80a18-0821-47c0-bb3b-c12a8b3a4753" />
<img width="246" height="160" alt="image" src="https://github.com/user-attachments/assets/0dcad47f-25b7-4bf3-8274-588ed7fa7af1" />

7. Qual órgão pagou mais no total?
<img width="995" height="552" alt="image" src="https://github.com/user-attachments/assets/6f04bc1b-9372-4130-ae8a-4b956dba3549" />
<img width="437" height="167" alt="image" src="https://github.com/user-attachments/assets/7eb8766b-6e15-41d5-9402-feecd797db8b" />

