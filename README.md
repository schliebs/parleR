
<!-- README.md is generated from README.Rmd. Please edit that file -->

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

``` r
post_df1 <- 
  parler_posts(user = "Grenell",
               output_format = "data.frame",
               flatten_sep = " || ",
               parse_numbers = TRUE,
               verbose = TRUE)
#> [1] "Scraping profile information for 'Grenell'. This might take a while."
```

``` r
colnames(post_df1)
#>  [1] "id1"                      "at"                      
#>  [3] "article"                  "body"                    
#>  [5] "comments"                 "createdAt"               
#>  [7] "creator_id"               "creator_bio"             
#>  [9] "creator_blocked"          "creator_human"           
#> [11] "creator_integration"      "creator_joined"          
#> [13] "creator_name"             "creator_rss"             
#> [15] "creator_private"          "creator_profilePhoto"    
#> [17] "creator_username"         "creator_verified"        
#> [19] "creator_verifiedComments" "creator_"                
#> [21] "creator_score"            "creator_interactions"    
#> [23] "creator_media"            "creator_badges"          
#> [25] "depth"                    "depthRaw"                
#> [27] "hashtags"                 "id"                      
#> [29] "impressions"              "links"                   
#> [31] "preview"                  "reposts"                 
#> [33] "shareLink"                "sensitive"               
#> [35] "state"                    "upvotes"                 
#> [37] "parent"                   "root"
```

``` r
post_df1 %>% 
  dplyr::select(creator_username,createdAt,impressions,upvotes,body)
#> # A tibble: 83 x 5
#>    creator_username createdAt     impressions upvotes body                      
#>    <chr>            <chr>               <dbl>   <dbl> <chr>                     
#>  1 Grenell          2021-01-09T0~      241000    6500 "Start following people -~
#>  2 Grenell          2021-01-09T0~      127000    1700 "Start following people -~
#>  3 Grenell          2021-01-07T0~      298000    2300 "I’ll be on with @SeanHan~
#>  4 Grenell          2021-01-03T1~      333000    2500 ""                        
#>  5 Grenell          2021-01-03T1~      922000    9200 ""                        
#>  6 Grenell          2021-01-03T1~      905000    9200 ""                        
#>  7 Grenell          2021-01-01T2~      333000    2500 "New year means opening u~
#>  8 Grenell          2020-12-31T1~      147000    1500 ""                        
#>  9 Grenell          2020-12-26T1~      410000    3900 ""                        
#> 10 Grenell          2020-12-25T1~      410000    3900 "Today I’m thinking of th~
#> # ... with 73 more rows
```

## Get all Posts with a certain Hashtag

Because there are thousands of posts, we time out the request after a
certain amount of seconds.

``` r
hashtag_posts_df1 <- 
  parler_hashtag(hashtag = "nocovidvaccine",
                 output_format = "data.frame",
                 flatten_sep = " || ",
                 parse_numbers = TRUE,
                 verbose = TRUE,
                 timeout = 60)
#> [1] "Scraping Parley including hashtag '#nocovidvaccine'. This might take a while."
```

``` r
colnames(hashtag_posts_df1)
#>  [1] "id1"                      "at"                      
#>  [3] "article"                  "body"                    
#>  [5] "comments"                 "createdAt"               
#>  [7] "creator_id"               "creator_bio"             
#>  [9] "creator_blocked"          "creator_coverPhoto"      
#> [11] "creator_human"            "creator_integration"     
#> [13] "creator_joined"           "creator_name"            
#> [15] "creator_rss"              "creator_private"         
#> [17] "creator_profilePhoto"     "creator_username"        
#> [19] "creator_verified"         "creator_verifiedComments"
#> [21] "creator_"                 "creator_score"           
#> [23] "creator_interactions"     "creator_media"           
#> [25] "creator_badges"           "depth"                   
#> [27] "depthRaw"                 "hashtags"                
#> [29] "id"                       "impressions"             
#> [31] "links"                    "preview"                 
#> [33] "reposts"                  "shareLink"               
#> [35] "sensitive"                "state"                   
#> [37] "upvotes"                  "creator_state"           
#> [39] "parent"                   "root"
```

