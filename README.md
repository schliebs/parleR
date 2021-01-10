
  - [parleR](#parler)
      - [Pre-Installation Steps and System
        Requirements](#pre-installation-steps-and-system-requirements)
      - [Installation and Loading](#installation-and-loading)
      - [API Authentication](#api-authentication)
      - [Get Posts by Username](#get-posts-by-username)
      - [Get User Profile Data](#get-user-profile-data)

<!-- README.md is generated from README.Rmd. Please edit that file -->

# parleR

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/ggecon)](https://CRAN.R-project.org/package=ggecon)
<!-- badges: end -->

## Pre-Installation Steps and System Requirements

### Installing node.js

### Installing parlance

### Creating a Parler Profile and Obtaining Cookies

Disclaimer: The end user uses this piece of software at their own legal
responsibility. The authors do not take any responsibility for how you
use the piece of software. We do not encouragement the breach of Terms
of Service of any company, except in legally and ethically permitted
cases.

## Installation and Loading

``` r
devtools::install_github("schliebs/parleR")
```

``` r
library(parleR)
```

``` r
library(tidyverse)
#> -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
#> v ggplot2 3.3.2     v purrr   0.3.4
#> v tibble  3.0.4     v dplyr   1.0.2
#> v tidyr   1.1.2     v stringr 1.4.0
#> v readr   1.4.0     v forcats 0.5.0
#> -- Conflicts ------------------------------------------ tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
```

## API Authentication

There are two options to set a CT API token and save it in the system
environment. The first one is to trigger an RStudio window opening, and
entering the token.

## Get Posts by Username

## Get User Profile Data

### Raw JSON String

NOT WORKING YET, FIX TOMORROW\!

``` r
json_str <- 
  parler_profile(user = "TuckerCarlson",
                 output_format = "json",
                 flatten_sep = " || ",
                 verbose = FALSE)
```

### R data.frame (nested variables flattened)

``` r
out <-
  parler_profile(user = "caseybmulligan",
                 output_format = "data.frame",
                 flatten_sep = " || ",
                 token_variables = F,
                 parse_numbers = TRUE,
                 verbose = TRUE)
#> [1] "Scraping profile information for caseybmulligan"
#> Warning in if (x == "0") {: the condition has length > 1 and only the first
#> element will be used
#> Warning: Flattened variable 'badges' of length 2 with separator ' || '
```

``` r
colnames(out)
#>  [1] "accountColor"     "bio"              "blocked"          "coverPhoto"      
#>  [5] "human"            "id"               "integration"      "joined"          
#>  [9] "name"             "private"          "profilePhoto"     "rss"             
#> [13] "username"         "verified"         "verifiedComments" "badges"          
#> [17] "score"            "interactions"     "state"            "banned"          
#> [21] "comments"         "followers"        "following"        "likes"           
#> [25] "posts"            "media"
```

``` r
out %>% 
  select(name,username,followers,following,likes,posts,joined,bio)
#> # A tibble: 1 x 8
#>   name     username  followers following likes posts joined   bio               
#>   <chr>    <chr>         <dbl>     <dbl> <dbl> <chr> <chr>    <chr>             
#> 1 Casey B~ caseybmu~    122000        64   123 252   2020-10~ "You're Hired! Un~
```

### Without Token-associated variables

``` r
out2 <-
  parler_profile(user = "caseybmulligan",
                 output_format = "data.frame",
                 flatten_sep = " || ",
                 token_variables = TRUE,
                 parse_numbers = TRUE,
                 verbose = TRUE)
#> [1] "Scraping profile information for caseybmulligan"
#> Warning in if (x == "0") {: the condition has length > 1 and only the first
#> element will be used
#> Warning: Flattened variable 'badges' of length 2 with separator ' || '
```

``` r
colnames(out2)
#>  [1] "accountColor"     "bio"              "blocked"          "coverPhoto"      
#>  [5] "followed"         "human"            "id"               "integration"     
#>  [9] "joined"           "name"             "muted"            "pendingFollow"   
#> [13] "private"          "profilePhoto"     "rss"              "username"        
#> [17] "verified"         "verifiedComments" "badges"           "score"           
#> [21] "interactions"     "state"            "banned"           "isFollowingYou"  
#> [25] "comments"         "followers"        "following"        "likes"           
#> [29] "posts"            "media"
```

New colnames which are only outputtet if `token_variables == TRUE`:

``` r
colnames(out2) %>% .[!. %in% colnames(out)]
#> [1] "followed"       "muted"          "pendingFollow"  "isFollowingYou"
```

### JSON List Object

``` r
jlist <- 
  parler_profile(user = "caseybmulligan",
                 output_format = "list",
                 flatten_sep = " || ",
                 verbose = FALSE)
```

``` r
str(jlist)
#> List of 31
#>  $ _id             : chr "ccab997e08254afe9231c35857f95d81"
#>  $ accountColor    : chr "#4aa046"
#>  $ bio             : chr "You're Hired! Untold Successes and Failures of a Populist President. yourehiredtrump.com \"Profound, important,"| __truncated__
#>  $ blocked         : logi FALSE
#>  $ coverPhoto      : chr "1ff7f29dc2134ab0828d0a090c607711"
#>  $ followed        : logi FALSE
#>  $ human           : logi TRUE
#>  $ id              : chr "ccab997e08254afe9231c35857f95d81"
#>  $ integration     : logi FALSE
#>  $ joined          : chr "20201015232824"
#>  $ name            : chr "Casey B. Mulligan"
#>  $ muted           : logi FALSE
#>  $ pendingFollow   : logi FALSE
#>  $ private         : logi FALSE
#>  $ profilePhoto    : chr "bae299d65951425d8a2e3daa8a1d540b"
#>  $ rss             : logi FALSE
#>  $ username        : chr "caseybmulligan"
#>  $ verified        : logi TRUE
#>  $ verifiedComments: logi FALSE
#>  $ badges          :List of 2
#>   ..$ : int 1
#>   ..$ : int 0
#>  $ score           : chr "43k"
#>  $ interactions    : int 259
#>  $ state           : int 1
#>  $ banned          : logi FALSE
#>  $ isFollowingYou  : logi FALSE
#>  $ comments        : chr "50"
#>  $ followers       : chr "122k"
#>  $ following       : chr "64"
#>  $ likes           : chr "123"
#>  $ posts           : chr "252"
#>  $ media           : chr "27"
```

### Multiple Users

``` r
user_vec <- c("Marklevinshow","SeanHannity","Devinnunes","GovernorNoem",
              "KTHopkins","Westmonster","TommyRobinson")

out_df <- 
  purrr::map(.x = user_vec,
           .f = ~ 
             parler_profile(user = .x,
                            output_format = "data.frame",
                            flatten_sep = " || ",
                            token_variables = FALSE,
                            parse_numbers = TRUE,
                            verbose = FALSE)
           ) %>% 
  bind_rows()
#> Warning in if (x == "0") {: the condition has length > 1 and only the first
#> element will be used

#> Warning in if (x == "0") {: the condition has length > 1 and only the first
#> element will be used
#> Warning: Outer names are only allowed for unnamed scalar atomic inputs
#> New names:
#> * `` -> ...19
#> Warning: Outer names are only allowed for unnamed scalar atomic inputs
#> New names:
#> * `` -> ...20
#> Warning in if (x == "0") {: the condition has length > 1 and only the first
#> element will be used

#> Warning in if (x == "0") {: Outer names are only allowed for unnamed scalar
#> atomic inputs
#> New names:
#> * `` -> ...21
#> Warning: Outer names are only allowed for unnamed scalar atomic inputs
#> New names:
#> * `` -> ...20
```

``` r
out_df %>% 
    select(name,username,followers,following,likes,posts,joined,bio)
#> # A tibble: 7 x 8
#>   name     username  followers following likes posts joined   bio               
#>   <chr>    <chr>         <dbl>     <dbl> <dbl> <chr> <chr>    <chr>             
#> 1 Mark Le~ Marklevi~   4800000         4     0 3.5k  2019-06~ "THIS IS THE OFFI~
#> 2 Sean Ha~ SeanHann~   7400000         7     0 2.5k  2020-06~ "TV Host Fox News~
#> 3 Devin N~ Devinnun~   5300000       318   525 1.7k  2020-02~  <NA>             
#> 4 Gov. Kr~ Governor~    717000        36     0 40    2020-11~ "South Dakotan. W~
#> 5 Katie H~ KTHopkins    467000         0     8 1.3k  2020-06~ "the Biggest Bitc~
#> 6 Westmon~ Westmons~    149000         2     0 1.4k  2020-06~ "WESTMONSTER.COM ~
#> 7 Tommy R~ TommyRob~    346000       243    94 6.8k  2019-06~ "I’m back \n\nhtt~
```
