
library(plumber)
pr <- pr("myplumberapi.R") %>%
  pr_cookie(
    key = "pleasechangeme",
    name = "cookieName"
  )

# MUST return a Plumber object when using `entrypoint.R`
pr$run(host = "0.0.0.0", port = 8000)
