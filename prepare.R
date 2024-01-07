
library(dplyr)
library(rio) 
library(tibble) 
library(readr) 
library(janitor) 
library(purrr) 
library(tictoc) 
library(lubridate) 

# baixado em 
# http://plsql1.cnpq.br/divulg/RESULTADO_PQ_102003.curso 
readr::read_delim('rawfiles/pq-economia.csv', 
                  delim = ";", 
                  col_names = c('nome_completo', 'tipo', 'inicio', 'final', 'instituicao', 'situacao'), 
                  show_col_types = F) |>
  tibble::as_tibble() |>
  dplyr::mutate(nome_completo = stringr::str_trim(nome_completo)) |>  
  dplyr::mutate(tipo = stringr::str_trim(tipo)) |>  
  dplyr::mutate(inicio = stringr::str_trim(inicio)) |>  
  dplyr::mutate(final = stringr::str_trim(final)) |>  
  dplyr::mutate(instituicao = stringr::str_trim(instituicao)) |>  
  dplyr::mutate(inicio = lubridate::dmy(inicio)) |>
  dplyr::mutate(final = lubridate::dmy(final)) ->
  # dplyr::filter(situacao != 'Suspenso') |>
  # dplyr::select(- situacao) -> 
  pq_economia

# curriculos lattes baixado em: 
# http://buscatextual.cnpq.br/buscatextual/busca.do#
rio::import('rawfiles/pq-economia-ids.xlsx') |>
  tibble::as_tibble() |>
  janitor::clean_names() |>
  dplyr::mutate(nome = stringr::str_trim(nome)) |>  
  dplyr::rename(nome_completo = nome) -> 
  pq_excel

dados_gerais |>
  dplyr::filter((nome_completo %in% pq_excel$nome_completo)) 
