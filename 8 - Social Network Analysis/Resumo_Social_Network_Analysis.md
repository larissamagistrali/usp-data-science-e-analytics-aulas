# 🕸️ Resumo - Social Network Analysis

## MBA em Data Science e Analytics USP/ESALQ

---

## 🎯 Objetivo do Módulo

Compreender e aplicar técnicas de análise de redes sociais usando teoria dos grafos para identificar padrões de relacionamento, influenciadores, comunidades e estruturas em redes complexas.

---

## 📚 Conteúdo Principal

### 1. **Fundamentos de Teoria dos Grafos**

#### 1.1 Conceitos Básicos

- **Grafo (Graph)**: estrutura matemática para modelar relações
- **Nós (Vertices)**: entidades da rede (pessoas, organizações, páginas)
- **Arestas (Edges)**: conexões entre os nós (amizades, transações, links)
- **Peso (Weight)**: intensidade ou força da conexão
- **Direção**:
  - Grafo não direcionado: relações simétricas (amizade)
  - Grafo direcionado: relações assimétricas (seguir no Twitter)

#### 1.2 Tipos de Redes

- **Redes Sociais**: Facebook, LinkedIn, Twitter
- **Redes de Colaboração**: coautoria de artigos, projetos
- **Redes de Transporte**: rotas aéreas, malha rodoviária
- **Redes Biológicas**: interação de proteínas, cadeias alimentares
- **Redes de Informação**: citações, hiperlinks, referências

---

### 2. **Criando e Visualizando Grafos**

#### 2.1 Criação Básica de Grafos

```python
from igraph import Graph, plot
import pandas as pd
import numpy as np

# Criar grafo vazio
g = Graph()

# Adicionar vértices
g.add_vertices(5)
g.vs["name"] = ["A", "B", "C", "D", "E"]

# Adicionar arestas
g.add_edges([("A","B"), ("B","C"), ("B","D"), ("D","C"), ("C","E")])

# Adicionar pesos
g.es['weight'] = [1, 1, 1, 1, 1]

# Visualizar
print(g)
```

#### 2.2 Importando Redes de DataFrames

```python
# Carregar dados
karate = pd.read_csv("karate.csv", sep=";")

# Transformar em grafo
rede_karate = Graph.DataFrame(karate, directed=False)
```

#### 2.3 Visualização Básica

```python
# Plot simples
plot(g)

# Plot com layout
layout = g.layout("kk")  # Kamada-Kawai layout
plot(g, layout=layout)
```

#### 2.4 Visualização Avançada

```python
# Configurar estilo visual
visual_style = {}
visual_style["vertex_color"] = "white"
visual_style["vertex_size"] = 20
visual_style["vertex_label"] = ["A", "B", "C", "D", "E"]
visual_style["edge_width"] = g.es['weight']
visual_style["bbox"] = (200, 200)

plot(g, **visual_style)
```

#### 2.5 Layouts Disponíveis

- **kk**: Kamada-Kawai (força)
- **fr**: Fruchterman-Reingold (força)
- **circle**: circular
- **grid**: grade
- **tree**: árvore hierárquica
- **random**: aleatório

Documentação: https://igraph.org/python/doc/tutorial/visualisation.html#graph-layouts

---

### 3. **Métricas da Rede (Nível Global)**

#### 3.1 Densidade

```python
# Densidade do grafo (proporção de arestas existentes)
g.density()
```

- **Fórmula**: número de arestas / número máximo possível de arestas
- **Interpretação**: quão conectada é a rede (0 a 1)
- **Densidade alta**: rede muito conectada
- **Densidade baixa**: rede esparsa

#### 3.2 Diâmetro

```python
# Diâmetro da rede (maior distância entre dois nós)
g.diameter()
```

- **Definição**: maior caminho curto entre quaisquer dois nós
- **Interpreta��ão**: "tamanho" da rede
- **Small-world**: redes com diâmetro pequeno apesar de muitos nós

#### 3.3 Raio

```python
# Raio da rede (menor excentricidade)
g.radius()
```

- **Definição**: menor excentricidade entre todos os nós
- **Interpretação**: distância do(s) nó(s) mais central(is)

