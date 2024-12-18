# Liyang Qin
# This includes discharge data processing, flux calculation, flux truncation and histogram plot
library(dataRetrieval)
library(leaflet)
library(httr)
library(data.table)
library(tidyr)
library(rstudioapi)
library(stringr)
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


## Setting working and file saving directory

current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path))

# load sulfate

agu.so4 <- read.csv("sulfate_daily_averaged.csv")
agu.so4$site_no <- as.character(agu.so4$site_no)

agu.so4 <- as.data.table(agu.so4)

agu.so4[, `:=`(Year = year(Sampling_Date), Month = month(Sampling_Date))]

agu.so4 <- agu.so4[Data_Provider == "NWIS"]
# load discharge
agu.discharge <- combined_data
  

setnames(agu.discharge, "Date", "Sampling_Date")



agu.discharge$Sampling_Date <- as.character(agu.discharge$Sampling_Date)

# agu.discharge[, site_no := paste0("USGS-", site_no)]
agu.discharge$site_no <- sub("USGS-", "", agu.discharge$site_no)
agu.discharge$site_no <- str_pad(agu.discharge$site_no, width = 8, side = "left", pad = "0")
agu.discharge[, site_no := paste0("USGS-", site_no)]
agu.discharge$site_no <- as.character(agu.discharge$site_no)
agu.discharge[, `:=`(Year = year(Sampling_Date), Month = month(Sampling_Date))]

agu.discharge.matched <- agu.discharge %>%
  semi_join(agu.so4, by = c("site_no", "Sampling_Date"))

agu.discharge.matched <- as.data.table(agu.discharge.matched)
# setnames(agu.discharge.matched, "X_00060_00003", "Discharge")

# set up flux calculation
agu.day.flux <- inner_join(agu.so4, agu.discharge.matched, by = c("site_no", "Sampling_Date"))

agu.day.flux <- as.data.table(agu.day.flux)

conversion.factor <- 28.32 * 3600 * 24 * 30 # from ft^3/s to L/month (just to convert the unit not actually monthly)

# Calculate Load
agu.day.flux[, Load := Discharge * Concentration * conversion.factor]

# read in the watershed area data
watershed.area.agu <- fread("property_after_cluster_raw.csv")

watershed.area.agu <-as.data.table(watershed.area.agu) 

watershed.area.agu <- watershed.area.agu[, .(site_no, Area)]


# merge the watershed area data with the flux data

agu.day.flux <- inner_join(agu.day.flux, watershed.area.agu, by = "site_no")

# Calculate Flux
agu.day.flux <- agu.day.flux[, Flux := Load/Area]

agu.day.flux$Flux_unit <- "mg/km2/month"


## Step 14: Aggregate flux to long-term monthly average


year.monthly.flux.agu <- copy(agu.day.flux)

# Extract year and month from Sampling_Date
year.monthly.flux.agu[, `:=`(Year = year(Sampling_Date), Month = month(Sampling_Date))]


year.monthly.flux.agu <- year.monthly.flux.agu %>%
  select(-Year.x)

year.monthly.flux.agu <- year.monthly.flux.agu %>%
  select(-Year.y)

year.monthly.flux.agu <- year.monthly.flux.agu %>%
  select(-Month.y)

year.monthly.flux.agu <- year.monthly.flux.agu %>%
  select(-Month.x)

# aggregate by site_no, year and month to calculate monthly average in a given year

year.monthly.flux.agu <- year.monthly.flux.agu[, .(year_monthly_avg_sulfate = mean(Flux, na.rm = TRUE)), 
                                               by = .(site_no, Year, Month)]

# Aggregate by site_no, month to calculate long-term monthly average

longterm.monthly.flux.agu <- year.monthly.flux.agu[, .(longterm_monthly_avg_sulfate = mean(year_monthly_avg_sulfate, na.rm = TRUE)), 
                                                   by = .(site_no, Month)]


setnames(longterm.monthly.flux.agu, old = "longterm_monthly_avg_sulfate", new = "Sulfate_flux_mg_per_km2_per_month")
setnames(longterm.monthly.flux.agu, old = "Month", new = "month")

wide_format_with_month <- fread("wide_format_with_month.csv")

wide_format_with_month.daily.agu <- wide_format_with_month %>%
  semi_join(longterm.monthly.flux.agu, by = c("site_no", "month"))

# merge the watershed area data with the flux data

new.dailyflux.agu.wide_format <- merge(wide_format_with_month.daily.agu, longterm.monthly.flux.agu, by = c("site_no","month"), all.x = TRUE)

# save as csv
#write.csv(new.dailyflux.agu.wide_format, "agu_flux_training_final_selection_new.csv", row.names = FALSE)

agu_flux_training_final <- copy(new.dailyflux.agu.wide_format)

# histogram

ggplot(new.dailyflux.agu.wide_format, aes(x = Sulfate_flux_mg_per_km2_per_month)) +
  geom_histogram(binwidth = 800000) +
  xlim(0, 2.5e10) +
  labs(
    x = "Flux (mg/km²/month)",
    y = "Frequency",
    title = "Histogram of Sulfate Flux"
  )

up_threshold <- quantile(agu_flux_training_final$Sulfate_flux_mg_per_km2_per_month, 0.95, na.rm = TRUE)
low_threshold <- quantile(agu_flux_training_final$Sulfate_flux_mg_per_km2_per_month, 0.05, na.rm = TRUE)

agu_flux_training_final.outliers.rm <- agu_flux_training_final[Sulfate_flux_mg_per_km2_per_month <= up_threshold & Sulfate_flux_mg_per_km2_per_month >= low_threshold, ]

agu_flux_training_final.outliers.rm <- na.omit(agu_flux_training_final.outliers.rm)
agu_flux_training_final.outliers.rm <- agu_flux_training_final.outliers.rm[!is.infinite(Sulfate_flux_mg_per_km2_per_month),]

write.csv(agu_flux_training_final.outliers.rm, "agu_flux_training_final_outliers_rm.csv")

# histogram
newhisto <- ggplot(agu_flux_training_final.outliers.rm, aes(x = Sulfate_flux_mg_per_km2_per_month)) +
  geom_histogram(binwidth = 800000) +
  xlim(0, 2.5e10) +
  labs(
    x = "Flux (mg/km²/month)",
    y = "Frequency",
    title = "Histogram of Sulfate Flux"
  )

ggsave(
  filename = "sulfate_flux_histogram.pdf", 
  plot = newhisto, 
  width = 11, 
  height = 8.5, 
  dpi = 600, 
  units = "in"
)

