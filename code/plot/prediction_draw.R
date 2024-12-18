# Loading librart
library(sf)
library(rnaturalearth)
library(ggplot2)

# read shp file
shapefile <- st_read("ws_na_07.shp")

# extract coordinate
coords <- st_coordinates(shapefile)
pred_out <- read.csv("predictions_output_new.csv")


# add all monthly sulfate flux to annual total

dt_predictions <- pred_out %>%
  group_by(original_data.zone) %>%
  summarise(predicted_sulfate_flux = sum(predicted_sulfate_flux))



# use sf function
points <- st_point_on_surface(shapefile$geometry)
shapefile_df$longitude <- st_coordinates(points)[, 1]
shapefile_df$latitude <- st_coordinates(points)[, 2]



# Get boundary data of US
us_boundary <- ne_countries(country = "United States of America", returnclass = "sf") %>%
  st_transform(st_crs(shapefile))  # make sure coordinate system are the same.

# Trim data
shapefile_fixed <- st_make_valid(shapefile)
us_boundary_fixed <- st_make_valid(us_boundary)
shapefile_us <- st_intersection(shapefile_fixed, us_boundary_fixed)

setnames(shapefile_us,"ws_num", "zone")
setnames(dt_predictions,"original_data.zone", "zone")
shapefile_with_flux <- shapefile_us %>%
  left_join(dt_predictions, by = "zone")




prediction_plot <- ggplot() +
  geom_sf(data = shapefile_with_flux, aes(fill = predicted_sulfate_flux)) +
  coord_sf(xlim = c(-125, -66.93457), ylim = c(24.396308, 49.384358)) +
  scale_fill_viridis_c(
    name = "Annual Total Sulfate Flux\n (mg/km²/month)",
    # trans = "log10", #depends on which scale you want to use
    option = "turbo",
    n.breaks = 10,
    labels = scales::scientific
  ) +
  theme(
    plot.margin = margin(1, 1, 1, 1.5, "in"),
    legend.position = "right",          # put the legend on the right
    legend.justification = c(0, 0),     
    legend.margin = margin(0, 0, 0, 0), 
    legend.box.margin = margin(0, 0, 10, 10)  
  ) +
  labs(x = "Longtitude",
       y = "Latitude") +
  theme_minimal()

ggsave(
  "~/Code/R/WQP_data_workflow/sulfate_flux_map_agu_print_new.pdf", 
  plot = prediction_plot, 
  width = 10, 
  height = 8.5, 
  dpi = 600, 
  units = "in"
)
