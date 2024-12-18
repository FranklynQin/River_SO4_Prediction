#USGS site map drawing

#Liyang Qin


same_latlong <- fread("/input/agu_flux_training_final_outliers_rm.csv")
setnames(same_latlong, old = "east", new = "Longitude")
setnames(same_latlong, old = "north", new = "Latitude")

same_latlong <- same_latlong %>% select(site_no, Longitude, Latitude)

if (!require(maps)) install.packages("maps")

# load library
library(ggplot2)
library(maps)

map.data <- same_latlong

map.data <- as.data.table(map.data)

map.data[,site_no := NULL]

# continental US map drawing
us_map <- map_data("state")

# filter out Hawaii and Alaska
us_map <- us_map[us_map$region != "alaska" & us_map$region != "hawaii", ]

plot <- ggplot() +
  geom_polygon(data = us_map, aes(x = long, y = lat, group = group), fill = "white", color = "black") +
  geom_point(data = map.data, aes(x = Longitude, y = Latitude), color = "blue", size = 0.1) + 
  coord_fixed(1.3) +
  labs(x = "Longitude", y = "Latitude") +
  theme_minimal()

print(plot)

ggsave("USGS_training_site_locations_map.png", plot = plot, width = 10, height = 7, dpi = 600)
