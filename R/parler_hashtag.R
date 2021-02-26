#' Get Parler Posts by Hashtag
#'
#' Gets Parler Posts by hashtag
#' @param hashtag Parler user handle.
#' @param output_format Options include: `data.frame` (flattened, one row per post), `list`, and `json` (raw json file)
#' @param flatten_sep Separator used to flatten nested variables (e.g. multiple badges per user). Defaults to ` || `
#' @param parse_numbers Whether to parse numbers from Parler's format to numeric (e.g. from `16k` to 16000)
#' @param verbose Whether to print additional information while scraping
#' @param timeout Whether to stop the scraping after an amount of timeout seconds.
#' @return A dataframe with one row for each post and a column for each variable.
#' @details Warning: ...
#' @examples
#' \dontrun{
#' out <-
#'   parler_hashtag(hashtag  = "nocovidvaccine",
#'                  output_format = "data.frame",
#'                  flatten_sep = " || ",
#'                  parse_numbers = TRUE,
#'                  verbose = TRUE)
#'
#' print(colnames(out))
#' }
#' @export
parler_hashtag <- function(hashtag,
                           output_format = "data.frame",
                           flatten_sep = " || ",
                           parse_numbers = TRUE,
                           verbose = FALSE,
                           timeout = 600){

  tmp_json <- paste0(tempfile(),".json")

  if(verbose == T) print(paste0("Scraping Parley including hashtag '#",hashtag,"'. This might take a while."))

  noprint <-
    system(paste0("parlance tag --tag ", hashtag," --silent TRUE >> ",
                  tmp_json),
           intern = TRUE,
           timeout = timeout)




  jsonlist <- try(jsonlite::read_json(tmp_json, simplifyVector = FALSE),silent = T)

  if (class(jsonlist) == "try-error") {
    raw_file <- readr::read_file(tmp_json) %>%
      paste0(.,"\n]")

    jsonlist <-
      jsonlite::parse_json(raw_file,simplifyVector = FALSE)



  }else{
    raw_file <- readr::read_file(tmp_json)
  }


  # to

  if(output_format == "data.frame"){

    out_df <- purrr::map(.x = jsonlist,
                         .f = ~
                           parse_post(pj = .x,
                                      flatten_sep = flatten_sep,
                                      parse_numbers = parse_numbers,
                                      verbose = verbose)
    ) %>% dplyr::bind_rows()


    file.remove(tmp_json)
    return(out_df)

  }else if(output_format == "list"){

    file.remove(tmp_json)
    return(jsonlist)

  }else if(output_format == "json"){

    file.remove(tmp_json)
    return(raw_file)
  }

  return(NULL)
}
