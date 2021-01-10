
#' Parse Parler Time Format
#'
#' Parse Time Format from Parler
#'
#' @param parltime A parler timestamp
#' @param out_format Either `character` (ISO8601) or `POSIXlt`
#' @details ...
#' @examples
#' parler_time(parltime = "20201015232824",
#'             out_format = "character")
#' @export
parler_time <- function(parltime,
                        out_format = "character"){

  lubri <-
    lubridate::fast_strptime(x = parltime,
                             format = "%Y%m%d%H%M%S")

  if(out_format == "POSIXlt"){
    return(lubri)
  }else  if(out_format == "character"){
    out <-
      lubri %>%
      lubridate::format_ISO8601()
    return(out)
  }
}

#' Planned sleep times
#'
#' Pause the execution of a script either until a certain time is reached,
#' or until a specified amount of time has passed.
#'
#' @param resume A datetime object, representing when the script shall resume.
#' @param from A datetime object, when the beginning of the sleep interval.
#' @param seconds An integer, representing the amount of seconds to wait.
#' @details  Takes either `resume` OR a combination of `from` and `seconds`.
#' @export
#' @examples
#' # Continue script after 20:30:34 on November 14th 2020
#'
#' continue_at <- lubridate::as_datetime("2020-11-14 20:30:34")
#' wait_till(resume = continue_at, seconds = 12)
#'
#' # Continue script 12 seconds after the last call was made
#'
#' last_timestamp <- lubridate::now()
#' wait_till(from = last_timestamp, seconds = 12)
wait_till <- function(from = NULL,
                       resume = NULL,
                       seconds = NULL){

  if(is.null(resume)) resume = from + lubridate::seconds(seconds)
  print(paste0("Pausing Scripts until ",resume))
  while(resume > lubridate::now()){
    Sys.sleep(1)
    }
}

