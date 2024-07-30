# start from the rstudio/plumber image
FROM rocker/r-ver:4.4.1

# install the linux libraries needed for plumber
RUN apt-get update -qq && apt-get install -y  libssl-dev  libcurl4-gnutls-dev  libpng-dev
    
    
RUN R -e "install.packages('plumber')"
RUN R -e "install.packages('caret')"
RUN R -e "install.packages('randomForest')"
RUN R -e "install.packages('ranger')"

# copy everything from the current directory into the container
COPY myAPI.R myAPI.R
COPY diabetes_binary_health_indicators_BRFSS2015.csv diabetes_binary_health_indicators_BRFSS2015.csv
COPY random_forest_model.rds random_forest_model.rds

# open port to traffic
EXPOSE 8000

# when the container starts, start the myAPI.R script
ENTRYPOINT ["R", "-e", \
    "pr <- plumber::plumb('myAPI.R'); pr$run(host='0.0.0.0', port=8000)"]
    