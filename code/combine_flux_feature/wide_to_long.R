library(dplyr)
library(tidyr)

# deifne columns needs to be preserved
keep_columns <- c(
  # "site_no",
  # "east",
  # "north",
  "zone",
  "Area",
  "Elevation",
  "Slope",
  "Erosion_rate",
  "NPP",
  "GPP",
  "Population",
  "Human_footprint",
  "Soil_pH",
  "Soil_org",
  "Soil_cec",
  "Landcover_needleleaf",
  "Landcover_evergreen_broadleaf",
  "Landcover_deciduous_broadleaf",
  "Landcover_mixed_trees",
  "Landcover_shrubs",
  "Landcover_herbaceous_vegetation",
  "Landcover_cultivated_vegetation",
  "Landcover_flooded_vegetation",
  "Landcover_urban",
  "Landcover_snow_ice",
  "Landcover_barren",
  "Landcover_water",
  "Rock_evaporites",
  "Rock_ice_glaciers",
  "Rock_metamorphics",
  "Rock_nodata",
  "Rock_plutonic_acid",
  "Rock_plutonic_basic",
  "Rock_plutonic_intermediate",
  "Rock_sediment_pyroclastic",
  "Rock_sediment_carbonate",
  "Rock_sediment_mixed",
  "Rock_sediment_siliciclastic",
  "Rock_sediment_unconsolidated",
  "Rock_volcanic_acid",
  "Rock_volcanic_basic",
  "Rock_volcanic_intermediate",
  "Rock_water"
)
# Temp, soil moisture, runoff and PET and precipitation data are not needed to be converted

# data <- read.csv("property_after_cluster_raw.csv") 
data <- read.csv("property_after_cluster_raw_NA.csv") 

# convert to long format
system.time(long_data <- data %>%
  pivot_longer(
    cols = -all_of(keep_columns), # Keep columns that are not needed to be converted
    names_to = c("variable", "month"), # Split column names into "variable" and "month".
    names_pattern = "^(.*)_(\\d+)$", # Matching column names using regular expressions
    values_to = "value"
  ) %>%
  mutate(month = as.integer(month))) # make sure the month type are integer

long_data <- long_data %>%
  relocate(month, .after = zone)

# convert back to wide format
wide_data <- long_data %>%
  pivot_wider(
    names_from = "variable", # convert the variable name to column names
    values_from = "value"    # fill out the value
  )


write.csv(wide_data, "wide_format_with_month_Hydrosheds.csv", row.names = FALSE)



