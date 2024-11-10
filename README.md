# Contiguous US Riverine Sulfate Flux Prediction
Code used for data downloading, processing and machine learning prediction.

For now, the only avilable script is for data downloading and processing for sulfate concentration. The discharge downloading and processing script along with watershed delineation are being developed. Stay tuned.

The structure of the "Sulfate_data_download_process.Rmd" follows largely two parts, as self-explained, data downloading from Water Quality Portal (WQP) and sulfate concentration data processing. Basically, the sulfate concentration data are constrained to river. It also includes actions of removing NA, detection-limited results, and converting to mol/L, and removing outliers. 
