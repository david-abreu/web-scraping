# função para ler o tabela no site anbima
carregar_debentures = function(dt){
  
  # validação dos parâmetros da função
  stopifnot(is(dt,"Date"), length(dt) == 1)
  

  # formando o link de forma dinâmica para fazer o download da data escolhida
  url = format(dt, "https://www.anbima.com.br/informacoes/merc-sec-debentures/arqs/db%y%m%d.txt")
  
  # lendo os dados
  dados = read.table(url,
                     stringsAsFactors = FALSE, # não converter textos para fatores
                     header = TRUE, # há cabeçalho 
                     sep = "@", # identificando o separador
                     dec= ",",  #  identificando o decimal
                     na.string = c( "--","N/D"), #identifica como NA tais caracteres
                     skip = 2, # pular as primeiras n linhas
                     fill = TRUE) # preencher como NAs quando não houver colunas
  
  
  #ajsutando o formato das colunas do data frame
  dados$Repac....Venc. =   as.Date(dados$Repac....Venc,"%d/%m/%Y") 
  dados$Referência.NTN.B =   as.Date(dados$Repac....Venc,"%d/%m/%Y") 

  return(dados)
}



# Exemplo
dados = carregar_debentures(as.Date("2021-05-24"))


dados


