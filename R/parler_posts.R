# Internal Function: Parse Profile
parse_post <- function(pj,
                       flatten_sep = " || ",
                       parse_numbers = TRUE,
                       verbose = FALSE){

  post_df <-
    purrr::map2_dfc(.x = pj,
                    .y = names(pj),
                    .f = function(x,y){

                      if(is.null(x)){
                        return(NA)
                      }

                      if(y == "creator"){
                        user_df <- parse_profile(pj$creator,
                                                 flatten_sep = " || ",
                                                 token_variables = FALSE,
                                                 parse_numbers = TRUE,
                                                 verbose = FALSE) %>%
                          purrr::set_names(nm = paste0("creator_",colnames(.)))
                        return(user_df)
                      }

                      if(y == "links"){
                        # make more elaborate later, for now just URLs
                        li <-
                          purrr::map(.x = pj$links,
                                     .f = ~.x %>%
                                       .[["long"]])  %>%
                          paste0(.,collapse = flatten_sep)
                        return(li)
                      }

                      if(y == "hashtags"){
                        # make more elaborate later, for now just URLs
                        ht <-
                          purrr::map(.x = pj$hashtags,
                                     .f = ~.x )  %>%
                          paste0(.,collapse = flatten_sep)
                        return(ht)
                      }

                      if(y == "@"){
                        # make more elaborate later, for now just URLs
                        at <-
                          purrr::map(.x = pj[["@"]],
                                     .f = ~.x )  %>%
                          paste0(.,collapse = flatten_sep)
                        return(at)
                      }


                      if(length(x) == 1){
                        return(x)
                      }else if(length(x) > 1){
                        conc <- paste0(x,collapse = flatten_sep)
                        if(verbose == TRUE){
                          warning(paste0("Flattened variable '",y,"' of length ",length(x),
                                         " with separator '",flatten_sep,"'"),
                                  call. = FALSE)
                        }
                        return(conc)
                      }
                    }) #%>% purrr::set_names(nm = names(pj))

  colnames(post_df)[colnames(post_df) == "_id"] <- "id1"
  colnames(post_df)[colnames(post_df) == "@"] <- "at"


  ### other pre-processing to be implemented HERE

  num_vars <- c("impressions","reposts","upvotes","comments")
  num_vars2 <-
    num_vars %>% .[. %in% colnames(post_df)]

  post_df$createdAt <- post_df$createdAt %>% parler_time(parltime = .,
                                                   out_format = "character")

  post_df <-
    post_df %>%
    dplyr::mutate(dplyr::across(.cols = any_of(num_vars2),
                                .fns = parler_number))

  ####

  return(post_df)

}

#parse_profile(jsonlist)




#' Get Parler User Posts
#'
#' Gets Posts by username
#' @param user Parler user handle.
#' @param output_format Options include: `data.frame` (flattened, one row per post), `list`, and `json` (raw json file)
#' @param flatten_sep Separator used to flatten nested variables (e.g. multiple badges per user). Defaults to ` || `
#' @param parse_numbers Whether to parse numbers from Parler's format to numeric (e.g. from `16k` to 16000)
#' @param verbose Whether to print additional information while scraping
#' @return A dataframe with one row for each post and a column for each variable.
#' @details Warning: ...
#' @examples
#' \dontrun{
#' out <-
#'   parler_posts(user = "Grenell",
#'                  output_format = "data.frame",
#'                  flatten_sep = " || ",
#'                  parse_numbers = TRUE,
#'                  verbose = TRUE)
#'
#' print(colnames(out))
#' }
#' @export
parler_posts <- function(user,
                         output_format = "data.frame",
                         flatten_sep = " || ",
                         parse_numbers = TRUE,
                         verbose = FALSE){

  tmp_json <- paste0(tempfile(),".json")

  if(verbose == T) print(paste0("Scraping profile information for '",user,"'. This might take a while."))
  noprint <-
    system(paste0("parlance posts --username ", user," --silent TRUE >> ",
                  tmp_json),
           intern = TRUE)


  # AB HIER ENTFERNEN
  file.copy(tmp_json,paste0("C://Users/ms/Desktop/parl/",
                            tmp_json %>%
                              stringr::str_extract("(?<=\\\\Temp\\\\).*?(?=.json)") %>%
                              stringr::str_replace_all("\\\\","__"),
                            ".json"))

  # BIS HIER ENTFERNEN

  jsonlist <- jsonlite::read_json(tmp_json, simplifyVector = FALSE)

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

    raw_file <- readr::read_file(tmp_json)
    file.remove(tmp_json)
    return(raw_file)
  }

  return(NULL)
}