#### 3.4 Comprimento Médio do Caminho

```python
# Comprimento médio dos caminhos curtos
g.average_path_length()
```

- **Definição**: média de todos os caminhos curtos na rede
- **Interpretação**: eficiência da comunicação na rede
- **Valor baixo**: rede eficiente

---

### 4. **Métricas dos Nós (Nível Local)**

#### 4.1 Grau (Degree)

```python
# Grau de cada nó (número de conexões)
g.degree()
```

- **Definição**: número de arestas conectadas a um nó
- **Interpretação**: popularidade, conectividade
- **Hub**: nó com grau muito alto
- **Distribuição de grau**: característica importante da rede

#### 4.2 Coeficiente de Clustering

```python
# Coeficiente de clustering local
g.transitivity_local_undirected()
```

- **Definição**: proporção de conexões entre vizinhos de um nó
- **Fórmula**: triângulos conectados / triplos conectados
- **Interpretação**: quão "clustered" são os vizinhos
- **Valor alto**: vizinhos bem conectados entre si

#### 4.3 Proximidade (Closeness)

```python
# Closeness normalizada
g.closeness(weights=None, normalized=True)

# Closeness não normalizada
g.closeness(weights=None, normalized=False)
```

- **Definição**: inverso da soma das distâncias para todos os outros nós
- **Interpretação**: quão rápido informação chega a um nó
- **Valor alto**: nó central, alcança outros rapidamente
- **Normalizada**: ajustada pelo tamanho da rede

#### 4.4 Intermediação (Betweenness)

```python
# Betweenness centrality
g.betweenness(weights=None)
```

- **Definição**: número de caminhos curtos que passam por um nó
- **Interpretação**: controle de fluxo de informação
- **Broker**: nó com alta intermediação
- **Gatekeepers**: conectam diferentes partes da rede

#### 4.5 Excentricidade

```python
# Excentricidade de cada nó
g.eccentricity()
```

- **Definição**: maior distância de um nó a qualquer outro nó
- **Interpretação**: quão "periférico" é o nó
- **Valor baixo**: nó central
- **Valor alto**: nó na periferia da rede

#### 4.6 Pontes (Bridges)

```python
# Pontos de articulação (bridges)
g.articulation_points()
```

- **Definição**: nós cuja remoção desconecta a rede
- **Interpretação**: pontos críticos de conectividade
- **Vulnerabilidade**: sua falha fragmenta a rede
- **Retorna**: lista de índices dos nós-ponte

---

### 5. **Visualização com Métricas**

#### 5.1 Tamanho dos Nós por Grau

```python
# Aumentar tamanho dos nós baseado no grau
deg = g.degree()
deg = [i * 10 for i in deg]  # Escalar para visualização

plot(g,
     vertex_size=deg,
     vertex_color=['red'],
     vertex_label=["A", "B", "C", "D", "E"],
     edge_width=[4],
     edge_color=['grey'],
     bbox=(200, 200))
```

#### 5.2 Cor por Comunidade

```python
# Detectar comunidades
comunidades = g.community_multilevel()

# Plotar com cores por comunidade
visual_style = dict()
visual_style["bbox"] = (300, 300)
plot(comunidades, mark_groups=True, **visual_style)
```

---

### 6. **Análise de Comunidades**

#### 6.1 Conceito de Comunidades

- **Comunidade**: grupo de nós densamente conectados entre si
- **Modularidade**: medida de qualidade da divisão em comunidades
- **Modularidade alta**: boa separação de comunidades
- **Valor**: -0.5 a 1.0 (quanto maior, melhor)

#### 6.2 Algoritmos de Detecção

**Edge Betweenness**:

```python
comunidade_ceb = rede_karate.community_edge_betweenness()
comunidade = comunidade_ceb.as_clustering()

# Modularidade
comunidade.modularity

# Plotar
visual_style = dict(bbox=(300, 300))
plot(comunidade, mark_groups=True, **visual_style)
```

- Baseado em intermediação de arestas
- Remove arestas com alta betweenness iterativamente

**Fast Greedy**:

```python
comunidade_fg = rede_karate.community_fastgreedy()
comunidade1 = comunidade_fg.as_clustering()

# Modularidade
comunidade1.modularity
```

