# Install and load necessary libraries
install.packages(c("httr", "jsonlite", "curl"))
library(httr)
library(jsonlite)
library(curl)

# Set Kaggle API credentials
kaggle_username <- "qbs980818"
kaggle_key <- "c62c53db47003d38266d7bc3fd62af89"

# Base URL and endpoint for downloading dataset
base_url <- "https://www.kaggle.com/api/v1/datasets/download/"
endpoint <- paste0("mexwell/steamgames")  # The dataset you want

# Construct the full URL
url <- paste0(base_url, endpoint)

# Set the headers with Kaggle credentials
headers <- c(
  `Content-Type` = "application/json",
  `User-Agent` = "R"
)

# Authenticate and download the dataset
response <- GET(
  url,
  authenticate(kaggle_username, kaggle_key),
  add_headers(.headers=headers)
)

# Save the response to a file
writeBin(content(response, "raw"), "steamgames.zip")

# If you want to unzip the dataset
unzip("steamgames.zip", exdir = "steamgames_data")
