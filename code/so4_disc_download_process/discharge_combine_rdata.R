#Liyang Qin
library(data.table)

# List all .RData files in the current directory (adjust the path if needed)
rdata_files <- list.files(pattern = "*.RData")

# Initialize an empty list to store loaded data
all_data <- list()

# Loop through each file and try to load its data
for (file in rdata_files) {
  message(paste("Processing", file))
  
  try({
    # Attempt to load the file
    load(file)
    
    # Check if the loaded variable exists and is a data.table
    if (exists("chunk_data") && is.data.table(chunk_data)) {
      all_data[[file]] <- chunk_data
    } else {
      warning(paste("File", file, "did not contain a valid data.table. Skipping."))
    }
  }, silent = TRUE)  # Skip the file if an error occurs
}

# Combine all successfully loaded data.tables
combined_data <- rbindlist(all_data, fill = TRUE)

# Save the combined data as a CSV file
write.csv(combined_data, "combined_discharge_data.csv", row.names = FALSE)

# Save as an RData file for future use
save(combined_data, file = "combined_discharge_data.RData")

# Print completion message
message("Combination completed. Combined data saved as CSV and RData.")

