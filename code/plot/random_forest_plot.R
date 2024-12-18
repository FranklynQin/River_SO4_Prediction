
## Hyper parameter evaluation: Heat map show the optimal hyper parameter plot
tuning_data <- ml_tune$opt.path$env$path
colnames(tuning_data) <- c("num.trees", "min.node.size", "mtry", "MSE", "oob_error", "RMSE")
tuning_data_heatmap <- tuning_data
unique_min_node_sizes <- sort(unique(as.numeric(tuning_data_heatmap$min.node.size)))
tuning_data_heatmap$`Group Min.Node.Size` <- tuning_data_heatmap$min.node.size

## Sort 'Group Min.Node.Size' variable
tuning_data_heatmap$`Group Min.Node.Size` <- fct_inorder(factor(tuning_data_heatmap$`Group Min.Node.Size`))
tuning_ggplot <- ggplot(tuning_data_heatmap, aes(x = num.trees, y = as.numeric(mtry), fill = MSE)) +
  geom_tile() +
  scale_fill_viridis(option = "viridis", 
                     begin = 0, 
                     end = 1, 
                     direction = 1,
                     name = "MSE") +
  labs(title = "Hyperparameter Tuning Visualization",
       x = "num.trees",
       y = "mtry",
       fill = "MSE") +
  theme_bw() +
  theme(
    strip.text = element_text(size = 12),
    strip.background = element_blank(),
    plot.title = element_text(size = 24, face = "bold", hjust = 0.5),
    axis.title.x = element_text(size = 18, face = "bold"),
    axis.title.y = element_text(size = 18, face = "bold"),
    axis.text.x = element_text(size = 16),
    axis.text.y = element_text(size = 16),
    legend.title = element_text(size = 15, face = "bold"),
    legend.text = element_text(size = 13),
    legend.position = "right"
  ) +
  scale_x_discrete(breaks = seq(50, max(tuning_data_heatmap$num.trees), by = 10)) + # Set x-axis breaks
  scale_y_discrete(breaks = seq(0, 18, by = 3)) + # Set y-axis breaks
  facet_wrap(~ `Group Min.Node.Size`, ncol = 3, labeller = label_both)

print(tuning_ggplot)
ggsave(tuning_ggplot, filename = "output/PDF_Picture/Heatmap Hyper Parameter.pdf",
       width = 35, height = 30, units = "cm", dpi = 600)


## RF model evaluation plot
dt_cv_scenario <- dt_cv_total
axis_real_par_name <- bquote("Calculated Sulfate flux (mg/km2/month)")
axis_pred_par_name <- bquote("Predicted Sulfate flux (mg/km2/month)")
plot_r2_tao_func(dt_pred_real = dt_cv_scenario,
                 out_path = file.path("output/PDF_Picture/Sulfate R2.pdf"), 
                 width = 5, 
                 height = 5)
plot_residual_func(dt_pred_real = dt_cv_scenario,
                   out_path = file.path("output/PDF_Picture/Sulfate residual.pdf"),
                   width = 5, 
                   height = 5)
## Conditional permutation importance (CPI) plot
dt_imp$features <- c( "elevation_m",
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
                      "Rock_water",
                      "Temperature",
                      "Precipitation",
                      "PET",
                      "Runoff",
                      "Soil_moisture_0_10cm",
                      "Soil_moisture_10_30cm",
                      "Soil_moisture")
plot_imp_func(dt_imp = dt_imp,
              out_path =  file.path("output/PDF_Picture/Sulfate CPI ranking.pdf"),
              width = 40,
              height = 20)