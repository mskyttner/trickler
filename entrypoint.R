library(plumber)

#pswd_file <- file.path(tempdir(), "normal_file.txt")
pswd_file <- "normal_file.txt"
if (!file.exists(pswd_file)) {
	cat(random_cookie_key(), file = pswd_file)
	Sys.chmod(pswd_file, mode = "0600")
}

pr <- pr("myplumberapi.R") %>%
	pr_cookie(
         readLines(pswd_file, warn = FALSE)
	)

# MUST return a Plumber object when using `entrypoint.R`
#pr$run(host = "0.0.0.0", port = 8080)

pr
