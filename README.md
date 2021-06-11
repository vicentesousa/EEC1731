# DCO1020: Comunicações Móveis - 2021.1

## UNIDADE I

### Hands-on 01: Uso de modelos de propagação para análises sistêmicas

#### Parte 01: Avaliação de cobertura celular [Link via Github](https://github.com/vicentesousa/DCO1020_2021_1/blob/master/h01_parte01.ipynb) - [Link alternativo via nbviewer](http://nbviewer.jupyter.org/github/vicentesousa/DCO1020_2021_1/blob/master/h01_parte01.ipynb)

**Objetivos:**
- Criação de Grid Hexagonal para modelar cobertura de Estações Rádio Base
- Análise visual de potência recebida 
- Análise de Outage de potência

####  Parte 02: Modelagem da cobertura celula com sombreamento - [Link via Github](https://github.com/vicentesousa/DCO1020_2021_1/blob/master/h01_parte02.ipynb) - [Link alternativo via nbviewer](https://nbviewer.jupyter.org/github/vicentesousa/DCO1020_2021_1/blob/master/h01_parte02.ipynb)

**Objetivos:**
- Análise visual de potência recebida com sobreamento
- Implementação do sombreamento correlacionado 

**Entregas:**
- As entregas estão especificadas ao longo dos Hands-ons;
- As entregas devem compor um único arquivo **zip** com os códigos separados nas seguintes pastas: Entrega_01, Entrega_02, Entrega_03 e Entrega_04, respectivamente para cada entrega. 
- Cada pasta deve conter um arquivo chamado README.txt, indicando como rodar o código produzido por você (produza um código autocontido, no qual o usuário deva rodar um único script para chegar nos resultados desejados). 
- Não será necessário produzir um relatório. Contudo, é parte importante da entrega a produção de vídeos (compartilhados no google drive ou youtube), contendo a descrição do código implementado (explicar brevemente o que foi feito, mostrar as formulações em slides se necessário, mostrar como rodar o código e os gráficos gerados). O link do vídeo deve ser informado no arquivo README.txt (caso necessite, compartilhe o vídeo com **vicente.sousa@ufrn.br**);
- Um vídeo de até 5 minutos deve conter o conteúdo das Entrega_01 e Entrega_02;
- Um vídeo de até 5 minutos deve conter o conteúdo das Entrega_03 e Entrega_04.

**Prazo:**
- As entregas do Hands-on 1 devem ser feitas via SIGAA até dia 01/07/2021;

### Hands-on 02: Caracterização de canal banda estreita (modelagem e caracterização do desvanecimento de pequena escala) - [Link via Github](https://github.com/vicentesousa/DCO1020_2021_1/blob/master/h01_parte_03.ipynb)  - [Link alternativo via nbviewer](https://nbviewer.jupyter.org/github/vicentesousa/DCO1020_2021_1/blob/master/h01_parte_03.ipynb)

**Objetivos:**
- Gerar uma série temporal sintética com Perda de Percurso, Sombreamento e Desvanecimento m-Nakagami;
- Estimar cada desvanecimento por meio de regressão linear, filtragem e tratamento estatístico;
- Fazer gráficos e comparar as partes geradas sinteticamente e as partes estimadas.

**Entregas:**
- As entregas estão especificadas ao longo do Hands-on;
- As entregas devem compor um único arquivo **zip** com os códigos separados nas seguintes pastas: Entrega_01. 
-A pasta deve conter um arquivo chamado README.txt, indicando como rodar o código produzido por você (produza um código autocontido, no qual o usuário deva rodar um único script para chegar nos resultados desejados). 
- Não será necessário produzir um relatório. Contudo, é parte importante da entrega a produção de vídeos (compartilhados no google drive ou youtube), contendo a descrição do código implementado (explicar brevemente o que foi feito, mostrar as formulações em slides se necessário, mostrar como rodar o código e os gráficos gerados). O link do vídeo deve ser informado no arquivo README.txt (caso necessite, compartilhe o vídeo com **vicente.sousa@ufrn.br**);
- Um vídeo de até 5 minutos deve conter o conteúdo da Entrega_01.

**Prazo:**
- As entregas do Hands-on 1 devem ser feitas via SIGAA até dia 13/07/2021;


