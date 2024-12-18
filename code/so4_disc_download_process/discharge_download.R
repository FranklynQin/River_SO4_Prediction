
library(dataRetrieval)
library(ggplot2)
library(dplyr)
library(leaflet)
library(httr)
library(data.table)
library(reshape2)
library(tidyr)
library(rstudioapi)
library(httr)
library(dataRetrieval)
library(stringr)
library(data.table)
library(rstudioapi)
library(PeriodicTable)
library(reshape2)
library(leaflet)
library(DT)
library(usmap)
library(dplyr)
library(lubridate)
library(tidyr)
library(scales)
library(ggplot2)


current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path))
# Need to load httr to get the progress for dataretrieval
set_config(verbose())
set_config(progress())


# sites <- read.csv("common_site_for_discharge_download.csv")
# 
# sites <- as.data.table(sites)
# 
# # setnames(sites, "V1", "site_no")
# 
# sites$site_no <- sub("USGS-", "", sites$site_no)

site <- read.csv("sites_partition_2.csv")
site <- as.data.table(site)
site[, site_no := str_pad(site_no, width = 8, side = "left", pad = "0")]

#------#

# Parameter code for discharge
pcode <- "00060"

# Function to split a data.table into smaller chunks
split_data_table <- function(dt, chunk_size) {
  split(dt, ceiling(seq_len(nrow(dt)) / chunk_size))
}

# Assume `sites` is your data.table containing the `site_no` column
# Ensure `sites` is a data.table object
if (!is.data.table(site)) {
  sites <- as.data.table(site)
}

# Split the sites into chunks of size 1000 (adjust the size as needed)
chunks <- split_data_table(site, chunk_size = 1000)

# Define a log file to track progress
progress_log <- "download_progress.log"

# If the log file doesn't exist, create it and initialize with 0
if (!file.exists(progress_log)) {
  writeLines("0", progress_log)  # Write initial progress as 0
}

# Read the completed chunk index from the log file
completed_chunks <- as.numeric(readLines(progress_log))

# Iterate over each chunk
for (i in seq_along(chunks)) {
  # Skip already completed chunks
  if (i <= completed_chunks) {
    next
  }
  
  message(paste("Processing chunk", i, "of", length(chunks)))
  
  # Extract the current chunk
  current_chunk <- chunks[[i]]
  
  # Initialize a list to store results for this chunk
  chunk_data_list <- list()
  
  # Iterate over each site in the current chunk
  for (j in seq_len(nrow(current_chunk))) {
    site <- current_chunk$site_no[j]
    message(paste("Downloading data for site:", site, "in chunk:", i))
    
    # Try downloading the data for the current site
    try({
      discharge_data <- readNWISdv(
        siteNumbers = site,
        parameterCd = pcode
      )
      
      # Convert to data.table and add to the chunk list
      discharge_data <- as.data.table(discharge_data)
      chunk_data_list[[j]] <- discharge_data
    }, silent = TRUE)  # Silent ensures the loop continues even if a site fails
  }
  
  # Combine all data for the current chunk
  chunk_data <- rbindlist(chunk_data_list, fill = TRUE)
  
  # Save the current chunk data to an RData file
  save_file_name <- paste0("discharge_chunk_", i, ".RData")
  save(chunk_data, file = save_file_name)
  
  # Update the progress log file
  writeLines(as.character(i), progress_log)
  
  # Print success message
  message(paste("Chunk", i, "data saved as", save_file_name))
}

