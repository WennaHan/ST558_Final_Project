# Load the plumber package
library(plumber)

# Create a plumber router from the plumber.R file
r <- plumb("myAPI.R")

# Run the API on port 8000
r$run(port = 8000)