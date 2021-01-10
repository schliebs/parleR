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
