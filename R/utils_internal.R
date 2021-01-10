parler_number <-
  function(parlnumber){

    if(stringr::str_detect(parlnumber,"k")){
      out_number <-
        parlnumber %>%
        stringr::str_remove("k") %>%
        as.numeric(.) %>%
        {. * 1000}
    }else if(stringr::str_detect(parlnumber,"m")){
      out_number <-
        parlnumber %>%
        stringr::str_remove("m") %>%
        as.numeric(.) %>%
        {. * 1000000}
    }else{
      out_number <-
        parlnumber %>% as.numeric()
    }

    return(out_number)
  }

#parler_number(parlnumber = "17k")


.onAttach <-
  function(libname, pkgname) {
    packageStartupMessage("\nPlease cite as: \n")
    packageStartupMessage(" Schliebs, Marcel & Quelle, Dorian (2021). parleR: R Interface to parler.com.\n")
    packageStartupMessage(" R package version 0.9.0.0 schliebs.github.io/parleR\n\n")
    packageStartupMessage(" Full credits for the underlying backend go to 'parlance' by 'castlelemongrab'.\n")
    packageStartupMessage(" We thank the authors of parlance for their code, without which 'parleR' would not.\n")
    packageStartupMessage(" have been possible. Check their work out here: https://github.com/castlelemongrab/parlance\n")
  }
