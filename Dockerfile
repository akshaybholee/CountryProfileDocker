FROM rocker/r-base:latest

LABEL maintainer="IEC <IEC>"

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
    msodbcsql17\
    mssql-tools_17\
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
RUN Rscript -e "install.packages('spatialEco')"
RUN Rscript -e "install.packages('leaflegend')"
RUN Rscript -e "install.packages('httr')"
RUN Rscript -e "install.packages('DBI')"


RUN install.r shiny


RUN echo "local(options(shiny.port = as.numeric(Sys.getenv('PORT')), shiny.host = '0.0.0.0'))" > /usr/lib/R/etc/Rprofile.site

RUN addgroup --system app \
    && adduser --system --ingroup app app

WORKDIR /home/app

COPY app .

RUN chown app:app -R /home/app

USER app

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/home/app')"]