- Algoritmo guloso hierárquico
- Rápido para redes grandes
- Maximiza modularidade

**Walktrap**:

```python
comunidade_wtrap = rede_karate.community_walktrap(weights=None, steps=4)
comunidade2 = comunidade_wtrap.as_clustering()

# Modularidade
comunidade2.modularity
```

- Baseado em random walks
- Nós na mesma comunidade têm random walks curtos
- Parâmetro `steps`: comprimento do random walk

**Louvain (Multilevel)**:

```python
comunidades = rede_karate.community_multilevel()
```

- Um dos mais populares
- Otimização de modularidade em múltiplos níveis
- Eficiente e eficaz

**Label Propagation**:

```python
comunidades = rede_karate.community_label_propagation()
```

- Cada nó adota o rótulo mais comum entre vizinhos
- Muito rápido
- Não determinístico

**Spin Glass**:

```python
comunidades = rede_karate.community_spinglass()
```

- Baseado em física estatística
- Bom para redes pequenas a médias

#### 6.3 Comparando Métodos

```python
# Comparar múltiplos métodos
metodos = {
    "Edge Betweenness": rede.community_edge_betweenness().as_clustering(),
    "Fast Greedy": rede.community_fastgreedy().as_clustering(),
    "Walktrap": rede.community_walktrap().as_clustering(),
    "Louvain": rede.community_multilevel(),
    "Label Propagation": rede.community_label_propagation(),
    "Spin Glass": rede.community_spinglass()
}

resultados = []
for metodo_nome, metodo in metodos.items():
    modularidade = metodo.modularity
    num_comunidades = len(metodo)
    tamanhos = [len(c) for c in metodo]

    resultados.append([
        metodo_nome,
        modularidade,
        num_comunidades,
        np.min(tamanhos),
        np.max(tamanhos),
        np.mean(tamanhos),
        np.std(tamanhos)
    ])

df_resultados = pd.DataFrame(resultados,
                              columns=["Método", "Modularidade",
                                      "Número de Comunidades",
                                      "Min Tamanho", "Max Tamanho",
                                      "Média Tamanho", "Desvio Padrão"])
print(df_resultados)
```

---

### 7. **Análise por Comunidades**

#### 7.1 Função para Métricas da Rede

```python
def stats_rede(rede, nodes: list):
    df = pd.DataFrame({"nodes": nodes})
    df["degree"] = rede.degree()
    df["cc"] = rede.transitivity_local_undirected()
    df["closeness"] = rede.closeness(weights=None, normalized=True)
    df["betweenness"] = rede.betweenness()
    df["bridge"] = df["nodes"].isin(rede.articulation_points()).astype(int)
    return df

# Aplicar
df_stat_geral = stats_rede(rede_karate, list(range(rede_karate.vcount())))
```

#### 7.2 Função para Métricas por Comunidade

```python
def stats_comunidade(comunidade, nodes: list):
    df = pd.DataFrame({"nodes": nodes})
    df["degree"] = comunidade.degree()
    df["cc"] = comunidade.transitivity_local_undirected()
    df["closeness"] = comunidade.closeness()
    df["betweenness"] = comunidade.betweenness()
    df["bridge"] = df["nodes"].isin(comunidade.articulation_points()).astype(int)
    return df
```

#### 7.3 Calcular Métricas para Cada Comunidade

```python
# Detectar comunidades
comunidades = rede_karate.community_multilevel()

# DataFrame com membership
df_membership = pd.DataFrame({
    "nodes": list(range(len(comunidades.membership))),
    "membership": comunidades.membership
})

# Calcular métricas para cada comunidade
comunidades_dst = df_membership["membership"].unique()
dfs_stats = []

for c in comunidades_dst:
    nodes = df_membership[df_membership["membership"]==c]["nodes"].tolist()
    dfs_stats.append(stats_comunidade(comunidades.subgraphs()[c], nodes))

df_stat_comu = pd.concat(dfs_stats)
df_stat_comu = df_stat_comu.merge(df_membership, on="nodes",
                                   how="left").sort_values(by="nodes")
```

#### 7.4 Combinar Métricas Globais e por Comunidade

