#!/usr/bin/env Rscript

# uses env TRICKLER_PORT or 8080L as default (first arg) and "entrypoint.R" as default (second arg)
# or these can be set explicitly "./start-drop.R 8080 entrypoint.R

args <- commandArgs(trailingOnly = TRUE)

# determine which port to use (check env and arg)
port <- 8080L  # default

if (Sys.getenv("TRICKLER_PORT") != "") 
	port <- as.integer(Sys.getenv("TRICKLER_PORT"))

if (length(args) >=1) 
	port <- as.integer(args[1])

listening <- as.integer(system("ss -tulpnH | awk '{print $5}' | cut -d: -f 2", intern = TRUE))
message("Ports already in use are: ")
print(listening)

stopifnot(is.integer(port))
stopifnot(port > 1 && port < 65535)

if (port %in% listening) {
	pid <- system(paste0("lsof -t -i:", port), intern = TRUE)
	#cat(sprintf("Reaping pid %s which is occupied on port %s\n", pid, port))
	#httpuv::stopAllServers()
	#system(paste0("while kill -0 ", pid, " 2> /dev/null; do sleep 1; done;"), intern = TRUE)
	#system(paste0("timeout 2 tail --pid=", pid, " -f /dev/null"), wait = TRUE, timeout = 3)
}


# get pr reference from entrypoint
ep <- "entrypoint.R"

if (length(args) >=2)
        ep <- args[2]

source(ep, local = TRUE)

# print routes
pr()

# run it
plumber::pr_run(pr, host = "0.0.0.0", port = port)
