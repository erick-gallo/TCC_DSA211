#-=- Bibliotecas
library(plumber)       #Criação de WEB API

#-=- Carga da base de predição
base_treinada = readRDS("dados/002_base_treinada.rds", refhook = NULL)


#* @apiTitle Probabilidade de sobreviver no naufrágio do Titanic [Árvore de Decisão]

#* Probabilidade de sobreviver no naufrágio do Titanic
#* @param Pclass:int
#* @param Sex f:list ["male", "female"]
#* @param Age:int
#* @param Embarked:str
#* @post /Survived

function(Pclass, Sex, Age, Embarked) {

  Pclass    <- as.double(Pclass)  # converte para número
  Age       <- as.double(Age)     # converte para número
  Sex       <- tolower(Sex)       # converte para letras minúsculas
  Embarked  <- toupper(Embarked)  # converte para letras maiúsculas
  
  #-- Valida se os Parâmetros estão presentes
  if (missing(Pclass)){
    stop("Classe do bilhete (1, 2 ou 3) não informada")
  }
  if (missing(Sex)){
    stop("Sexo do Passageiro (Male / Female) não informado")
  }
  if (missing(Age)){
    stop("Idade do Passageiro não informada")
  }
  if (missing(Embarked)){
    stop("Ponto de embarcação: C = Cherbourg, Q = Queenstown, S = Southampton não informado")
  }

  #-- Predição dos valores recebidos
  Survived <- predict(base_treinada, list(Pclass   = Pclass,
                                          Sex      = Sex,
                                          Age      = Age,
                                          Embarked = Embarked))
  
  Survived <- if(Survived[,2]>.5) {"Sim"} else {"Não"}
 
  return(Survived)
}