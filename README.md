# README

Running plumber in a container, with R and python installed.

When developing plumber APIs, it would be nice to be able to mount a local PLUMBER_DIR into a container for "live reload" changes to appear instantly at for example http://localhost:8000. 

## Usage

Use the Makefile targets:

		make build
		make test-default
		make up

## Issues / questions

When developing plumber files located locally in the PLUMBER_DIR, changes are expected to immediately trickle (live deploy/reload/autoreload) in the plumber server.

A few observations and questions:

- The default plumber example in 12-entrypoint (gets installed with plumber R package) does not run pr$run() ?
