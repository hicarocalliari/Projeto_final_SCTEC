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
## Estrutura da Camada Bronze
### Composta pelas tabelas Raw, responsáveis pela ingestão dos dados originais provenientes da fonte oficial, mantendo sua estrutura inicial e garantindo a rastreabilidade das informações.

<img width="928" height="569" alt="image" src="https://github.com/user-attachments/assets/000d55d8-aacd-41d2-93d9-3dc30666283e" />

## Estrutura da Camada Silver
### Baseada nos dados da camada Bronze, aplicando tipagem correta, tratamento, padronização e enriquecimento das tabelas com novas informações relevantes.

<img width="883" height="767" alt="image" src="https://github.com/user-attachments/assets/e10bbcb3-b978-4e67-b0b1-639e6dbcb6ec" />

