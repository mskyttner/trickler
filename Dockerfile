FROM golang AS builder
RUN go get -u github.com/radovskyb/watcher/...
# watcher binary can now be installed in next stage

FROM rstudio/plumber  

COPY --from=builder /go/bin/watcher /usr/local/bin

RUN apt-get update -y && apt-get install -y \
	tini \
	iproute2 \
	lsof \
	inotify-tools

# update to use some latest plumber related packages
COPY pkgs-cran.txt /pkgs/
COPY pkgs-github.txt /pkgs/
RUN R -e "install.packages(readLines('/pkgs/pkgs-cran.txt'))"
RUN R -e "devtools::install_github(readLines('/pkgs/pkgs-github.txt'))"
RUN R -e "reticulate::install_miniconda()"

# set the server to restart when there are changes in the PLUMBER_DIR
ENTRYPOINT ["tini", "--"]
ENV PLUMBER_DIR=/usr/local/lib/R/site-library/plumber/plumber/12-entrypoint
COPY /start-trickler.R .
COPY /reloadr.sh .
#CMD ["bash", "-c", "cd ${PLUMBER_DIR} && watcher -list -cmd='/start-trickler.R' -startcmd ."]
CMD ["bash", "-c", "cd ${PLUMBER_DIR} && /reloadr.sh"]
