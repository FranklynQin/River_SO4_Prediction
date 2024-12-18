
library(tictoc)

current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path))

# Execute "wide_to_long.R" script to transform the watershed attributes data from wide to long format
# This can make each site's month data to be listed in one row
tic()
source("wide_to_long.R")

# Execute "combine_flux_feature_v2.R" script to combine the watershed attributes data with the flux data

source("combine_flux_feature_v2.R")
toc()
cat("Data preparation is done!")