```python
# Combinar métricas gerais e por comunidade
df_stat = df_stat_comu.merge(df_stat_geral, on=["nodes"],
                             how="inner",
                             suffixes=["_comunidade", "_geral"])
```

---

## 🛠️ Ferramentas e Bibliotecas

### Bibliotecas Python

```python
# Instalação
# pip install igraph
# pip install pycairo
# pip install pandas
# pip install numpy

# Importação
from igraph import Graph, plot
import igraph
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
```

### Ferramentas de Visualização

- **igraph**: biblioteca principal para análise de redes
- **pycairo**: renderização gráfica
- **Gephi**: software standalone para visualização avançada (Tutorial disponível)
- **Matplotlib**: plots adicionais e customizações

---

## 📊 Dataset Utilizado

### Karate Club (Zachary, 1977)

**karate.csv**:

- **Descrição**: Rede social de um clube de karatê universitário
- **Nós**: 34 membros do clube
- **Arestas**: interações sociais entre membros
- **Contexto histórico**: clube se dividiu em 2 grupos após conflito entre instrutor e administrador
- **Uso clássico**: benchmark para algoritmos de detecção de comunidades
- **Ground truth**: divisão real conhecida (2 grupos)

---

## 📊 Aplicações Práticas em Data Science

### 1. Marketing e Negócios

- **Influencer marketing**: identificar influenciadores (high betweenness/degree)
- **Segmentação de clientes**: detectar comunidades de consumidores similares
- **Recomendações**: sugerir produtos/conexões baseado na rede
- **Viral marketing**: identificar pontos estratégicos de disseminação

### 2. Redes Sociais

- **Análise de comunidades**: identificar grupos de interesse
- **Detecção de bots**: padrões anômalos de conectividade
- **Propagação de informação**: analisar como conteúdo se espalha
- **Detecção de fraude**: identificar redes de contas falsas

### 3. Organizações

- **Análise organizacional**: mapear estruturas informais
- **Colaboração**: identificar silos e pontes entre departamentos
- **Liderança informal**: detectar líderes não-hierárquicos
- **Otimização de comunicação**: melhorar fluxos de informação

### 4. Pesquisa Científica

- **Redes de colaboração**: coautorias, citações
- **Redes de proteínas**: interações biológicas
- **Epidemiologia**: propagação de doenças

### 5. Infraestrutura e Logística

- **Transporte**: otimização de rotas
- **Redes elétricas**: identificar pontos críticos
- **Supply chain**: analisar cadeias de suprimento
- **Telecomunicações**: otimização de redes

---

## 💡 Conceitos-Chave para Data Science

### Centralidade vs Intermediação

- **Centralidade (Degree/Closeness)**: importância por posição
- **Intermediação (Betweenness)**: importância por controle de fluxo
- **Hub**: alto grau, muitas conexões
- **Bridge**: alta intermediação, conecta grupos

### Small-World Networks

- **Características**:
  - Alto clustering coefficient
  - Baixo comprimento médio de caminho
- **Fenômeno dos 6 graus de separação**
- **Exemplos**: redes sociais, internet, redes neurais

### Scale-Free Networks

- **Distribuição de grau**: segue lei de potência
- **Poucos hubs**: maioria dos nós tem poucas conexões
- **Robustez vs vulnerabilidade**:
  - Robusto a remoção aleatória
  - Vulnerável a ataque dirigido a hubs

### Modularidade

- **Valores**: -0.5 a 1.0
- **> 0.3**: estrutura de comunidade significativa
- **> 0.7**: estrutura forte de comunidade
- **Trade-off**: número de comunidades vs tamanho

### Interpretação de Métricas

- **Absoluto vs relativo**: comparar dentro da mesma rede
- **Normalização**: importante para comparar redes diferentes
- **Contexto**: métricas dependem do domínio de aplicação
- **Múltiplas métricas**: usar conjunto de métricas, não apenas uma

---

## 📚 Materiais de Apoio

### Arquivos da Disciplina

