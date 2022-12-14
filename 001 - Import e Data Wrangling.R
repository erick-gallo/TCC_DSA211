#-=- Bibliotecas utilizadas
library(tidyverse)  #Manipulação de dados

#-=- Leitura dos dados de treinamento
base_treino_orig <- read.table("dados/001_train.csv", sep = ",", header = T, dec = ".")

#-=- Realiza uma análise no
summary(base_treino_orig)

#-=- Análise realizada na base de treinamento:
#
# PassengerId: Chave única do passageiro na base de dados
# Survived   : Chave que indica se o passageiro sobreviveu (1) ou não (0)
# Pclass     : Classe do bilhete (1, 2 ou 3)
# Name       : Nome do Passageiro
# Sex        : Sexo do Passageiro (Male / Female)
# Age        : Idade do passageiro 
# SibSp      : O conjunto de dados define as relações familiares desta forma: 
#              Irmão = irmão, irmã, meio-irmão, meia-irmã / 
#              Cônjuge = marido, esposa (amantes e noivos foram ignorados)
# Parch      : O conjunto de dados define as relações familiares desta forma:
#              Pai = mãe, pai
#              Filho = filha, filho, enteada, enteado
#              Algumas crianças viajavam apenas com uma babá, portanto parch=0 para elas
# Ticket     : Número do Bilhete
# Fare       : Tarifa do Passageiro
# Cabin      : Cabine do Passageiro
# Embarked   : Ponto de embarcação: C = Cherbourg, Q = Queenstown, S = Southampton


#-=- Eliminado do modelo de treinamento linhas com valores nulos
base_treino_tratada <- na.omit(base_treino_orig)

base_treino_tratada$Sobreviveu[0==base_treino_tratada$Survived] <- "Não"
base_treino_tratada$Sobreviveu[1==base_treino_tratada$Survived] <- "Sim"


#-=- Eliminado do modelo colunas que não serão usadas na análise
base_treino_tratada <- base_treino_tratada %>% select(Pclass, Sex, Age, Embarked, Sobreviveu)


#-=- Gravação da base tratada
write.table(base_treino_tratada, file = "dados/001_base_treino_tratada.csv", sep = ",", dec = ".", quote=FALSE, row.names = FALSE)
