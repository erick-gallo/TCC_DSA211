#-=- Bibliotecas
library(rpart)       #Árvore de decisão
library(rpart.plot)  # Conjunto com Rpart, plota a parvore

#-=- Leitura da base de treinamento tratada
base_treino <- read.table("dados/001_base_treino_tratada.csv", sep = ",", header = T, dec = ".")


#-=- Aplicando o modelo de árvore de decisão
base_treinada <- rpart(Sobreviveu ~ Pclass + Sex + Age + Embarked,
                       data=base_treino,
                       control=rpart.control(maxdepth = 5, cp=0))

#-=- Demonstração gráfica do modelo                
rpart.plot::rpart.plot(base_treinada)

#-=- Realizando a validação do modelo com a base de treino
prob_treinam = predict(base_treinada, base_treino)
View(prob_treinam)

# Selecionandoas predições com a probabilidade maior que 50%
resultado_previsao = prob_treinam[,2]>.5

# Matriz de confusão comparando a base treinada com a predição da mesma
matriz_confusao <- table(resultado_previsao, base_treino$Sobreviveu)
matriz_confusao
perc_acerto_base_treinam <- (matriz_confusao[1,1] + matriz_confusao[2,2])/ sum(matriz_confusao)
perc_acerto_base_treinam


#######################################################################
#######################################################################
###    Importação da base de teste
#######################################################################
#######################################################################

base_teste <- read.table("dados/002_base_teste.csv", sep = ",", header = T, dec = ".")
base_validacao <- read.table("dados/002_gender_submission.csv", sep = ",", header = T, dec = ".")
base_validacao$Sobreviveu[0==base_validacao$Survived] <- "Não"
base_validacao$Sobreviveu[1==base_validacao$Survived] <- "Sim"


#-=- Realizando a previsão da base de teste
prob_teste = predict(base_treinada, base_teste)

# Selecionandoas predições com a probabilidade maior que 50%
resultado_prev_teste = prob_teste[,2]>.5

# Matriz de confusão comparando a base de teste com a predição da mesma
matriz_confusao_teste <- table(resultado_prev_teste, base_validacao$Sobreviveu)

View(matriz_confusao_teste)

perc_acerto_base_teste <- (matriz_confusao_teste[1,1] + matriz_confusao_teste[2,2])/ sum(matriz_confusao_teste)
perc_acerto_base_teste

#######################################################################
#######################################################################
###    Salvando a base treinada para ser consumida pela função
#######################################################################
#######################################################################

saveRDS(base_treinada, "dados/002_base_treinada.rds")