library(dplyr)

# read wide format data and flux data
feature.data <- read.csv("wide_format_with_month.csv") 
flux.data <- read.csv("longterm_monthly_flux.csv")


setnames(feature.data, "month", "Month")

# Filter out the records that match the flux dataset
filtered_data <- feature.data %>%
  inner_join(flux.data, by = c("site_no", "Month"))

data_cleaned <- copy(filtered_data)

setnames(data_cleaned, "east", "dec_long_va")
setnames(data_cleaned, "north", "dec_lat_va")
setnames(data_cleaned, "Elevation", "elevation_m")
setnames(data_cleaned, "longterm_monthly_avg_sulfate", "Sulfate_flux_mol_per_km2_per_month")

data_cleaned <- data_cleaned %>%
  relocate(Month, .after = site_no)

data_cleaned <- data_cleaned %>%
  relocate(Sulfate_flux_mol_per_km2_per_month, .after = dec_lat_va)

data_cleaned <- data_cleaned %>%
  mutate(site_no = gsub("^USGS-", "", site_no))

# Remove any NA in the data

data_cleaned <- data_cleaned %>% na.omit()

# Save a coordinate and unique site no only file for mapping purpose
map_data <- data_cleaned %>%
  select(site_no, dec_long_va, dec_lat_va) %>%
  distinct()

# Save filtered data
write.csv(data_cleaned, "sulfate_final_selection_data.csv", row.names = FALSE)

# Save map data
write.csv(map_data, "sulfate_training_site_map_data.csv", row.names = FALSE)

# reminder of process finished
cat("Data combining and finished\n")
