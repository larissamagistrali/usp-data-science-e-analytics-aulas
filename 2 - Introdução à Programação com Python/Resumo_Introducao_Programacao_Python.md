# 🐍 Resumo - Introdução à Programação com Python

## MBA em Data Science e Analytics USP/ESALQ

---

## 🎯 Objetivo do Módulo

Desenvolver conhecimentos fundamentais da linguagem Python aplicados à análise de dados, incluindo manipulação de dados, estruturas de programação, funções, iterações e visualização de dados para ciência de dados.

---

## 📚 Conteúdo Principal

### 1. **Ambiente de Desenvolvimento - Spyder**

#### 1.1 Apresentação do Spyder

- **Python**: linguagem de programação para análise de dados
- **Spyder**: IDE (Integrated Development Environment) que facilita o uso do Python
- **Interface dividida em 4 partes**:
  - Script: histórico de códigos do projeto
  - Console: execução interativa de comandos
  - Ambiente: objetos e plots criados
  - Ajuda: documentação e arquivos do projeto

#### 1.2 Organização de Projects

- **Projects no Spyder**: facilita organização e compartilhamento
- **Scripts**: guardam histórico das análises
- **Células (#%%)**: organizam o script em blocos executáveis
- **Execução**: Shift + Enter (célula completa) ou F9 (linha selecionada)

#### 1.3 Comentários e Códigos

- **Comentários**: iniciam com `#` (textos explicativos)
- **Comandos**: digitados diretamente (instruções Python)
- **Erros vs Warnings**:
  - Erros: impedem execução do código
  - Warnings: avisos que não param a execução

---

### 2. **Operações Básicas e Pacotes**

#### 2.1 Operações Aritméticas Básicas

```python
print(5 + 10)      # Adição
print(20 - 6)      # Subtração
print(30 * 3)      # Multiplicação
print(200 / 10)    # Divisão
print(5 ** 3)      # Exponenciação
```

#### 2.2 Instalação e Importação de Pacotes

**Instalação** (executar no console):

```python
# pip install pandas
# pip install numpy
# pip install matplotlib
# pip install seaborn
# pip install plotly
```

**Importação**:

```python
import math
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
```

- **Apelidos (aliases)**: convenção para facilitar uso (np, pd)
- **Toda sessão**: necessário reimportar os pacotes

---

### 3. **Tipos de Dados e Objetos**

#### 3.1 Listas

```python
# Lista de números
lista_numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(lista_numeros[0] + lista_numeros[3])  # Índice inicia em 0!

# Lista de textos
lista_textos = ['Brasil', 'Argentina', 'Chile', 'Peru', 'Uruguai']
print(lista_textos[0] + ' e ' + lista_textos[1])
```

**Importante**: Índices em Python começam em 0!

#### 3.2 Series do Pandas

**Series Numéricas**:

```python
numeros = pd.Series([10, 20, 30, 40, 50, 60, 70, 80])
```

**Series de Caracteres**:

```python
cores = pd.Series(["Vermelho", "Amarelo", "Azul", "Verde", "Roxo"])
```

**Series Lógicas**:

```python
logico = pd.Series([True, False, True, True, False, False])
```

**Series Categóricas**:

```python
tipos = pd.Series(["TipoA", "TipoB", "TipoB", "TipoA", "TipoC"],
                  dtype="category")
```

#### 3.3 Classes de Objetos

```python
type(1)           # int (inteiro)
type(2.75)        # float (decimal)
type("Azul")      # str (string/texto)
type(True)        # bool (booleano)
type(cores)       # pandas.core.series.Series
```

#### 3.4 Comprimento de Objetos

```python
len(numeros)        # Número de elementos
len(lista_textos)   # Tamanho da lista
```

#### 3.5 Sequências com NumPy

```python
# Gera sequência de 1 a 9 (exclui o último)
sequencia_1 = np.arange(1, 10)

# Gera sequência com incrementos de 0.5
sequencia_2 = np.arange(1, 10, 0.5)
```

---

### 4. **Operadores e Comparações**

#### 4.1 Operadores Relacionais

- `==` : Igual
- `!=` : Diferente
- `>` : Maior
- `>=` : Maior ou igual
- `<` : Menor
- `<=` : Menor ou igual

#### 4.2 Operadores Lógicos

- `&` : E (and)
- `|` : Ou (or)

#### 4.3 Exemplos de Comparações

```python
# Igualdade
print(numeros == 20)

# Multiplicação
print(numeros * 2)

# Criando novo objeto com resultado
triplo_numeros = numeros * 3
metade_numeros = numeros / 2

# Comparando textos
print(cores != "Amarelo")

# Comparando números
print(sequencia_2 > 5)
print(sequencia_2 >= 4.5)
```

---

### 5. **DataFrames**

#### 5.1 Dicionários

```python
dict_uf = {"estado": "SP",
           "regiao": "Sudeste"}

print(dict_uf["estado"])   # Acessa valor pela chave

# Adicionar elemento
dict_uf["pais"] = "Brasil"
```

#### 5.2 Criando DataFrames

```python
# DataFrame básico
dataset_1 = pd.DataFrame({'id': ["obs_1", "obs_2", "obs_3"],
                          'idade': [60, 28, 53]})

# DataFrame com variáveis criadas
varA = np.arange(1, 11)
varB = pd.Series([1, 2, 3, 4, 5, 6, 7, 8, None, None])
varC = pd.Series(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"])

dataset_2 = pd.DataFrame({'varA': varA,
                          'varB': varB,
                          'varC': varC})
```

**Importante**: `None` representa valores ausentes (missing values/NA)

---

### 6. **Importação e Exportação de Dados**

#### 6.1 Importando Dados

**Excel**:

```python
receita = pd.read_excel("receita_empresas.xlsx")
```

**CSV**:

```python
notas_pisa = pd.read_csv("notas_pisa.csv", sep=",", decimal=".")
```

**API/Link**:

```python
ipca = pd.read_csv("https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=csv",
                   sep=";", decimal=",")
```

#### 6.2 Exportando Dados

**CSV**:

```python
dataset_1.to_csv("dataset1.csv", index=False)
```

**Excel**:

```python
dataset_2.to_excel("dataset2.xlsx", index=False)
```

---

### 7. **Funções**

#### 7.1 Estrutura Básica de Funções

**3 Etapas para criar função**:

1. Nomear a função
2. Indicar os argumentos (inputs)
3. Definir o código e o retorno

#### 7.2 Função com Input Único

```python
def converter(milha):
    km = milha * 1.6093
    return km

# Testando
print(converter(60))
print(converter(100))

# Com Series
diversos_valores = pd.Series([10, 20, 30, 40, 50, 60])
valores_convertidos = converter(diversos_valores)
```

#### 7.3 Função com Múltiplos Inputs

```python
def calcular_area(b, h):
    area = b * h
    return area

print(f"{calcular_area(10, 10)}m²")
print(f"{calcular_area(20, 15)}m²")
```

#### 7.4 Condições em Funções

**If/Else**:

```python
valor = 100

if valor == 10**2:
    print("Valor Correto")
else:
    print("Valor Incorreto")
```

**If/Elif/Else**:

```python
salario = 2500

if salario <= 1518:
    print("Até 1 salário mínimo")
elif salario > 1518 and salario <= 4554:
    print("Entre 1 e 3 salários mínimos")
elif salario > 4554 and salario <= 7590:
    print("Entre 3 e 5 salários mínimos")
else:
    print("Mais de 5 salários mínimos")
```

**Função com Condição**:

```python
def quantidade_salarios(salario):
    quantidade = salario / 1518

    if quantidade <= 10:
        return quantidade
    else:
        return "Mais de 10 salários mínimos"

print(quantidade_salarios(1518))
print(quantidade_salarios(17000))
```

#### 7.5 Funções com Múltiplos Inputs e Condições

```python
def nova_area(b, h):
    calculo_area = b * h

    if calculo_area <= 10000:
        return calculo_area, "Até 1 hectare"
    elif calculo_area > 10000 and calculo_area <= 50000:
        return calculo_area, "Entre 1 e 5 hectares"
    else:
        return calculo_area, "Mais de 5 hectares"

print(nova_area(300, 25))
```

#### 7.6 Integrando Funções Existentes

```python
def coef_var(x):
    coeficiente = (np.std(x) / np.mean(x)) * 100
    return np.round(coeficiente, decimals=3)

variavel_cv = pd.Series([10, 25, 40, 35, 15, 28, 31])
print(f"{coef_var(variavel_cv)}%")
```

---

### 8. **Iterações**

#### 8.1 Loop For

```python
lista_conversao = pd.Series([60, 100, 20, 30])
lista_km = []

for i in lista_conversao:
    lista_km.append(i * 1.6093)

print(lista_km)
```

#### 8.2 Loop While

```python
saldo_investimento = 100
lista_invest = []

while saldo_investimento < 10000:
    saldo_investimento = saldo_investimento * 1.10
    lista_invest.append(saldo_investimento)

print(lista_invest)
```

---

### 9. **Manipulação de Dados**

#### 9.1 Visualizando Dados

```python
# Primeiras linhas
pisa.head(5)

# Nomes das variáveis
pisa.columns

# Informações detalhadas
pisa.info()

# Dimensões
pisa.shape           # (linhas, colunas)
pisa.shape[0]        # Número de linhas
pisa.shape[1]        # Número de colunas
```

#### 9.2 Selecionando Variáveis

```python
# Uma variável
paises_pisa = pisa['country']

# Múltiplas variáveis
pisa_reading = pisa[['country', 'reading_2018']]
```

#### 9.3 Removendo Variáveis

```python
# Removendo colunas específicas
pisa_2022 = pisa.drop(columns=['mathematics_2018', 'reading_2018'])

# Com inplace (modifica o objeto original)
pisa_2022.drop(columns=['group'], inplace=True)

# Removendo objeto do ambiente
del pisa_reading
```

#### 9.4 Seleção por Posição (iloc)

```python
# Elemento específico [linha, coluna]
pisa.iloc[46, 2]

# Observação completa (linha)
pisa.iloc[19, ]

# Múltiplas observações (range)
pisa.iloc[0:7, ]      # Linhas 0 a 6 (exclui 7!)

# Múltiplas variáveis
pisa.iloc[:, [0, 2, 5]]    # Colunas 0, 2 e 5
pisa.iloc[:, 0:3]          # Colunas 0 a 2 (exclui 3!)
```

#### 9.5 Reorganizando Variáveis

```python
pisa_ajuste = pisa.reindex(['group', 'country', 'science_2022',
                             'mathematics_2022', 'reading_2022'], axis=1)
```

#### 9.6 Excluindo Observações

```python
# Por índice
pisa_ocde = pisa.drop(pisa.index[38:96])
```

#### 9.7 Convertendo Tipos de Dados

```python
# Convertendo para numérico
pisa['mathematics_2022'] = pd.to_numeric(pisa['mathematics_2022'],
                                         errors='coerce')
```

#### 9.8 Tratamento de Valores Ausentes

```python
# Remover linhas com NA
pisa_na = pisa.dropna()
```

#### 9.9 Estatísticas Descritivas

```python
# Para variáveis quantitativas
pisa[['mathematics_2022', 'reading_2022', 'science_2022']].describe()

# Para variáveis qualitativas (frequências)
pisa['group'].value_counts()
```

#### 9.10 Filtrando Observações

```python
# Uma condição
acima_media = pisa[pisa['mathematics_2022'] > 437]

# Múltiplas condições com &
pisa_filtro = pisa[(pisa['group'] == 'OECD') & (pisa['science_2022'] <= 493)]

# Condição OU com |
extremos = pisa[(pisa['reading_2022'] < 386) | (pisa['reading_2022'] > 480)]

# Diferente de
nao_oecd = pisa[pisa['group'] != 'OECD']
```

#### 9.11 Agrupamento de Dados

```python
# Agrupar por critério
pisa_grupo = pisa.groupby(by=['group'])

# Estatísticas por grupo
pisa_grupo.describe().T     # .T transpõe a tabela
```

#### 9.12 Ordenação de Dados

```python
# Ordem decrescente
sort_matem = pisa.sort_values(by=['mathematics_2022'], ascending=False)

# Ordem crescente
sort_ciencias = pisa.sort_values(by=['science_2022'], ascending=True)
```

#### 9.13 Renomeando Variáveis

```python
# Renomear todas
nomes = ["pais", "grupo", "matematica_2022", "leitura_2022"]
pisa.columns = nomes

# Renomear uma
pisa = pisa.rename(columns={'grupo': 'grupo_paises'})
```

---

### 10. **Visualização de Dados**

#### 10.1 Bibliotecas de Visualização

```python
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
import plotly.io as pio
pio.renderers.default = 'browser'
import plotly.graph_objects as go
```

#### 10.2 Gráfico de Barras (Contagem)

```python
# Básico
plt.figure(figsize=(15, 9), dpi=600)
sns.countplot(data=comercio, x="market")
plt.show()

# Com formatação
plt.figure(figsize=(15, 9), dpi=600)
ax = sns.countplot(data=comercio, x="market", hue="market",
                   order=["APAC", "LATAM", "EU", "US"],
                   palette='viridis', legend=False)
for container in ax.containers:
    ax.bar_label(container, fontsize=12)
plt.title("Análise por Mercado", fontsize=20)
plt.xlabel('Mercado', fontsize=15)
plt.ylabel('Contagem', fontsize=15)
plt.show()
```

#### 10.3 Paletas de Cores

```python
# Paletas disponíveis
sns.color_palette("bright")
sns.color_palette("viridis")
sns.color_palette("Paired")
sns.color_palette("rocket")
sns.color_palette("pastel")
```

#### 10.4 Gráfico de Barras (Médias)

```python
# Preparar dados
comercio_agrupado = comercio[['category', 'profit']].groupby(by=['category']).mean()
comercio_agrupado = comercio_agrupado.sort_values(by=['profit'],
                                                   ascending=False).reset_index()

# Plotar
plt.figure(figsize=(15, 9), dpi=600)
ax1 = sns.barplot(data=comercio_agrupado, x='category', y='profit',
                  hue='category', palette='rocket')
for container in ax1.containers:
    ax1.bar_label(container, fmt='%.2f', padding=3, fontsize=12)
plt.title("Lucro Médio por Categoria", fontsize=20)
plt.show()
```

#### 10.5 Gráfico de Pizza

```python
# Preparar dados
pizza = pd.crosstab(index=comercio['segment'], columns='segmento',
                    normalize=True).sort_values('segmento', ascending=False)

# Plotar
plt.figure(figsize=(15, 9), dpi=600)
plt.pie(pizza['segmento'],
        labels=pizza.index,
        colors=sns.color_palette('pastel'),
        autopct='%.0f%%',
        textprops={'fontsize': 20})
plt.title('Análise por Segmento', fontsize=20)
plt.show()
```

#### 10.6 Histograma

```python
# Básico
plt.figure(figsize=(15, 9), dpi=600)
sns.histplot(data=comercio, x="sales", bins=50)
plt.xlabel('Valor das Vendas', fontsize=15)
plt.ylabel('Frequência', fontsize=15)
plt.show()

# Com KDE e formatação
plt.figure(figsize=(15, 9), dpi=600)
ax2 = sns.histplot(data=hist_vendas, x="sales", bins=range(0, 1100, 100),
                   color='blue', alpha=0.6, kde=True)
ax2.bar_label(ax2.containers[0], fontsize=12)
plt.show()
```

#### 10.7 Gráfico de Dispersão (Scatterplot)

```python
# Básico
plt.figure(figsize=(15, 9), dpi=600)
sns.scatterplot(data=atlas, x="renda", y="escolaridade")
plt.show()

# Com tamanho, cor e estilo
plt.figure(figsize=(15, 9), dpi=600)
sns.scatterplot(data=atlas, x="renda", y="escolaridade",
                size="idade", hue="indica_favel", style="mort")
plt.title("Indicadores dos Distritos de São Paulo", fontsize=20)
plt.legend(bbox_to_anchor=(1, 1), fontsize=9)
plt.show()

# Com linha de regressão
plt.figure(figsize=(15, 9), dpi=600)
sns.regplot(data=atlas, x="renda", y="escolaridade", ci=None)
plt.show()
```

#### 10.8 Gráfico de Linhas

```python
# Estático (Seaborn)
plt.figure(figsize=(15, 9), dpi=600)
sns.lineplot(data=receita, x="ano", y="receita",
             hue="id_empresa", marker="o")
plt.title("Receita de Vendas", fontsize=20)
plt.legend(title='Empresa', loc='upper left', fontsize=12)
plt.show()

# Interativo (Plotly)
fig_line = px.line(receita,
                   x='ano',
                   y='receita',
                   color='id_empresa',
                   markers=True,
                   title='Receita de Vendas',
                   labels={"ano": "Ano",
                           "receita": "Receita Anual",
                           "id_empresa": "Empresa"})
fig_line.show()

# Salvar gráfico interativo
fig_line.write_html('grafico_linhas.html')
```

#### 10.9 Gráfico de Calor (Heatmap)

```python
# Matriz de correlação de Pearson (apenas variáveis quantitativas)
corr = vendas_reg.corr()

# Plotando com Plotly (graph_objects)
fig_heat = go.Figure()

fig_heat.add_trace(
    go.Heatmap(
        x=corr.columns,
        y=corr.index,
        z=np.array(corr),
        text=corr.values,
        texttemplate='%{text:.2f}',
        colorscale='ice'))

fig_heat.update_layout(height=600, width=600)
fig_heat.show()

# Salvando a figura
fig_heat.write_html('grafico_calor.html')
```

---

## 🛠️ Ferramentas e Ambiente

### IDEs e Instalação

- **Spyder**: IDE recomendada para análise de dados
- **Anaconda**: distribuição que inclui Python, Spyder e pacotes científicos
- **Jupyter Notebook**: alternativa para análise interativa

### Recursos de Ajuda

- **Control + I**: abre documentação da função no Spyder

---

## 📊 Datasets Utilizados

- **notas_pisa.csv**: Dados do PISA (OCDE) sobre notas educacionais
- **receita_empresas.xlsx**: Receitas anuais de 5 empresas ao longo de 6 anos
- **comercio_global.xlsx**: Dados de comércio global por mercado
- **atlas_ambiental.xlsx**: Indicadores socioeconômicos dos distritos de São Paulo
- **vendas_regiao.xlsx**: Vendas de 3 produtos por região

---

## 📊 Aplicações Práticas em Data Science

### 1. Análise Exploratória de Dados (EDA)

- Importar e visualizar dados
- Calcular estatísticas descritivas
- Identificar padrões e outliers
- Criar visualizações informativas

### 2. Preparação de Dados

- Limpeza de dados (tratamento de NA)
- Transformação de tipos de dados
- Filtrar e selecionar dados relevantes
- Criar novas variáveis

### 3. Automação de Tarefas

- Criar funções personalizadas
- Usar loops para processar múltiplos arquivos
- Exportar resultados em diferentes formatos

### 4. Comunicação de Resultados

- Criar visualizações profissionais (Matplotlib/Seaborn)
- Gráficos interativos com Plotly, exportados como HTML

---

## 💡 Conceitos-Chave para Data Science

### Boas Práticas de Programação

1. **Reduzir duplicidade de código**: se um código se repete, crie uma função (facilita leitura, manutenção e evita erros de duplicação)
2. **Organização**: use células (#%%) para estruturar o script e executar blocos com Shift+Enter

### Eficiência no Python

- **Apelidos**: use `pd`, `np` para facilitar a declaração de pacotes com nomes grandes
- **Inplace**: use `inplace=True` para reescrever o objeto existente em vez de criar uma cópia

### Debugging

- **Ler mensagens de erro**: identifique se é erro (impede a execução) ou warning (aviso que não trava o código)
- **Print statements**: use `print()` para verificar valores
- **Tipo de dados**: verifique com `type()` e `.info()`

---

## 📚 Materiais de Apoio

### Arquivos da Disciplina

- **PDF**: Introducao Programacao Python 21-23 e 280525pdf Portugues.pdf
- **Material Complementar**: Material complementar 21 23 e 28052025pdf Portugues.pdf
- **Tutorial Bibliotecas**: Tutorial Bibliotecaspdf Portugues.pdf
- **Tutorial Instalação**: Tutorial Instalacao Anaconda - Spyder 251pdf Portugues.pdf

### Scripts e Notebooks

- **(1) Introdução Programação Python.py**: script completo da aula
- **(1) Introdução Programação Python.ipynb**: notebook interativo
- **(3) SCRIPT - Tradutor de Comentários.py**: ferramenta auxiliar

### Recursos Python

- **NumPy**: computação numérica e arrays
- **Pandas**: manipulação e análise de dados
- **Matplotlib**: visualização básica
- **Seaborn**: visualizações estatísticas de alto nível
- **Plotly**: gráficos interativos

---

## 🎯 Pontos Importantes para Memorizar

1. **Índices começam em 0**
   - Em Python, a contagem sempre inicia do zero, não de 1

2. **Importar pacotes em cada sessão**
   - Sempre que iniciar o Spyder, reimporte os pacotes necessários

3. **iloc e loc no pandas**
   - `iloc`: seleção por posição numérica (índice de linha/coluna), como em `pisa.iloc[46, 2]`
   - `loc`: usado, por exemplo, para atribuir valores a uma nova coluna com base em uma condição, como em `atlas_ambiental.loc[atlas_ambiental['favel']<5.93, "indica_favel"] = "Abaixo"`

4. **None vs NaN**
   - `None`: indicação de dado "não disponível" (missing value) atribuído diretamente
   - `NaN`: valor ausente gerado pelo pandas, por exemplo ao converter texto para número com `pd.to_numeric(..., errors='coerce')`

5. **Intervalos excluem o limite final**
   - `np.arange(1, 10)` inclui o número inicial, mas exclui o final
   - Em seleções por posição (`iloc[0:7, ]`, `iloc[:, 0:3]`), é necessário somar uma posição a mais no final para incluir o elemento desejado

6. **Inplace modifica o original**
   - Operações com `inplace=True` alteram o objeto original em vez de retornar uma cópia

7. **Funções reduzem duplicação**
   - Se o mesmo código se repete, crie uma função

8. **Formatação dos gráficos**
   - Título, rótulos dos eixos e tamanho da fonte (`plt.title`, `plt.xlabel`, `plt.ylabel`, `fontsize`) tornam os gráficos mais informativos

---

## 📖 Referências Recomendadas

### Documentação Oficial

- Python Documentation: https://docs.python.org/3/
- Pandas Documentation: https://pandas.pydata.org/docs/
- NumPy Documentation: https://numpy.org/doc/
- Matplotlib Documentation: https://matplotlib.org/stable/contents.html
- Seaborn Documentation: https://seaborn.pydata.org/
- Plotly Documentation: https://plotly.com/python/

### Sugestão de Leitura (Material Complementar da Disciplina)

- Grus, J. (2021). Data Science do zero: noções fundamentais com Python. Alta Books. (disponível na Biblioteca ABCD_USP)
- Bruce, P.; Bruce, A.; Gedeck, P. (2020). Practical Statistics for Data Scientists. 2nd Edition. O'Reilly Media.
- Fávero, L.P.; Belfiore, P. (2024). Manual de análise de dados: estatística e machine learning com Excel®, SPSS®, Stata®, R® e Python®. LTC.
- McKinney, W. (2018). Python Para Análise de Dados: Tratamento de Dados com Pandas, NumPy e IPython. Novatec.
- Vanderplas, J. (2023). Python Data Science Handbook: Essential Tools for Working with Data. 2 ed. O'Reilly Media.

---

## ✅ Checklist de Estudo

- [x] Instalar e configurar Anaconda e Spyder
- [x] Compreender estrutura de projetos e scripts no Spyder
- [x] Dominar operações básicas e tipos de dados
- [x] Importar e utilizar pacotes essenciais (pandas, numpy)
- [x] Criar e manipular listas, Series e DataFrames
- [x] Importar dados de diferentes formatos (CSV, Excel, API)
- [x] Selecionar, filtrar e transformar dados
- [x] Criar funções personalizadas com condições
- [x] Implementar loops (for e while) para iterações
- [x] Calcular estatísticas descritivas
- [x] Criar visualizações básicas (barras, pizza, histograma)
- [x] Criar gráficos de dispersão e linhas
- [x] Entender e aplicar boas práticas de programação
- [x] Debugar erros comuns em Python
- [x] Exportar resultados e gráficos

---

**Última atualização**: Março 2026
**Curso**: MBA em Data Science e Analytics - USP/ESALQ
**Módulo**: 2 - Introdução à Programação com Python
**Professor**: Prof. Dr. Wilson Tarantin Junior
