source('global.R')

pr("plumber.R") %>%
    pr_run(port = 8080, host = "0.0.0.0")
