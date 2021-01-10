# Internal Function: Parse Profile
parse_profile <- function(jsonlist,
                          flatten_sep = " || ",
                          token_variables = FALSE,
                          parse_numbers = TRUE,
                          verbose = FALSE){

  jl <- jsonlist

  prof_df <-
    purrr::map2_dfc(.x = jl,
                    .y = names(jl),
             .f = function(x,y){

               if(is.null(x)){
                 return(NA)
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
             }) #%>% purrr::set_names(nm = names(jl))


  ### other pre-processing to be implemented HERE

  num_vars <- c("score","interactions","comments","followers","following","likes","media")

  prof_df$joined <- prof_df$joined %>% parler_time(parltime = .,
                                                   out_format = "character")

  num_vars2 <-
    num_vars %>% .[. %in% colnames(prof_df)]

  if(! "media" %in% colnames(prof_df)){
    prof_df$media <- NA
  }

  if(! "badges" %in% colnames(prof_df)){
    prof_df$badges <- NA
  }

  prof_df <-
    prof_df %>%
    dplyr::mutate(dplyr::across(.cols = all_of(num_vars2),
                                .fns = parler_number)) %>%
    dplyr::mutate(badges = badges %>% as.character(),
           media = media %>% as.character())#check here

  ####
  if(token_variables == FALSE){

    vars <- colnames(prof_df) %>% .[! . %in% c("_id",#duplicate with id
                                               "-blocked",
                                                "followed",
                                                "muted",
                                                "pendingFollow",
                                                "isFollowingYou",
                                                "subscribed")] # fix subscribed

    final_df <-
      prof_df %>%
      dplyr::select(any_of(vars))

    return(final_df)

  }else if(token_variables == TRUE){

    vars <- colnames(prof_df) %>% .[! . %in% c("_id",#duplicate with id
                                               "subscribed")]

    final_df <-
      prof_df %>%
      dplyr::select(any_of(vars))

    return(final_df)
  }

}

#parse_profile(jsonlist)




#' Get Parler Profile Data
#'
#' Gets Relevant Profile/User Metadata by username
#' @param user Parler user handle.
#' @param output_format Options include: `data.frame` (flattened), `list`, and `json` (raw json file)
#' @param flatten_sep Separator used to flatten nested variables (e.g. multiple badges per user). Defaults to ` || `
#' @param token_variables Whether to output information associated with token (e.g. follower relationship between token user and scraped user). Defaults to `FALSE`
#' @param parse_numbers Whether to parse numbers from Parler's format to numeric (e.g. from `16k` to 16000)
#' @param verbose Whether to print additional information while scraping
#' @return A dataframe with one row and a column for each variable.
#' @details Warning: ...
#' @examples
#' \dontrun{
#' out <-
#'   parler_profile(user = "caseybmulligan",
#'                  output_format = "data.frame",
#'                  flatten_sep = " || ",
#'                  token_variables = FALSE,
#'                  parse_numbers = TRUE,
#'                  verbose = TRUE)
#'
#' print(colnames(out))
#' }
#' @export
parler_profile <- function(user,
                           output_format = "data.frame",
                           flatten_sep = " || ",
                           token_variables = FALSE,
                           parse_numbers = TRUE,
                           verbose = FALSE){

  tmp_json <- paste0(tempfile(),".json")


  if(verbose == T) print(paste0("Scraping profile information for ",user))
  noprint <-
    system(paste0("parlance profile --username ", user," --silent TRUE >> ",
                  tmp_json),
           intern = TRUE)

  jsonlist <- jsonlite::read_json(tmp_json, simplifyVector = FALSE)[[1]]

  if(output_format == "data.frame"){

    out_df <-
      parse_profile(jsonlist = jsonlist,
                    flatten_sep = flatten_sep,
                    token_variables = token_variables,
                    parse_numbers = parse_numbers,
                    verbose = verbose)


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





