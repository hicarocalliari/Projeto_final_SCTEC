## Projeto Final SCTEC Módulo 01 - Hicaro Calliari Bottenberg - ANÁLISE DE DADOS T2

Projeto de Análise de Dados desenvolvido com o objetivo de aplicar, na prática, os conhecimentos adquiridos na construção de um pipeline de dados completo (ETL) e na implementação da Arquitetura Medallion, utilizando as camadas Raw, Silver e Gold com Python e SQL.

O projeto contempla todas as etapas do fluxo de dados, desde a extração e ingestão dos dados brutos até o tratamento, transformação, modelagem e geração de análises estratégicas para apoio à tomada de decisão.

Foi utilizada uma base de dados real, disponibilizada para download pelo portal do Senai, composta por informações provenientes de quatro tabelas do Portal da Transparência. Os dados inicialmente desestruturados passaram por processos de limpeza, padronização, integração e organização, resultando em uma estrutura analítica preparada para consultas e geração de indicadores.

## OBJETIVO

* Baixar os dados de Viagens a Serviço direto da fonte oficial, sem intervenção manual;
* Preservar o dado original fielmente na camada Raw, garantindo rastreabilidade e auditoria de qualquer transformação futura;
* Limpar e organiza os dados na camada Silver, com tipagem correta e integridade referencial entre as tabelas , eliminando inconsistências, duplicidades e erros de formato;
* Responder perguntas de negócio reais na camada Gold, tudo isso apoiado por métricas e gráficos que tornam a informação acessível para quem for tomar decisões.

## Qual problema resolve?

Este projeto resolve o desafio de transformar dados públicos brutos em informações estruturadas e confiáveis para análise, através da construção de um pipeline de dados organizado em camadas.

O pipeline permite:

- Realizar a ingestão dos dados para a camada Bronze (`Raw`), preservando os dados originais e garantindo rastreabilidade para auditoria e futuras análises;
- Estruturar e padronizar os dados na camada Silver, realizando tratamentos de tipos, conversões, validações e relacionamentos entre tabelas através de chaves primárias e estrangeiras;
- Manter os dados tratados em uma estrutura analítica confiável, servindo como base para a criação dos indicadores e análises da camada Gold;
- Criar tabelas analíticas e views para disponibilizar informações de negócio de forma simplificada, reutilizável e otimizada para consultas.
  

## Tecnologias Utilizadas
- Python
- Pandas
- Matplotlib
- Jupyter Notebook
- Banco de dados Mysql

## Como Executar o Projeto


## Como executar o projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/hicarocalliari/Projeto_final_SCTEC.git
   ```

2. Acesse a pasta do projeto:

   ```bash
   cd Projeto_final_SCTEC
   ```

3. Crie e ative o ambiente virtual (venv).

   **Linux**

   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```

   **Windows (Prompt de Comando)**

   ```cmd
   python -m venv venv
   venv\Scripts\activate
   ```

4. Instale as dependências do projeto:

   ```bash
   pip install -r requirements.txt
   ```

   O arquivo `requirements.txt` contém todas as bibliotecas necessárias para a execução do projeto, incluindo o **ipykernel**, utilizado para executar o notebook no ambiente virtual.

5. Configure as variáveis de ambiente.

   * Abra o arquivo `env.example`;

   * Altere o valor de:

     ```text
     MYSQL_PASSWORD=sua_senha_aqui
     ```

   * Renomeie o arquivo para `.env`;

   * Salve as alterações.

6. Crie o banco de dados no MySQL.

   Na pasta `sql/ddl` encontra-se o arquivo `criar_banco.sql`, responsável por criar o banco de dados e todas as tabelas necessárias para a execução do projeto.

7. Execute os scripts na seguinte ordem:

   1. `scripts/extrair.py`
   2. `scripts/transformar.py`

8. Abra o arquivo `notebooks/analise.ipynb` no Visual Studio Code.