- **PDF**: Social Network Analysis 02092025_SLpdf Portugues.pdf
- **PDF**: Social Network Analysis II 09092025_SLpdf Portugues.pdf
- **Material Complementar**: Material complementar 02 e 09092025_MCpdf Portugues.pdf
- **Material Pós-Aula**: Material complementar pos-aula 02092025_MCpdf Portugues.pdf
- **Tutorial**: Tutorial Instalacao Gephipdf Portugues.pdf

### Scripts Python

- **1_SNA_conhecendo_codigos_Python.py**: introdução ao igraph e métricas básicas
- **2_SNA_exemplo_comunidades_base_Karate.py**: detecção de comunidades
- **3_SNA_exemplo_comunidades_base_karate.py**: análise por comunidades

### Dataset

- **dados/karate.csv**: rede social do clube de karatê

---

## 🎯 Pontos Importantes para Memorizar

1. **Índices começam em 0**
   - Vertices são indexados de 0 a n-1
   - `articulation_points()` retorna índices, não nomes

2. **Grafos direcionados vs não direcionados**
   - Escolher corretamente ao criar: `directed=True` ou `False`
   - Métricas podem diferir significativamente

3. **Normalização é importante**
   - Closeness: use `normalized=True` para comparabilidade
   - Algumas métricas já vêm normalizadas, outras não

4. **Modularidade não é absoluta**
   - Valores > 0.3 indicam estrutura de comunidade
   - Comparar métodos diferentes na mesma rede

5. **Algoritmos têm trade-offs**
   - Precisão vs velocidade
   - Determinístico vs não determinístico
   - Alguns funcionam melhor para certos tipos de rede

6. **Visualização requer experimentação**
   - Testar diferentes layouts
   - Ajustar tamanhos e cores para clareza
   - Redes grandes precisam abordagens diferentes

7. **Bridges são críticos**
   - Sua remoção fragmenta a rede
   - Identificam vulnerabilidades estruturais
   - Conectam diferentes comunidades

8. **Métricas são complementares**
   - Nenhuma métrica conta toda a história
   - Use múltiplas perspectivas (grau, closeness, betweenness)
   - Contexto do problema guia escolha de métricas

---

## 📖 Referências Recomendadas

### Livros

- Newman, M. (2018). Networks, 2nd Edition. Oxford University Press.
- Barabási, A.-L. (2016). Network Science. Cambridge University Press.
- Borgatti, S.P., et al. (2018). Analyzing Social Networks, 2nd Edition. SAGE.
- Wasserman, S. & Faust, K. (1994). Social Network Analysis. Cambridge.

### Documentação

- igraph Python: https://igraph.org/python/
- igraph Tutorial: https://igraph.org/python/doc/tutorial/tutorial.html
- NetworkX (alternativa): https://networkx.org/

### Artigos Clássicos

- Zachary, W. (1977). An Information Flow Model for Conflict and Fission in Small Groups.
- Watts, D.J. & Strogatz, S.H. (1998). Collective dynamics of 'small-world' networks. Nature.
- Barabási, A.-L. & Albert, R. (1999). Emergence of scaling in random networks. Science.

### Online

- Network Science Book (Barabási): http://networksciencebook.com/
- Social Network Analysis with Python: https://www.datacamp.com/

---

## ✅ Checklist de Estudo

- [ ] Instalar igraph e dependências (pycairo)
- [ ] Criar grafos básicos e adicionar nós/arestas
- [ ] Importar redes de DataFrames
- [ ] Calcular métricas globais (densidade, diâmetro, caminho médio)
- [ ] Calcular métricas de nós (degree, closeness, betweenness)
- [ ] Identificar pontos de articulação (bridges)
- [ ] Visualizar grafos com diferentes layouts
- [ ] Customizar visualizações (tamanho, cor, rótulos)
- [ ] Aplicar algoritmos de detecção de comunidades
- [ ] Comparar diferentes métodos de detecção
- [ ] Calcular e interpretar modularidade
- [ ] Analisar métricas por comunidade
- [ ] Criar funções para automatizar análise
- [ ] Interpretar resultados no contexto do problema
- [ ] Aplicar SNA em dataset real ou próprio

---

**Última atualização**: Março 2026  
**Curso**: MBA em Data Science e Analytics - USP/ESALQ  
**Módulo**: 8 - Social Network Analysis  
**Professora**: Prof.ª Adriana Silva
