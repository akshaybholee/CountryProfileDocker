FROM ubuntu:18.04
FROM rocker/r-ubuntu:18.04  
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update -y && apt-get install -y build-essential curl libssl1.0.0 libssl-dev gnupg2 software-properties-common dirmngr apt-transport-https apt-utils lsb-release ca-certificates
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'
RUN apt-get update -y && apt-get install -y r-base

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update -y
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev mssql-tools


RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libgdal-dev\
    unixodbc\
    unixodbc-dev\
    && rm -rf /var/lib/apt/lists/*

RUN R -e 'install.packages(c(\
              "shinydashboard",  \
              "shinyjs", \
                "dplyr", \
                "stringr", \
                "sqldf", \
                "scales", \
                "DT", \
                "plyr", \
                "odbc", \
                "pool", \
                "shinydashboardPlus", \
                "waiter", \
                "feather" \
            ), \
            repos="https://packagemanager.rstudio.com/cran/__linux__/focal/2021-04-23"\
          )'


RUN Rscript -e "install.packages('formattable')"
RUN Rscript -e "install.packages('echarts4r')"
RUN Rscript -e "install.packages('highcharter')"
RUN Rscript -e "install.packages('leaflet')"
RUN Rscript -e "install.packages('rworldmap')"
RUN Rscript -e "install.packages('leaflet.extras')"

RUN Rscript -e "install.packages('leaflegend')"
RUN Rscript -e "install.packages('shiny')"
RUN Rscript -e "install.packages('devtools')"

RUN installGithub.r mattflor/chorddiag


RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    libudunits2-dev \
    libgeos-dev \
    libproj-dev \


RUN install2.r --error \
                units
                
RUN install2.r --error \
                sf 

RUN install2.r --error \
                rgeos 

RUN install2.r --error \
                spatialEco

RUN echo "local(options(shiny.port = as.numeric(Sys.getenv('PORT')), shiny.host = '0.0.0.0'))" > /usr/lib/R/etc/Rprofile.site

RUN addgroup --system app \
    && adduser --system --ingroup app app

WORKDIR /home/app

COPY app .

RUN chown app:app -R /home/app

USER app

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/home/app')"]


