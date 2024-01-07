
getArtigosAceitos <- function(curriculo) {

    if (!any(class(curriculo) == 'xml_document')) {
        stop("The input file must be XML, imported from `xml2` package.", call. = FALSE)
    }

    dados_basicos <- 
        curriculo |>
            xml2::xml_find_all(".//ARTIGOS-ACEITOS-PARA-PUBLICACAO") |> 
            purrr::map(~ xml2::xml_find_all(., ".//DADOS-BASICOS-DO-ARTIGO")) |>
            purrr::map(~ xml2::xml_attrs(.)) |>
            purrr::map(~ dplyr::bind_rows(.)) |>
            purrr::map(~ janitor::clean_names(.)) 

    detalhamento <- 
        curriculo |>
            xml2::xml_find_all(".//ARTIGOS-ACEITOS-PARA-PUBLICACAO") |> 
            purrr::map(~ xml2::xml_find_all(., ".//DETALHAMENTO-DO-ARTIGO")) |>
            purrr::map(~ xml2::xml_attrs(.)) |>
            purrr::map(~ dplyr::bind_rows(.)) |>
            purrr::map(~ janitor::clean_names(.)) 

    autores <- 
        curriculo |> 
            xml2::xml_find_all(".//ARTIGOS-ACEITOS-PARA-PUBLICACAO") |> 
            purrr::map(~ xml2::xml_find_all(., ".//AUTORES")) |>
            purrr::map(~ xml2::xml_attrs(.)) |>
            purrr::map(~ dplyr::bind_rows(.)) |>
            purrr::map(~ janitor::clean_names(.)) 

    a <- purrr::map2(dados_basicos, detalhamento, dplyr::bind_cols) 

    purrr::pmap(list(a, autores), function(x, y) tibble::tibble(x, autores = list(y))) |>
        dplyr::bind_rows() |>
        dplyr::mutate(id = getId(curriculo)) 
}

tratamento_issn <- function(x, issn) {
    x |> 
        dplyr::mutate(issn = as.character({{ issn }})) |> 
        dplyr::mutate(issn = gsub("[[:punct:]]", "", .data$issn)) |>
        dplyr::mutate(issn = stringr::str_trim(.data$issn)) |>
        dplyr::filter(nchar(.data$issn) == 8) 
}

tratamento_nome_revista <- function(x, revista) {
    x |> 
        dplyr::mutate(revista = as.character({{ revista }})) |> 
        dplyr::mutate(revista = gsub("\\(.*?\\)", "", .data$revista)) |>
        dplyr::filter(grepl('^[[:alpha:]].*', ignore.case = T, .data$revista)) |>
        dplyr::mutate(revista = stringi::stri_trans_general(.data$revista, "Latin-ASCII")) |>
        dplyr::mutate(revista = gsub("[[:punct:]]", "", .data$revista)) |>
        dplyr::mutate(revista = gsub("\\s+", " ", .data$revista)) |>
        dplyr::mutate(revista = stringr::str_trim(.data$revista)) |>
        dplyr::mutate(revista = toupper(.data$revista)) 
}
