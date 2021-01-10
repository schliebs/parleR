#' Authenticate
#'
#' xxx
#' @param decode Whether MST and JST tokens should be decoded before storing. `BOOLEAN` defaulting to `TRUE`.
#' @param path Path where to store the authentication file. Currently needs to stay './config/auth.json'.
#' @param option How JST and MST tokens shall be entered. `str` defaulting to 'enter'.
#' @details Warning: This functions writes an authentication file to a json-file in
#' ./confic/auth.json
#' @examples
#' \dontrun{
#' # parler_auth()
#' }
#' @export
parler_auth <- function(decode = TRUE,
                          path = "config/auth.json",
                          option = "enter",
                          mst = NULL,
                          jst = NULL){

  if(!path %in% c("config/auth.json",
                  "./config/auth.json")){
    warning("Path must be './config/auth.json'")
  }

  dir.create("./config", showWarnings = FALSE)

  if(option == "enter"){
    mst <- rstudioapi::askForPassword("Please enter your MST Token")
    jst <- rstudioapi::askForPassword("Please enter your JST Token")
  }else{
    print("Currently only RStudio promopt entering is supported. ")
  }

  if(decode == TRUE){
    mst <- utils::URLdecode(mst)
    jst <- utils::URLdecode(jst)
  }

  json_str <- paste0("{'mst' : '",mst,"', 'jst' : '",jst,"'}")

  json_str <- paste0("{\"mst\" : \"",mst,"\", \"jst\" : \"",jst,"\"}")

  write(x = json_str,
        file = path)


  return(NULL)
}

#parlance_init()
