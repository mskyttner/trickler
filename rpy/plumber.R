#* @apiTitle example api

#* example endpoint
#* @param message A message
#* @get /rpy
function(message) {

	if (missing(message)) 
		message <- "Hello from plumb-rpy!"

	module$show_message(message)
}
