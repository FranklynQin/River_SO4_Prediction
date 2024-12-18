
# 1.Calculation Conditional Permutation Importance (CPI) Value
imp_manual_func <- function(dt_ml, target_name, model_pred_total, train_total_model, n_iter){
  
  tic("manual permutation starts")
  
  n_iter <- n_iter
  
  n_row <- nrow(dt_ml)
  
  n_col <- ncol(dt_ml) - 1
  
  # get the names of dependent variables
  par_names <- str_subset(names(dt_ml), target_name, negate = TRUE)
  
  mse_good <- MSE(y_pred = model_pred_total$data$response,
                  y_true = model_pred_total$data$truth)
  
  mse_all <- matrix(data = NA,
                    nrow = n_iter,
                    ncol = n_col)
  
  for (i in 1:n_iter){
    for (j in 1:n_col){
      
      par_name <- par_names[j]
      
      dt_ml_new <- copy(dt_ml)
      
      dt_ml_new[[par_name]] <- sample(dt_ml_new[[par_name]])
      
      pred_pert <- predict(train_total_model,
                           newdata = as.data.frame(dt_ml_new))
      
      scoring_pert <- MSE(y_pred = pred_pert$data$response,
                          y_true = model_pred_total$data$truth)
      
      mse_all[i, j] <- scoring_pert
      
      cat("manual permu for column ", j, "finished..\n")
    }
    
    cat("\nmanual permu for iteration", i, "finished..\n")
  }
  
  
  mse_mean = apply((mse_all - mse_good)/mse_good, 2, mean)
  mse_std = apply((mse_all - mse_good)/mse_good, 2, sd)
  
  dt_mse <- data.table(features = par_names,
                       importance = mse_mean,
                       sd = mse_std)
  
  toc()
  
  return(dt_mse)
  
}
# 2. Plot R2 and MSE
plot_r2_tao_func <- function(dt_pred_real, out_path, width, height){
  
  # get R2
  anot_test1 <- bquote(R^2==~.(format(R2_Score(y_pred = dt_pred_real$response,
                                               y_true = dt_pred_real$truth), digits=2)))
  # get MSE
  anot_test2 <- bquote(MSE==~.(format(MSE(y_pred = dt_pred_real$response,
                                          y_true = dt_pred_real$truth), dig = 3)))
  
  anot_test_glob1 <- grobTree(
    textGrob(
      anot_test1,
      x=0.05,
      y=0.95,
      just = c('left', 'top'),
      gp=gpar(fontsize=10)
    )
  )
  anot_test_glob2 <- grobTree(
    textGrob(
      anot_test2,
      x=0.05,
      y=0.89,
      just = c('left', 'top'),
      gp=gpar(fontsize=10)
    )
  )
  # plot
  axis_range <- range(c(dt_pred_real$truth, dt_pred_real$response), na.rm = TRUE)
  
  gp <- ggplot(dt_pred_real) +
    geom_point(aes(x = truth, y = response), shape = 21, fill = color_sequence[1], color = "white", alpha = 0.7, size = 1.5, stroke = 0.05) +
    geom_abline(slope = 1, intercept = 0, color = color_sequence[length(color_sequence)], size = 0.3) +
    labs(x = axis_real_par_name,
         y = axis_pred_par_name) +
    scale_x_continuous(limits = axis_range, breaks = scales::pretty_breaks(n = 5), labels = scales::scientific_format() ) +
    scale_y_continuous(limits = axis_range, breaks = scales::pretty_breaks(n = 5), labels = scales::scientific_format() ) +
    annotation_custom(anot_test_glob1) +
    annotation_custom(anot_test_glob2) +
    coord_fixed(ratio = 1) +  # fix axis ratio
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.text = element_text(size = 12),
      axis.title = element_text(size = 13),
      plot.margin = unit(c(2, 4, 2, 4), "mm")
    )
  
  print(gp)
  
  ggsave(filename = out_path, width = width, height = height)
  
}
# 3. Plot CPI ranking 
# plot_imp_func <- function(dt_imp, out_path, width, height){
#   
#   gp <- ggplot(dt_imp, aes(x=reorder(features, importance), y=importance))+
#     geom_col(width = 0.8, fill="#d53e4f") +
#     coord_flip() +
#     labs(x = "",
#          y = "Relative features importance"
#     ) +
#     theme_bw() +
#     theme(
#       panel.grid.major = element_blank(),
#       panel.grid.minor = element_blank(),
#       axis.text = element_text(size=42),
#       axis.title = element_text(size=40)
#     )
#   
#   print(gp)
#   
#   ggsave(filename = out_path, width = width, height = height)
#   
# }
plot_imp_func <- function(dt_imp, out_path, width, height){
  
  gp <- ggplot(dt_imp, aes(x=reorder(features, importance), y=importance))+
    geom_col(width = 0.8, fill="#d53e4f") +
    coord_flip() +
    labs(x = "",
         y = "Relative features importance"
    ) +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.text = element_text(size=12),      # 调整文字大小为适合页面的尺寸
      axis.title = element_text(size=14),     # 调整标题大小为适合页面的尺寸
      axis.text.y = element_text(hjust=1),    # 确保y轴标签对齐
      plot.margin = margin(0.5, 0.5, 0.5, 0.5, "in")  # 添加适当的边距
    )
  
  print(gp)
  
  ggsave(filename = out_path, 
         width = 11,     # US Letter 宽度
         height = 8.5,     # US Letter 高度
         units = "in")    # 明确指定单位为英寸
  
}
# 4. Plot residual 
plot_residual_func <- function(dt_pred_real, out_path, width, height){
  
  dt_pred_real$residual <- dt_pred_real$response - dt_pred_real$truth
  gp <- ggplot(dt_pred_real) +
    geom_point(aes(x=response, y=residual), shape=21, fill=color_sequence[1], color="white", alpha=0.7, size=1.5, stroke=0.05) +
    geom_hline(yintercept = 0, color=color_sequence[length(color_sequence)], size=0.5) +
    labs(x = axis_pred_par_name,
         y = "Residual") +
    scale_x_continuous(breaks = scales::pretty_breaks(n = 5), expand = expansion(mult = c(0.2, 0.2))) +
    scale_y_continuous(breaks = scales::pretty_breaks(n = 6), expand = expansion(mult = c(0.2, 0.2))) +
    theme_bw() +
    theme(
      aspect.ratio = 1,
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.text = element_text(size=12),
      axis.title = element_text(size=13),
      plot.margin = unit(c(2, 4, 2, 4), "mm")
    )
  
  print(gp)
  
  ggsave(filename = out_path, width = width, height = height)
  
}
