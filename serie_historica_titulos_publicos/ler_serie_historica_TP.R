library(stringr)
library(readxl)

carregar_tp = function(ano,arquivo){
  
  url = "https://sisweb.tesouro.gov.br/apex/f?p=2031:2:0:"
  
  fontCode = readLines(url, warn = F)
  fontCode = str_flatten(fontCode,"\n")
  
  pattern = paste0("<span>(\\d+) - </span>\n",
                  "<a [^_]*_\\w*/([^\"]*)\"[^>]*>(\\w*)</a>\\s*\n<[^_]*_\\w*/([^\"]*)\" ", 
                  "[^>]*>(\\w*)</a>\\s*\n<a [^_]*_\\w*/([^\"]*)\"[^>]*>([^<]*)</a>\\s*",
                  "\n<a [^_]*_\\w*/([^\"]*)\"[^>]*>([^<]*)</a>\\s*\n<a [^_]*_\\w*/([^\"]*)\"[^>]*>([^<]*)",
                  "</a>\\s*\n<a [^_]*_\\w*/([^\"]*)\"[^>]*>([^<]*)</a>\\s*\n")
  
  codeList = as.data.frame(str_match_all(fontCode,pattern)[[1]])
  codeList = codeList[,-c(1,4,6,8,10,12,14)]
  colnames(codeList) = c("Ano","LFT","LTN","NTNC","NTN-B","NTN-B P","NTN-F")
  rownames(codeList) = codeList[,1]
  
link = codeList[ano,arquivo]
dlink= paste0("https://sisweb.tesouro.gov.br/apex/cosis/sistd/obtem_arquivo/",link)
 
path =  paste0("downloads/", paste0(arquivo,ano))
 
download.file(dlink,destfile = path, mode = "wb")

data = lapply(excel_sheets(path), read_excel, path = path)

file.remove(path)

return(data)

  
}


dados = carregar_tp("2020","NTN-B")