9. Selecione o kernel do ambiente virtual.

   * Clique em **Select Kernel** (ou no nome do kernel exibido no canto superior direito do notebook);
   * Escolha o interpretador correspondente ao ambiente virtual (`venv`);
   * Caso seja solicitado, selecione o kernel associado ao ambiente criado.

10. Execute todas as células do notebook `notebooks/analise.ipynb` na ordem em que estão organizadas.

```

## Estrutura do projeto
```text
├── database
│   ├── banco.py
│   └── config.py
├── img
│   └──gráficos
├── notebooks
│   └── analise.ipynb
├── scripts
│   ├── extrair.py
│   ├── __pycache__
│   └── transformar.py
├── sql
│   ├── ddl
│   ├── gold
│   └── silver
├── README.md
├── requirements.txt
└── .env.example
```

## Estrutura da Camada Bronze
### Composta pelas tabelas Raw, responsáveis pela ingestão dos dados originais provenientes da fonte oficial, mantendo sua estrutura inicial e garantindo a rastreabilidade das informações.

| **Tabela** | **Linhas carregadas** |
|---|---|
| raw_viagem | 341860 linhas  |
| raw_pagamento | 606916 linhas |
| raw_passagem | 167260 linhas |
| raw_trecho | 763349 linhas |

<img width="928" height="569" alt="image" src="https://github.com/user-attachments/assets/000d55d8-aacd-41d2-93d9-3dc30666283e" />

## Estrutura da Camada Silver
### Baseada nos dados da camada Bronze, aplicando tipagem correta, tratamento, padronização e enriquecimento das tabelas com novas informações relevantes.

<img width="883" height="767" alt="image" src="https://github.com/user-attachments/assets/e10bbcb3-b978-4e67-b0b1-639e6dbcb6ec" />

| **Transformação Raw → Silver** | **Resultado** |
|---|---|
| Chaves primárias | Criadas chaves primárias nas tabelas Silver (`id_viagem`, `id_passagem`, `id_pagamento` e `id_trecho`) |
| Chaves estrangeiras | Criados relacionamentos entre tabelas através de `id_viagem` referenciando `silver_viagem` |
| Coluna `valor_total` | Nova coluna criada em `silver_viagem`, calculada a partir dos valores de diárias, passagens, devolução e outros gastos |
| Coluna `duracao_dias` | Nova coluna criada em `silver_viagem`, calculada a partir das datas de início e fim da viagem |
| Tipos de dados | Conversão de campos `VARCHAR` da Raw para tipos adequados na Silver (`DATE`, `DECIMAL` e `INT`) |
| Campos monetários | Conversão dos valores financeiros de `VARCHAR` para `DECIMAL(10,2)` |
| Datas | Conversão dos campos de data de `VARCHAR` para `DATE` |
| Restrições NOT NULL | Adicionada obrigatoriedade em campos essenciais (`id_viagem`, `nome_orgao_superior` e `tipo_pagamento`) |
| Constraints CHECK | Criadas validações para impedir valores negativos em campos financeiros e quantidade de diárias |
| Identificadores automáticos | Criados campos `AUTO_INCREMENT` para `id_passagem`, `id_pagamento` e `id_trecho` |
| Unicidade dos trechos | Criada constraint UNIQUE para evitar duplicidade de sequência de trechos por viagem (`id_viagem`, `sequencia_trecho`) |
| Normalização dos dados | Separação das informações em tabelas de viagem, passagem, pagamento e trecho |

## Estrutura da Camada Gold

A camada `Gold` foi construída a partir dos dados previamente tratados e padronizados na camada `Silver`. Nessa etapa, foram criadas tabelas analíticas e suas respectivas `views`, destinadas à consulta e ao consumo dos dados.

Para a construção dessas estruturas, foram utilizadas consultas SQL com operações como `JOIN` e `GROUP BY`, permitindo a integração das tabelas por meio de suas chaves primárias e estrangeiras, bem como a realização de agregações necessárias para responder às perguntas de negócio.

Os dados disponibilizados na camada `Gold` servem como base para análises, identificação de padrões, extração de indicadores e geração de insights, proporcionando uma visão consolidada e otimizada para a tomada de decisão.

## Perguntas a serem respondidas:
1. Os 5 órgãos com maior custo total?
2. Os 3 destinos com maior custo médio por viagem?
3. A viagem de maior duração e seu custo total?
4. Qual o tipo de pagamento com maior valor médio?
5. Qual o meio de transporte mais usado nos trechos?
6. Qual UF de destino aparece em mais trechos?
7. Qual órgão pagou mais no total?
8. Qual meio de transporte possui maior custo medio viagem?
9. Destinos com maior custo total ?
10. Viajantes com maior custo total ?

# Respostas:

## 1. Os 5 órgãos com maior custo total?

![Os 5 órgãos com maior custo total](img/grafico_1.png)

![Os 5 órgãos com maior custo total](img/df_pergunta_1.png)

## 2. Os 3 destinos com maior custo médio por viagem?
   
![Os 3 destinos com maior custo médio por viagem](img/grafico_2.png)

![Os 3 destinos com maior custo médio por viagem](img/df_pergunta_2.png)

## 3. A viagem de maior duração e seu custo total?
   
![A viagem de maior duração e seu custo total](img/grafico_3.png)

![A viagem de maior duração e seu custo total](img/df_pergunta_3.png)

## 4. Qual o tipo de pagamento com maior valor médio?

![Tipo de pagamento com maior valor médio](img/grafico_4.png)

![Tipo de pagamento com maior valor médio](img/df_pergunta_4.png)

## 5. Qual o meio de transporte mais usado nos trechos?

![Meio de transporte mais usado nos trechos](img/grafico_5.png)

![Meio de transporte mais usado nos trechos](img/df_pergunta_5.png)

## 6. Qual UF de destino aparece em mais trechos?

![UF de destino aparece em mais trechos](img/grafico_6.png)

![UF de destino aparece em mais trechos](img/df_pergunta_6.png)

## 7. Qual órgão pagou mais no total?

![Órgão pagou mais no total](img/grafico_7.png)

![Órgão pagou mais no total](img/df_pergunta_7.png)

## 8. Qual meio de transporte possui maior custo medio viagem?

![meio_transporte_maior_custo_medio_viagem](img/grafico_9.png)

![meio_transporte_maior_custo_medio_viagem](img/df_pergunta_9.png)

## 9. Destinos com maior custo total

![destinos_maior_custo_total](img/grafico_9.png)

![destinos_maior_custo_total](img/df_pergunta_9.png)

## 10. Viajantes com maior custo total

![viajantes_maior_custo_total](img/grafico_10.png)

![viajantes_maior_custo_total](img/df_pergunta_10.png)

# Conclusões

Com base nas análises realizadas sobre os dados da camada Silver, foi possível identificar os seguintes pontos:

1. Os gastos com viagens encontram-se concentrados em alguns órgãos, com destaque para os órgãos relacionados à Segurança Pública.
2. O uso de veículos oficiais representa o meio de transporte mais utilizado nas viagens analisadas.
3. São Paulo está entre os destinos com maior frequência de viagens, demonstrando sua relevância nas atividades administrativas.
4. Brasília apresentou o maior volume de gastos com viagens, indicando seu papel como principal destino para deslocamentos institucionais.
5. Foram identificados registros classificados como **SIGILOSO**, **SEM INFORMAÇÃO** e **NÃO INFORMADO**, evidenciando limitações na disponibilidade de alguns dados e a necessidade de considerar essas ocorrências durante as análises.

# Melhorias Futuras

Como evolução do projeto, podem ser implementadas as seguintes melhorias:

* Desenvolvimento de dashboards interativos no **Power BI**, permitindo a visualização dinâmica dos indicadores e facilitando a análise dos dados.
* Implementação de uma ferramenta de orquestração de pipelines (como Apache Airflow), automatizando a execução dos processos de extração, transformação e carga (ETL).
* Agendamento da atualização automática dos dados, garantindo que as análises reflitam informações sempre atualizadas.
* Inclusão de novos indicadores e métricas analíticas para ampliar a capacidade de monitoramento e apoio à tomada de decisão.

