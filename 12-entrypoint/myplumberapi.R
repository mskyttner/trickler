
#* @get /counter
function(req){

  count <- 0
  if (!is.null(req$session$counter)){
    count <- as.numeric(req$session$counter)
  }
  req$session$counter <- count + 1
  return(paste0("This is visit # (number): ", count))
}

#* @get /drop/mountdir
function() {
	Sys.getenv("PLUMBER_DIR")
}

#* @get /drop/mountdir/files
function() {
	dir(Sys.getenv("PLUMBER_DIR"))
}

#* @get /plumber/apis/available
function() {
	plumber::available_apis()
}

#* @get /plumber/version
function() {
	as.character(packageDescription("plumber"))
}

#* @get /sessioninfo
function() {
	as.character(sessionInfo())
}

#* @get /readme
function(res) {
   res$status <- 302
   res$setHeader("Location", "/__docs__/")
}

#* @get /ps
function(res) {
   system("ps aux", intern = TRUE)
}

#* @get /
#* @serializer html
function(res) {
   links <- c(
"/counter",
"/sessioninfo",
"/plumber/version",
"/plumber/apis/available",
"/drop/mountdir",
"/drop/mountdir/files",
"/readme"
)
	paste(collapse = "\n", sprintf("<li><a href='%s'>%s</a></li>", links, links))
}