``` r
hashtag_posts_df1 %>% 
  head(50) %>% 
  dplyr::select(creator_username,createdAt,impressions,upvotes,body)
#> # A tibble: 50 x 5
#>    creator_username  createdAt    impressions upvotes body                      
#>    <chr>             <chr>              <dbl>   <dbl> <chr>                     
#>  1 Bbobby            2021-01-10T~         588       6 "Just cause I'd like to s~
#>  2 danthevann        2021-01-10T~          23       0 "This free speech stuff i~
#>  3 Bbobby            2021-01-10T~         580       4 "Vigano \n#StopTheSteal #~
#>  4 GnarshipEnterpri~ 2021-01-10T~         312       5 "Did you hear about a new~
#>  5 shadowdances      2021-01-10T~         192       0 "#vaccines #vaccineinjury~
#>  6 Scritchbeat       2021-01-10T~        2000      10 "#VoterFraud #StopTheStea~
#>  7 Scritchbeat       2021-01-10T~        2100      12 "#VoterFraud #StopTheStea~
#>  8 Scritchbeat       2021-01-10T~        2100      13 "#VoterFraud #StopTheStea~
#>  9 Bushpilot182      2021-01-10T~         456       1 "Covid Vaccine Death\n\n#~
#> 10 Scritchbeat       2021-01-10T~        2500      12 "#VoterFraud #StopTheStea~
#> # ... with 40 more rows
```

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
#> 1 Casey B~ caseybmu~    121000        63   125 261   2020-10~ "You're Hired! Un~
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
#>  $ score           : chr "44k"
#>  $ interactions    : int 259
#>  $ state           : int 1
#>  $ banned          : logi FALSE
#>  $ isFollowingYou  : logi FALSE
#>  $ comments        : chr "50"
#>  $ followers       : chr "121k"
#>  $ following       : chr "63"
#>  $ likes           : chr "125"
#>  $ posts           : chr "261"
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
#> Warning: Outer names are only allowed for unnamed scalar atomic inputs
#> New names:
#> * `` -> ...19
#> Warning: Outer names are only allowed for unnamed scalar atomic inputs
#> New names:
#> * `` -> ...20
#> Warning: Outer names are only allowed for unnamed scalar atomic inputs
#> New names:
#> * `` -> ...21
#> Warning: Outer names are only allowed for unnamed scalar atomic inputs
#> New names:
#> * `` -> ...20
#> New names:
#> * ...19 -> ...15
#> New names:
#> * ...20 -> ...16
#> New names:
#> * ...21 -> ...16
#> New names:
#> * ...20 -> ...16
```

``` r
out_df %>% 
    select(name,username,followers,following,likes,posts,joined,bio)
#> # A tibble: 7 x 8
#>   name     username  followers following likes posts joined   bio               
#>   <chr>    <chr>         <dbl>     <dbl> <dbl> <chr> <chr>    <chr>             
#> 1 Mark Le~ Marklevi~   4900000         4     0 3.5k  2019-06~ "THIS IS THE OFFI~
#> 2 Sean Ha~ SeanHann~   7600000         7     0 2.5k  2020-06~ "TV Host Fox News~
#> 3 Devin N~ Devinnun~   2900000       160   528 1.7k  2020-02~  <NA>             
#> 4 Gov. Kr~ Governor~    790000        36     0 40    2020-11~ "South Dakotan. W~
#> 5 Katie H~ KTHopkins    473000         1     8 1.3k  2020-06~ "the Biggest Bitc~
#> 6 Westmon~ Westmons~    149000         2     0 1.4k  2020-06~ "WESTMONSTER.COM ~
#> 7 Tommy R~ TommyRob~    361000       248    94 6.8k  2019-06~ "I’m back \n\nhtt~
```
