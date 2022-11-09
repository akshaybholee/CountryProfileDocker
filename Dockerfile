# Example shiny app docker file
# https://blog.sellorm.com/2021/04/25/shiny-app-in-docker/

# get shiny serveR and a version of R from the rocker project
FROM rocker/shiny:4.0.5

# system libraries
# Try to only install system libraries you actually need
# Package Manager is a good resource to help discover system deps
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libgdal-dev
  

# install R packages required 
# Change the packages list to suit your needs
RUN R -e 'install.packages(c(\
              "shiny", \
              "shinydashboard", \
              "shinyjs",\
                "formattable",\
                "dplyr",\
                "stringr",\
                "sqldf",\
                "echarts4r",\
                "chorddiag",\
                "scales",\
                "highcharter",\
                "DT",\
                "plyr",\
                "leaflet",\
                "rworldmap",\
                "leaflet.extras",\
                "spatialEco",\
                "leaflegend",\
                "odbc",\
                "pool",\
                "shinydashboardPlus",\
                "waiter",\
                "feather"\
            ), \
            repos="https://packagemanager.rstudio.com/cran/__linux__/focal/2021-04-23"\
          )'


# copy the app directory into the image
COPY ./shiny-app/* /srv/shiny-server/

# run app
CMD ["/usr/bin/shiny-server"]
