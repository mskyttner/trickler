#! make

build:
	# builds a test container with drip and R and plumber installed
	docker build --load -t mskyttner/trickler .

test-default:
	# seems not to work? because default example app at
	# /usr/local/lib/R/site-library/plumber/plumber/12-entrypoint
	# does not use pr$run()?
	docker run --rm mskyttner/trickler

up:

	docker-compose up -d
	firefox http://localhost:8000/counter &
	firefox http://localhost:8001/ &
	firefox http://localhost:8003/rpy &