<!--
## UNIDADE II

### Hands-on 1: calculadora de taxa de transmissão máxima de sistemas 4G e 5G - [Link via Github](https://github.com/vicentesousa/DCO1020_2021_1/blob/master/h03.ipynb) - [Link alternativo via nbviewer](https://nbviewer.jupyter.org/github/vicentesousa/DCO1020_2021_1/blob/master/h03.ipynb)

#### Objetivos
- Entender o cálculo de taxa máxima de sistemas 3GPP-LTE (Release 10);
- Modelar o cálculo de taxa máxima de sistemas de comunicação;
- Implementar o cálculo de taxa máxima de sistemas de comunicação.

**A entrega devem compor um único arquivo zip com os códigos, o mini-relatório e um arquivo chamado README.txt, indicando como rodar o código produzido por você (produza um código autocontido, no qual o usuário deva rodar um único script para chegar nos resultados desejados). O mini-relatório deve ser técnico (análise dos resultados), mas pode ser administrativo (voltado a comentários sobre a execução do projeto). O arquivo zip deve ser entregue via SIGAA.**

**Faz parte da entrega a produção de um vídeo no youtube, de no máximo 5 minutos, contendo uma descrição do relatório e do código implementado (explicar brevemente o que foi feito, mostrar as formulações, mostrar como rodar o código e os gráficos gerados). O link do vídeo deve ser informado no mini-relatório. O vídeo é parte bem importante da avaliação.**

**Importante: O vídeo no youtube deve explicar o funcionamento da interface gráfica e mostrar calculadora funcionando com a taxa mínima e a taxa máxima do LTE.**



## Parte 2

### Hands-on 1: OFDM Basics (ortogonalidade, transmissão e recepção, desempenho em canal sem fio) - [Link via Github](https://github.com/vicentesousa/DCO1020_2021_1/blob/master/h02.ipynb) - [Link alternativo via nbviewer](https://nbviewer.jupyter.org/github/vicentesousa/DCO1020_2021_1/blob/master/h02.ipynb)
#### Objetivos
- Entender a modelagem da multiplexação OFDM;
- Entender o processo de ortogalização entre subportadoras OFDM;
- Entender a modelagem da demultiplexação OFDM;
- Demonstrar o processo de demultiplexação OFDM em canais AWGN.

**A entrega devem compor um único arquivo zip com os códigos, o mini-relatório e um arquivo chamado README.txt, indicando como rodar o código produzido por você (produza um código autocontido, no qual o usuário deva rodar um único script para chegar nos resultados desejados). O mini-relatório deve ser técnico (análise dos resultados), mas pode ser administrativo (voltado a comentários sobre a execução do projeto). O arquivo zip deve ser entregue via SIGAA.**

**Faz parte da entrega a produção de um vídeo no youtube, de no máximo 5 minutos, contendo uma descrição do relatório e do código implementado (explicar brevemente o que foi feito, mostrar as formulações, mostrar como rodar o código e os gráficos gerados). O link do vídeo deve ser informado no mini-relatório. O vídeo é parte bem importante da avaliação.**


## Parte 3






# UNIDADE II

**As entregas devem compor um único arquivo zip com os códigos separados nas seguintes pastas: Entrega_01, Entrega_02, Entrega_03, respectivamente para cada entrega. Cada pasta deve conter um arquivo chamado README.txt, indicando como rodar o código produzido por você (produza um código autocontido, no qual o usuário deva rodar um único script para chegar nos resultados desejados). Finalmente, em cada pasta deve conter um documento, de no máximo 2 páginas, relatando algum aspecto que você ache importante destacar sobre cada experimento. O relato pode deve ser técnico (análise de algum resultado) e administrativo (voltado a comentários sobre a execução do projeto). O arquivo zip deve ser entregue via SIGAA.**

**Faz parte da entrega a produção de um vídeo no youtube, de no máximo 5 minutos, contendo uma descrição do código implementado (explicar brevemente o que foi feito, mostrar as formulações, mostrar como rodar o código e os gráficos gerados). O link do vídeo deve ser informado no mini-relatório. O vídeo é parte bem importante da avaliação.**
-->

