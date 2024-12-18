# load package
library(dataRetrieval)
library(ggplot2)
library(dplyr)
library(leaflet)
library(httr)
library(data.table)
library(reshape2)
library(sf)
library(dplyr)
library(spData)
library(tmap)
library(corrplot)
library(rstudioapi)
library(foreach)
library(mlr)
library(tictoc)
library(MLmetrics)
library(parallelMap)
library(parallel)
library(doParallel)
library(kernlab)
library(pdp)
library(doParallel)
library(glmnet)
library(foreach)
library(pROC)
library(ranger)
library(fastshap)
library(SHAPforxgboost)
library(GGally)
library(plotly)
library(scales)
library(viridis)
library(forcats)
library(stringr)
library(grid)
library(sp)

##===========================================================================##
# Loading Functions
##===========================================================================##
source("Functions_axis_fixed.R")

##===========================================================================##
# Part II Machine learning
##===========================================================================##
##---------------------------------------------------------------------------##
## 1. Load model and RF model development
##---------------------------------------------------------------------------##
# 1.Load data 
color_sequence <- c("#001219", "#0a9396", "#94d2bd", "#e9d8a6", "#ee9b00", "#ca6702", "#9b2226")
so4_selection <- fread("input/Sulfate_selection_data.csv")
hydroshed <- fread("input/Hydrosheds.csv")
#so4_selection$site_no <- formatC(so4_selection$site_no, width = 15, format = "d", flag = "0")
# Sulfate_with_features$site_no <- formatC(Sulfate_with_features$site_no, width = 8,
#                                          format = "d", flag = "0")
setnames(hydroshed, "Elevation", "elevation_m")

# 2. RF model development
## (1) Load data
dt_ml <- so4_selection[, c(
  "Sulfate_flux_mg_per_km2_per_month",
  "elevation_m",
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
  "Soil_moisture"
)]

dim(dt_ml)

## (2) Develop a RF model and fine-tune hyper parameters
ml <- makeLearner("regr.ranger")
getParamSet(ml)
ml$par.vals
ml$par.set

ntree_name <- "num.trees"
nodesize_name <- "min.node.size"
mtry_name <- "mtry"

ml_param <- makeParamSet(
  makeDiscreteParam(ntree_name, values = seq(100, 1500, by = 300)), 
  makeDiscreteParam(nodesize_name, values = seq(1, 15, by = 3)),
  makeDiscreteParam(mtry_name, values = seq(1, 18, by = 4)))
trainTask <- makeRegrTask(data = as.data.frame(dt_ml),
                          target = "Sulfate_flux_mg_per_km2_per_month")
getDefaultMeasure(trainTask)

run_flag <- "cluster"
if (run_flag == "cluster") {
  tunecontrol <- makeTuneControlGrid()
} else {
  tunecontrol <- makeTuneControlGrid()
}

k_fold <- 10
set_cv <- makeResampleDesc(method = "CV", iter = k_fold)

oob_error <- function(task, model, pred, feats, extra.args) {
  oob_error <- model$learner.model$prediction.error
  return(oob_error)
}
measure_oob <- makeMeasure(
  id = "oob_error",
  name = "OOB Error",
  properties = c("regr", "req.pred", "req.model", "req.task"),
  minimize = TRUE,
  fun = oob_error
)

#tic("ml training starts...")
parallelStartSocket(cpus = detectCores())
ml_tune <- tuneParams(learner = ml,
                      task = trainTask,
                      resampling = set_cv,
                      par.set = ml_param,
                      control = tunecontrol,
                      measures = list(mse, measure_oob, rmse))
parallelStop()
#toc("lm training complets.")
#tic.clear()

# 3. Use fine-tuned hyper parameter to develop RF model
ml_tune
ml_tune$x
ml_best <- setHyperPars(ml, par.vals = ml_tune$x)
# ml_best <- setHyperPars(ml, par.vals = list(num.trees = 100, min.node.size = 1, mtry = 12))
saveRDS(ml_best, file.path("output/Sulfate_best_model.rds"))
ml_best <- readRDS(file.path("output/Sulfate_best_model.rds"))
##---------------------------
# 4. Hyper parameter evaluation: Heat map show the optimal hyper parameter
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
#-----------------------------------------------------------
# 5.1 Cross-validation
fold_index <- cut(sample(1:nrow(dt_ml)), breaks = 10, labels = FALSE)
tic("cross validation starts")
(no_cores <- detectCores())
cl <- makeCluster(no_cores)
registerDoParallel(cl)

l_pred_cv_total <- foreach (i=1:k_fold, .packages = c("mlr", "data.table")) %dopar% 
  {
    dt_cv_train <- dt_ml[fold_index != i, ]
    dt_cv_test <- dt_ml[fold_index == i, ] # 90% data for train, 10% data for test ，iterate 10 times
    trainTask_cv <- makeRegrTask(data = as.data.frame(dt_cv_train),
                                 target = "Sulfate_flux_mg_per_km2_per_month")
    ml_cv_model <- mlr::train(ml_best, trainTask_cv)
    ml_pred_cv <- predict(ml_cv_model,
                          newdata = as.data.frame(dt_cv_test))
    dt_pred_cv <- as.data.table(ml_pred_cv)
    return(list(data.table(fold=i, truth=dt_pred_cv[, truth], response=dt_pred_cv[, response])))
  }
stopCluster(cl)
toc()
dt_cv_total <- rbindlist(lapply(l_pred_cv_total, function(x){x[[1]]}))

# 5.2 Prediction
# 1. train final model
trainTask <- makeRegrTask(data = as.data.frame(dt_ml),
                          target = "Sulfate_flux_mg_per_km2_per_month")
final_model <- mlr::train(ml_best, trainTask)

# 2. prepare HydroSHEDS watershed attributes data
new_data <- copy(hydroshed)

# 3. Predict sulfate flux
predictions <- predict(final_model, newdata = as.data.frame(new_data))

# 4. Convert prediction to data.table
dt_predictions <- data.table(
  original_data = new_data,
  predicted_sulfate_flux = predictions$data$response
)

# 5. save results
fwrite(dt_predictions, "predictions_output.csv")
#-------------------------------------------------
# 6. RF model evaluation
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

# 7. Conditional permutation importance (CPI)
ml_best <- readRDS(file.path("output/Sulfate_best_model.rds"))
# ml_best <- setHyperPars(ml, par.vals = list(num.trees = 100, min.node.size = 1, mtry = 12))
trainTask <- makeRegrTask(data = as.data.frame(dt_ml),
                          target = "Sulfate_flux_mg_per_km2_per_month")
ml_train_total_model <- mlr::train(ml_best, trainTask)
ml_pred_whole <- predict(ml_train_total_model,
                         newdata = as.data.frame(dt_ml))
dt_pred_whole <- as.data.table(ml_pred_whole)

tic("feature importance...")
dt_imp <- imp_manual_func(dt_ml = dt_ml,
                          target_name = "Sulfate_flux_mg_per_km2_per_month",
                          model_pred_total = ml_pred_whole,
                          train_total_model = ml_train_total_model,
                          n_iter = 5)
toc()

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
