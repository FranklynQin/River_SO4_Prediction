# Sulfate Analysis Workflow

This repository contains scripts for analyzing sulfate concentrations and discharge data across watersheds. The workflow processes raw data from the Water Quality Portal and performs random forest analysis.

## Workflow Overview

1. `so4_full_workflow.R`
   - Initial data processing and setup
   - Prepares foundation for subsequent analysis

2. `discharge_download.R`
   - Downloads discharge data from Water Quality Portal
   - API endpoint: https://www.waterqualitydata.us/

3. `discharge_combine_rdata.R`
   - Combines downloaded discharge data into unified R data format
   - Creates consolidated dataset for analysis

4. `wide_to_long.R`
   - Converts watershed attributes from wide to long format
   - Prepares data structure for random forest analysis

5. `discharge_and_flux_process.R`
   - Processes discharge data
   - Calculates flux measurements

6. Random Forest Analysis
   Required scripts:
   - `random_forest.R`
   - `Functions_axis_fixed.R`
   
   Setup requirements:
   - Create input and output folders
   - Configure file paths
   - Load necessary dependencies

7. Plotting Scripts
   Located in the `plot` folder:
   - Various visualization scripts
   - Note: `prediction_draw.R` and `training_site_map.R` are separate from `random_forest.R`

## Data Sources

### Included Data
- Raw data files in `raw_data` folder
- Processed data in `analysis_data` folder

### External Data Requirements
Users need to download:
1. Sulfate concentration data
2. Discharge data

Both can be obtained from the Water Quality Portal (https://www.waterqualitydata.us/)

## Setup Instructions

1. Clone this repository
2. Review and adjust file paths in all scripts to match your environment
3. Create required input/output folders for random forest analysis
4. Download external data requirements
5. Follow the workflow sequence listed above

## Important Notes

- File paths in scripts need to be modified for your environment
- Output/input file names may need adjustment
- Variable names might require modification based on your specific analysis needs

## Customization Required

You will need to modify:
- File paths
- Input/output file names
- Variable names
- Folder structures

## Troubleshooting

If you encounter issues:
1. Verify all file paths are correct for your environment
2. Ensure all required data files are present
3. Check folder structures match script expectations
4. Verify variable names match your data structure

## Contact

For questions or issues, please open an issue in this repository.
