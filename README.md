# README

When developing plumber APIs, it would be nice to be able to mount a local PLUMBER_DIR into a container for "live reload" changes to appear instantly at for example http://localhost:8000. 

Here we use plumber with autoreload provided through a container, which provides R and python and where additional packages can be provided through 'pkgs-cran.txt' and 'pkgs-github.txt'.

Some example plumber applications are provided in the 12-entrypoint and rpy directories (see docker-compose.yml)

## Usage

Use the Makefile targets:

		make up

Then edit files locally in the 12-entrypoint or rpy directories and refresh in the browser.

Logs are provided through "docker-compose logs -f"

