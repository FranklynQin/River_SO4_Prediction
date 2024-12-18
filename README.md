
# Predicting Riverine Sulfate Fluxes Across the United States Using Machine Learning
    
*Liyang Qin*
## Literature Review
  ### Sulfate in the Environment
Fresh water is a fundamental resource for human civilization, yet accessible fresh water only accounts for approximately one percent of the Earth's total freshwater supply (e.g., Shiklomanov, 1993; Schlesinger & Bernhardt, 2020). As an oxidized form of sulfur (S), sulfate is ubiquitous in the environment and is regarded as a key component in the global sulfur cycle (Zak et al., 2021). In most natural waters, sulfate (SO42-) plays a crucial role: it serves as a common soluble anion and constitutes a significant portion of the ionic charge (e.g., Miao et al., 2012; Wang & Zhang, 2019; Torres-Mart'nez et al., 2020; Zak et al., 2021). However, concentrations of SO42- in natural aquatic systems vary largely and are influenced mostly by the predominant catchment geology and hydrology (Kleeberg, 2014; Zak et al., 2021).

Sulfate in natural waters originates from both natural and anthropogenic sources. Natural processes facilitating sulfate mobilization include weathering of sulfur-bearing rocks, sulfate mineral dissolution, sulfide mineral oxidation, dissolution of evaporites, and volcanic eruptions (e.g., Torres-Mart'nez et al., 2020; Zak et al., 2021). However, anthropogenic activities have substantially altered global sulfate cycling (e.g., Hinckley et al., 2020) since the Industrial Revolution. Widespread burning of sulfur-rich fossil fuels (e.g., coal and petroleum), industrial processes have mobilized S from geological reserves, releasing sulfur dioxide and sulfate aerosols into the atmosphere (e.g., Stoddard et al., 1999; Driscoll et al., 2001; Miao et al., 2012; Zak et al., 2021, 2021). Furthermore, recent studies (e.g., Hinckley et al., 2020) indicate that agricultural practices, such as the application of sulfate fertilizers to crop fields, can also contribute to sulfur mobilization and potentially disrupt the sulfur cycle.

Both naturally occurring and anthropogenic sources of sulfate can have adverse effects on human health (e.g., Hinckley et al., 2020). High sulfate concentrations in groundwater are a widespread concern, with drinking water quality being a key focus of numerous studies. For instance, a survey of 8,236 water wells across 244 counties in Texas examined median sulfate concentrations in groundwater, revealing county medians ranging from less than 1.5 mg/L to 1,953 mg/L (Hudak, 2000). The study found that 34 counties had median sulfate concentrations exceeding the U.S. Environmental Protection Agency (EPA)'s Secondary Maximum Contaminant Level (SMCL) of 250 mg/L (Hudak, 2000). Additionally, an analysis of 1,890 groundwater monitoring sites in China in 2022 found that groundwater in some areas exhibited signs of acidification and hardening, accompanied by high sulfate concentrations (Zhang et al., 2023).  
  
Furthermore, studies have found that sulfate reduction can accelerate arsenic contamination in groundwater (Nghiem et al., 2023) and reactions involving sulfate that produce toxic environmental metabolites, such as sulfides, can have severe adverse effects on organisms, ecosystems, and human health (Zak et al., 2021; Roesel and Zak, 2023). Acid mine drainage (AMD) is one of the most prevalent forms of pollution worldwide (Huisman et al., 2006). AMD is often characterized by high levels of heavy metals and sulfate, which significantly increase the acidity and toxicity of affected waters. This form of pollution can contaminate drinking water, corrode infrastructure, and severely degrade aquatic habitats downstream (Huisman et al., 2006).  
  
Atmospheric S deposition has historically lowered pH, increased nutrient cation losses, and mobilized trace metals in soils to aquatic ecosystems, particularly in Europe and the eastern United States (e.g., Christophersen & Wright, 1981; Likens et al., 1996; Likens & Butler, 2018; Hinckley et al., 2020). However, over recent decades, large parts of North America and Europe have observed a strong reduction in atmospheric S deposition (e.g., Hinckley et al., 2020; Zak et al., 2021). Specifically, sulfur dioxide (SO2) emissions in the United States have reduced by more than three orders of magnitude compared to the emission level in the 1900s (e.g., Mitchell & Likens, 2011; Hinckley et al., 2020), a phenomenon largely attributed to the implementation of the regulatory measures like the Clean Air Act (CAA) initiated in the early 1970s (e.g., Driscoll et al., 2001; Mitchell & Likens, 2011; Hinckley et al., 2020).  
  
Additionally, atmospheric S deposition, such as acid rain, transports sulfuric acid back to the Earth's surface, contributing to terrestrial sulfur inputs. Under oxidizing conditions, iron sulfide minerals (e.g., pyrite, pyrrhotite) weather to produce sulfuric acid (Calmels et al., 2007; Lerman et al., 2007; Torres et al., 2014; Zhang et al., 2020). The resulting acidic conditions intensify chemical weathering in soils and watersheds, accelerating the dissolution of carbonate and silicate rocks. Such mechanisms can disturb the long-term carbon cycle and carbon dioxide captured during the formation of carbonates, silicates and secondary minerals is partially re-released back to the environment, altering the equilibrium of atmospheric CO2 over geological timescales (Lerman et al., 2007; Torres et al., 2014; Zhang et al., 2020).  
  
Ultimately, sulfur-induced weathering processes have dual effects: they contribute to carbon mobilization and impact global carbon sequestration pathways, linking sulfur dynamics to climate regulation (e.g., Berner and Raiswel, 1983; Torres et al., 2014). This interconnection underscores the importance of sulfur cycling in Earth's geochemical processes and its broader implications for environmental and climate change studies.  

  ### Random Forest Machine Learning Model
Given the complex dynamics of sulfate in freshwater ecosystems and its significant environmental impacts, there is a pressing need to better understand and predict sulfate concentrations across diverse landscapes. Specifically in the contiguous United States (CONUS), sulfate concentrations exhibit spatial and temporal variability. Traditional approaches to water quality modeling often rely on process-based methods or simple statistical techniques. However, the complex, non-linear relationships between sulfate concentrations and environmental attributes may be discovered through machine modeling approaches. Machine learning techniques, particularly random forest modeling, have emerged as powerful tools for predicting chemical species in freshwater ecosystems across large spatial scales (e.g., Yang et al., 2023; Tian et al., 2024).  
  
The Random Forest (RF) model is a machine learning technique that was initially introduced in 1995 (Ho, 1995) and subsequently improved in the early 2000s (Breiman, 2001). This model combines multiple independent decision trees, which collectively vote for the most popular prediction, thereby enhancing prediction accuracy (Breiman, 2001). Each tree acts as a sub-model, constructed from a random subset of the data (Figure 1) (E et al., 2023). The model's capability to handle high-dimensional data, capture non-linear relationships, and provide variable importance measures makes it highly suitable for analyzing the various factors influencing sulfate fluxes (e.g., Breiman, 2001; Tian et al., 2024). Additionally, the RF model can help mitigate overfitting through its regression approach.  
  
RF models have gained popularity in geoscience and environmental research due to their robustness and high predictive accuracy. For example, Le et al. (2019) applied an RF approach to forecast changes in surface water conductance in Germany from 2070 to 2100 under climate change scenario. Similarly, E et al. (2023) applied an RF model to predict monthly-aggregated salinity and alkalinity fluxes across the continental United States, identifying key parameters contributing to both alkalization and salinization. Tian et al. (2024) utilized various machine learning models, including the RF model, to analyze the factors controlling groundwater sulfate levels and to predict sulfate concentrations in groundwater in North China. These examples demonstrate the versatility and effectiveness of RF models for predicting analyte concentrations in aquatic ecosystems and highlight their suitability for complex environmental datasets.  
  
## Research Questions
This research seeks to address and answer the following questions:
1.	a. How do various watershed attributes, such as climate, geology, land cover, and land use, influence riverine sulfate fluxes on a continental scale?
    b. Which of these attributes are the most important predictors of sulfate fluxes?
2. Can a Random Forest (RF) machine learning model effectively predict sulfate fluxes in ungauged catchments across the contiguous United States (CONUS)?
3. Is there spatial variability in sulfate fluxes across the CONUS?

## Data and Method
  ### Data Retrieval
Since the main goal of the research is to predict the sulfate fluxes in the continental US rivers, we collected and standardized hydrogeochemical data from gauged catchments and incorporate long-term environmental and geological data across the contiguous U.S. (CONUS). This research encompassed sulfate concentration data from a publicly accessible database named Water Quality Portal (WQP) that are sponsored and contributed by the United States Geological Survey (USGS) and Environmental Protection Agency (EPA) (Read et al., 2017). My research prioritized three parameters of the available data in the selection process, therefore my workflow in this section encompasses 16 steps. Since the focus is on sulfate fluxes in the stream water, then the characteristic name chosen for the analyte were “Sulfate”, “Sulfate as SO4”, “Total Sulfate”, “Sulfur Sulfate”, and “Sulfate as S” due to the different naming and sampling protocols are followed by USGS and USEPA. For site selection, only categories classified as "stream," "river," or similar types that can be reasonably justified as stream/river were considered, as the project focuses on predicting riverine fluxes. The R package named dataRetrieval was used to query relevant data from the WQP database (DeCicco et al., 2024). The downloaded data include four key data types of interest: site information, reported sample results, sampling activity information, and result detection quantitation limit data.

Once the sulfate concentration data had been filtered, the next step was to download discharge data using the dataRetrieval package. It is essential to match the available discharge data with the filtered sites by using the site number to query the discharge records. Due to data availability constraints, the discharge data used for model training are limited to those collected by the USGS. This step further reduces the amount of usable data, as not all sites have associated discharge data. Reasons include mismatched sampling dates, missing discharge records, or retrieval function issues. Among the four data query functions (readWQPdata, readNWISdata, readNWISqw, and readNWISdv), the readNWISdv function was selected to retrieve USGS daily averaged discharge data. The query used existing site numbers from the available sulfate concentration data and the parameter code 00060, representing mean daily discharge (ft³/s) data stored in the WQP database.

Watershed attributes are essential for this project, as they are informed by domain knowledge to identify the most likely sources of sulfate in the river. Those characteristics were calculated by delineating the corresponding watershed for each monitoring station. This process utilized three core layers from the HydroSHEDS database (https://www.hydrosheds.org/hydrosheds-core-downloads): hydrologically conditioned Digital Elevation Model (DEM), flow direction, and flow accumulation. The delineated watersheds were then overlaid with other geo-coded data to extract and analyze watershed characteristics. The queried features included climate, geology, geomorphology, hydrology, soil chemistry, land use, and land cover.

  ### Data Processing
All data used in this project were processed using R scripts and managed in the form of data tables within R. A comprehensive 16-step process was developed to filter the data, which will be detailed later in this chapter, and the entire workflow, including model training and evaluation, is illustrated as a roadmap in Figure 2.

 For Water Quality Portal (WQP) datasets, sulfate concentration data from the lower 48 states and the District of Columbia, corresponding to the previously mentioned five characteristic names, were queried, downloaded, imported into R, and merged. Stations without a site number or with an invalid sampling date (e.g., dates like '0003-xx-xx' or before the year 1900) were removed. For convenience, state names, state Federal Information Processing System (FIPS) codes, and county FIPS codes were appended to the dataset. To streamline the dataset, a subset of 29 columns out of the original 110 columns were selected for data cleansing and to reduce data size. Sites sampled from rivers, streams, or other justifiable locations were retained. Two filters were then applied to accurately select data entries labeled as “Surface Water”, “Water”, or “water” in the “ActivityMediaSubdivisionName” column, and “Water” or “Other” in the “ActivityMediaName” column. Additionally, data entries that are marked as rejected, estimated, calculated, or contain NA values were filtered out. We need to keep the data identified as “Total” or “Dissolved” or any labels that can be justified as one of the two categories based on the column named “ResultSampleFractionText”. 

 At this stage, all data were converted from character to numeric format for further calculations and unit conversions. Detection limit data were used to identify any unreasonable values based on their labels. If a gauging station did not report sulfate concentration due to the detection limits of the measuring instrument, the detection limit value was assigned to the sulfate concentration entry for that station. Entries modified during this step were given a censor code of “lt” (meaning ‘less than’), while all other entries were labeled “nc” (meaning ‘non-censored’) to maintain records for future references. Blanks, spikes, and reference materials used for laboratory quality control were excluded, as they do not represent actual observations.

 Next, we standardized all original sulfate concentrations to mg/L to ensure consistency for future flux calculations and comparison with literature. For each river monitoring site, we removed negative values, zeros, and outliers. We identified and removed duplicate entries (which occurred when sampling produced the same data on the same day during the same activity). To minimize human error while handling approximately two million data entries, we applied a 99.9% confidence interval to exclude extreme values without significantly impacting the dataset's integrity. The final step in this workflow involved calculating and storing daily average sulfate concentrations for flux calculations. The discharge data downloading and processing follow a similar protocol. 

 We calculated sulfate fluxes using drainage area, daily sulfate concentration, and discharge flow rate for each site. The downloaded discharge data included daily averaged discharge values. We matched the daily averaged sulfate concentration data with the daily mean discharge data using site number and sampling date. To evaluate the long-term trend of stream sulfate fluxes at each site, we calculated daily sulfate fluxes from daily averaged sulfate concentration and daily averaged discharge at each individual site. Then we aggregated the daily sulfate flux at each site to yearly monthly flux by combining data by year and month. Finally, we aggregated these values to obtain the annual average of the monthly water chemistry measurements, which we refer to as long-term averaged monthly sulfate flux. To determine the sulfate flux in the stream, the following calculation was applied:  
 F = \frac{IAC \times D \times 28.32 \frac{liters}{ft^3} \times 3600 \frac{second}{hour} \times 24 \frac{hour}{day} \times 30 \frac{day}{month}}{WA},  
in which F represents sulfate flux (mg/km2/month), IAC is the monthly inorganic sulfate concentration (mg/L), D represents river discharge (ft3/s) while WA denotes watershed area (km2) (E et al., 2023). The numbers of 28.32 is unit conversion factors between liters and ft3. 

We intended to select 45 watershed characteristics (listed in Table S1) that are likely to influence sulfate fluxes in rivers across the continental United States, informed by domain knowledge (E et al., 2023). These characteristics encompass hydrology (5 variables), climate (2 variables), geomorphology (3 variables), soil chemistry (5 variables), geology (16 variables), land use (2 variables), and land cover (12 variables). 

  ### Random Forest Model Description, Training and Evaluation
We employed a Random Forest (RF) machine learning model to assess how various watershed attributes (e.g., climate, hydrology, geology, geomorphology, soil chemistry, land cover, and land use) affect stream sulfate fluxes. The RF model was built and implemented in R using the mlr package (Bischl et al., 2016). We can estimate the sulfate fluxes for each watershed using these watershed attributes and their relationships with sulfate fluxes. Random forest (RF) is an ensemble learning method based on decision trees, and it offers several advantages for modeling sulfate fluxes (Figure 1). The model training process will involve fine-tuning hyperparameters for optimal predicting performance (e.g., number of trees (num.trees), the minimal size of the tree branch in each sub-model (min.node.size), and the number of predictor variables selected at each split (mtry)). To ensure more reliable model performance, we truncated the sulfate flux values at the 95th percentile before training, preventing extreme outliers from disproportionately influencing the learning process (Figure 3). We then randomly selected data on a per-sample basis rather than on a per-site basis and divided the dataset into 10 subsets for cross-validation (Breiman, 2001; Ho, 1998). One subset was designated as the hold-out set for evaluation, while the remaining nine subsets were used for model training (Breiman, 2001). 

The trained RF model was then applied to predict sulfate fluxes in ungauged catchments across the CONUS and enabled us to generate high-resolution maps of riverine sulfate fluxes. The model outputs will offer insights into the mechanisms controlling sulfate dynamics, and we will assess the relative importance of various predictor variables, representing watershed attributes, by calculating Conditional Permutation Importance (CPI). The CPI value assesses the relative importance of each predictor variable in determining sulfate fluxes within the watershed (E et al., 2023). 

To evaluate model performance, we first assessed the model’s predictive capabilities using the R2 metric, which examines how closely the predicted values align with the actual observations. A high R2 value indicates that the model captures the variability in the training dataset effectively and performs relatively well. Additionally, we calculated residuals using the following definition on the training dataset to provide a more comprehensive assessment of predictive accuracy: Residual = Predicted Sulfate Fluxes – Ground Truth Sulfate Fluxes.

## Preliminary Results
Our data processing workflow produced input data to the RF model for training purpose and our Random Forest model analysis produced two key findings regarding sulfate fluxes across the contiguous United States (CONUS): (1) predicted patterns of annual riverine sulfate flux across ungauged watersheds and (2) the relative importance of different watershed attributes in controlling sulfate flux. Each of these findings provides insights into the spatial dynamics and controlling factors of riverine sulfate fluxes. 

Figure 4 illustrates the spatial distribution of USGS monitoring sites used to train the Random Forest model. The sites involved are labeled as blue dots in the continental US map. It shows that the matched pairs of both sulfate concentrations and discharges are sparse: condensed USGS monitoring stations used for training are located at eastern US, especially northeastern US, whereas there is fewer monitoring stations used for training that are located at western US.

The annual riverine sulfate flux map for ungauged watersheds across the CONUS is shown in Figure 5, and the log-scaled annual riverine sulfate flux map for ungauged watersheds across the CONUS is shown in Figure 6. The variation in annual riverine sulfate flux was captured by a color gradient. Notably lower fluxes are seen in the western and southwestern regions, particularly in arid areas, whereas the higher (> 1.50 \times 10^{10} \text{ mg/km²/month}) and the highest fluxes (3.45 \times 10^{10} \text{ mg/km²/month}) are observed in parts of the northeastern United States. 

The Conditional Permutation Importance (CPI) analysis quantified the relative influence of watershed attributes on riverine sulfate flux predictions (Figure 7). Among all watershed characteristics, siliciclastic sediments emerged as the dominant predictor, followed by surface runoff and population density. The most influential features clustered into three main categories: (1) geological factors, with siliciclastic sediments showing the strongest control; (2) hydrological factors, including surface runoff and soil moisture at various depths (total, 0-10 cm, and 10-30 cm layers); and (3) anthropogenic factors, encompassing population density, urban development, mixed tree coverage, and human footprint index. In contrast, several geological features (e.g., plutonic rocks, pyroclastic sediments, ice glaciers) and land cover types (e.g., snow ice, flooded vegetation) demonstrated minimal influence on sulfate flux predictions. The remaining watershed characteristics exhibited relatively low importance in controlling sulfate fluxes, suggesting their limited role in determining riverine sulfate dynamics.

## Discussion
  ### Spatial Patterns of Sulfate Fluxes
Our preliminary finding reveals distinct spatial patterns in riverine sulfate fluxes across the CONUS, with notably higher fluxes in the northeastern United States compared to the western regions. These spatial variations can be attributed to various factors, including geological, hydrological, anthropogenic and other features of the watersheds. The dominant influence of siliciclastic sediments, as revealed by our CPI analysis, underscores the fundamental role of geological substrate in controlling sulfate fluxes. Siliciclastic sediments that originated from silicate rocks weathered by sulfuric acid that originates from pyrite weathering, might be a significant natural source of sulfate in rivers (Calmels et al., 2007; Ross et al., 2018; Zhang et al., 2020). The oxidative weathering of pyrite with oxygen and water can be described as:
FeS_2 + \frac{15}{4}O_2 + \frac{7}{2}H_2O \rightarrow Fe(OH)_3 + 2H_2SO_4

Atmospheric deposition of sulfur, such as acid rain, can also introduce sulfate. Given that the data capture long-term sulfate flux changes, higher sulfate fluxes could still be partially attributed to historical wet and dry sulfur deposition, as shown in Figure 8. However, CPI analysis suggests that its contribution is less significant compared to siliciclastic sediments and runoff. Notably, the United States has made substantial progress in reducing atmospheric sulfur pollution since the 1970s with the implementation of the Clean Air Act (e.g., Hinckley et al., 2020; Zak et al., 2021).

The geological distribution of pyrrhotite may also explain the elevated sulfate fluxes in rivers, alongside pyrite weathering (Figure 9). Pyrrhotite (Fe1-xS) is an iron-sulfide mineral that chemically resembling pyrite (Steger and Desjardins, 1978; Mauk et al., 2020). Under weathering conditions, pyrrhotite can perform similarly to pyrite and produce sulfate ions. Pyrrhotite provides an additional source of sulfate during weathering and when combined with pyrite oxidation, the cumulative sulfate production can significantly elevate riverine sulfate fluxes. This makes pyrrhotite an additional and significant source of sulfate. When combined with the oxidation of pyrite, the cumulative sulfate production can substantially increase riverine sulfate fluxes, especially in the eastern US. 

Coal mining and power generation activities significantly influence regional sulfate fluxes. According to the U.S. Energy Information Administration (USEIA, 2024), coal production is concentrated in three main regions: the Western region (56% of total production, including Alaska), and the Interior and Appalachian regions (combined 44%) (Figure 10). The five states leading coal production are Wyoming, West Virginia, Pennsylvania, Illinois, and Kentucky (Figure 11). The spatial distribution of these coal-producing regions shows substantial overlap with areas of elevated riverine sulfate fluxes in our analysis.

Coal-fired power plants in 2023 show a distinct spatial pattern, with high concentrations in the eastern United States, particularly around the Great Lakes, northeastern states, and Florida (Figure 11, USEIA, 2024). This distribution not only reflects population density patterns but also correlates strongly with regions of elevated sulfate fluxes identified in our study (Figures 5 and 10). The spatial alignment between coal-fired power plants and high stream sulfate flux regions, combined with the overlap of major coal-producing areas and pyrrhotite deposition regions, reinforces our finding that both geological factors and anthropogenic activities drive riverine sulfate patterns across the CONUS.

Acid mine drainage (AMD) from coal mining operations represents a significant source of sulfate in U.S. rivers (Akcil and Koldas, 2006; Zheng et al., 2017; Acharya and Kharel, 2020). AMD occurs when mining activities, highway construction, and other large-scale excavations expose sulfide minerals to atmospheric conditions (Skousen et al., 2019). This process releases calcium, magnesium, bicarbonate, and sulfate ions into solution, contaminating both surface and groundwater systems (e.g., Akcil and Koldas, 2006; Ross et al., 2018; Acharya and Kharel, 2020). The spatial correlation between high stream sulfate fluxes and major coal-producing regions in our analysis suggests that AMD significantly influences regional sulfate dynamics (Figures 6 and 11). This inference is supported by previous studies documenting over 20,000 kilometers of U.S. streams impacted by AMD (Skousen et al., 2019). The widespread impact of AMD reinforces our finding that runoff might serves as a primary mechanism for sulfate transport in stream systems, highlighting the interconnection between mining activities and regional water chemistry.

  ### Model Performance and Limitations
The Random Forest model demonstrated moderate predictive capability for riverine sulfate fluxes across the CONUS, with an R2 value of 0.6 and Mean Square Error (MSE) of 1.91  1017 mg/km²/month (Figure 12). While this indicates that the model captures significant variation in sulfate fluxes, there remains substantial unexplained variance. The residual plot (Figure 13) shows the difference between predicted and actual values, with positive residuals above and negative residuals below the red line. The spread and pattern of residuals suggest increasing prediction errors at higher flux values, and thus the model’s performance decreases with more extreme sulfate fluxes. The increasing spread of residuals at higher flux values likely stems from two key factors: limited training examples of high-flux scenarios (Figure 3) and the complex nature of sulfate behavior inside watersheds and from watersheds to rivers.

Several limitations of our modeling approach warrant consideration. First, the uneven spatial distribution of USGS monitoring sites introduces potential geographical bias, with denser coverage in the eastern United States and no station available in midwestern US potentially affecting model performance in western regions (Figure 4). Therefore, the model would have performed well in eastern US but not in other parts of the CONUS. Second, while our model incorporates a comprehensive set of watershed attributes, certain dynamic processes, such as seasonal variations in sulfate sources and transport mechanisms, may not be fully captured by the static predictors used in our analysis. 

The model's performance should also be viewed in the context of data quality and availability. The reliance on matched pairs of sulfate concentration and discharge measurements means that some watersheds may be underrepresented due to incomplete temporal coverage. Incorporating the USEPA database as part of the training dataset could potentially enhance model performance by providing additional data coverage and improving predictive accuracy. Additionally, the complexity of sulfate sources and transport pathways in urban and industrialized areas may contribute to larger prediction errors in these regions. It is important to note the variability in data availability for river discharge data. Discharge data retrieved from the Water Quality Portal (WQP) using different query approaches (e.g., readWQPdata, readNWISdata, readNWISdv, readNWISqw from the dataRetrieval package in R) yielded varying results. 

# Table 1. Summary of data functions used, and the number of entries returned for site USGS-06339500 with USGS parameter code 00060.

| Data function used | readWQPdata | readNWISdata | readNWISdv | readNWISqw |
|-------------------|-------------|--------------|------------|------------|
| # entries returned| 154         | 1            | 36659      | 154        |

For the example site USGS-06339500 and parameter code 00060 (mean daily discharge in ft³/s), discharge data were retrieved using four query approaches. Among the tested query functions (readWQPdata, readNWISqw, and readNWISdv), the readNWISdv function yielded the most complete discharge dataset. The other functions returned substantially fewer records, indicating potential limitations in their data retrieval capabilities. This comparison revealed that the choice of data retrieval function significantly impacts both the completeness and quality of discharge data, ultimately affecting model performance.

## Conclusion
This study successfully predicted riverine sulfate fluxes across the contiguous United States (CONUS) by applying a Random Forest (RF) machine learning model. The preliminary results provide a high-resolution riverine sulfate flux map for ungauged watersheds in CONUS. Furthermore, the model also provided the key watershed features influencing sulfate dynamics. Our analysis revealed spatial variability of sulfate fluxes, with elevated fluxes clustered in parts of the northeastern U.S., north-midwestern US and part of Florida. These high fluxes are thought to be driven predominantly by geological, hydrological, and anthropogenic watershed characteristics. Siliciclastic sediments emerged as the most important predictor, highlighting the role of pyrite and pyrrhotite weathering as possible natural sulfate sources, while surface runoff and population density might reflect hydrological and anthropogenic contributions. The spatial overlap between coal-producing regions, acid mine drainage, and riverine sulfate flux hotspots further emphasizes the potential impact of geological, hydrological and human activities on sulfate mobilization from geologic reservoirs to the river system.

Although the RF model demonstrated intermediate level of predictive accuracy (R2 = 0.6), limitations such as data sparsity in the western U.S. and data query incomplete issues suggest possible pathways for future improvement. Enhancing the training dataset, for instance by incorporating USEPA data to improve the quantity and quality of training dataset, could further refine model performance and expand predictive capabilities.

Overall, this preliminary study provides a framework for understanding riverine sulfate fluxes in ungauged watersheds of CONUS, offering valuable insights into how various watershed attributes contribute to the sulfate fluxes in the stream. These findings have important implications for water resource management and future environmental monitoring efforts, particularly in addressing the impacts of sulfate on aquatic ecosystems and water quality across diverse landscapes in CONUS.

## Supplementary Materials
# Table S1. A list of all 45 watershed attributes, along with feature categories. 
|     Feature name                       |     Category          |
|----------------------------------------|-----------------------|
|     Runoff                             |     hydrology         |
|     Soil moisture                      |     hydrology         |
|     Soil moisture 0-10   cm            |     hydrology         |
|     Soil moisture 10-30   cm           |     hydrology         |
|     Potential   Evapotranspiration     |     hydrology         |
|     Temperature                        |     climate           |
|     Precipitation                      |     climate           |
|     Erosion rate                       |     geomorphology     |
|     Elevation                          |     geomorphology     |
|     Slope                              |     geomorphology     |
|     Soil organic carbon                |     soil chemistry    |
|     Soil pH                            |     soil chemistry    |
|     Net primary productivity           |     soil chemistry    |
|     Gross primary productivity         |     soil chemistry    |
|     Soil cation   exchange capacity    |     soil chemistry    |
|     Evaporite                          |     geology           |
|     Carbonate sediment                 |     geology           |
|     Siliciclastic   sediment           |     geology           |
|     Pyroclastic   sediment             |     geology           |
|     Mixed sediment                     |     geology           |
|     Unconsolidated   sediment          |     geology           |
|     Volcanic basic                     |     geology           |
|     Volcanic intermediate              |     geology           |
|     Volcanic acid                      |     geology           |
|     Metamorphic                        |     geology           |
|     Plutonic acid                      |     geology           |
|     Plutonic basic                     |     geology           |
|     Plutonic   intermediate            |     geology           |
|     Rock_water                         |     geology           |
|     Rock_nodata                        |     geology           |
|     Ice glaciers                       |     geology           |
|     Impervious surface   area          |     land use          |
|     Population                         |     land use          |
|     Human footprint   index            |     land use          |
|     Cultivated   vegetation            |     land cover        |
|     Urban                              |     land cover        |
|     Mixed Trees                        |     land cover        |
|     Shrubs                             |     land cover        |
|     Herbaceous   vegetation            |     land cover        |
|     Flooded vegetation                 |     land cover        |
|     Snow ice                           |     land cover        |
|     Barren                             |     land cover        |
|     Water                              |     land cover        |
|     Evergreen broadleaf                |     land cover        |
|     Deciduous broadleaf                |     land cover        |
|     Needleleaf                         |     land cover        |


# Figure 1.
(/path/to/image.png "
# Figure 2.
(/path/to/image.png "
# Figure 3.
(/path/to/image.png "
# Figure 4.
(/path/to/image.png "
# Figure 5.
(/path/to/image.png "
# Figure 6.
(/path/to/image.png "
# Figure 7.
(/path/to/image.png "
# Figure 8.
(/path/to/image.png "
# Figure 9.
(/path/to/image.png "
# Figure 10.
(/path/to/image.png "
# Figure 11.
(/path/to/image.png "
# Figure 12.
(/path/to/image.png "
# Figure 13.
(/path/to/image.png "

## Reference
Acharya, B.S., Kharel, G., 2020. Acid mine drainage from coal mining in the United States – An overview. Journal of Hydrology 588, 125061. https://doi.org/10.1016/j.jhydrol.2020.125061

Akcil, A., Koldas, S., 2006. Acid Mine Drainage (AMD): causes, treatment and case studies. Journal of Cleaner Production 14, 1139–1145. https://doi.org/10.1016/j.jclepro.2004.09.006

Berner, R.A., Raiswel, R., 1983. Burial of organic carbon and pyrite sulfur in sediments over Phanerozoic time: a new theory.

Bischl, B., Lang, M., Kotthoff, L., Schiffner, J., Richter, J., Studerus, E., Casalicchio, G., Jones, Z.M., 2016. mlr: Machine Learning in R.

Breiman, L., 2001. Random Forests. Machine Learning 45, 5–32. https://doi.org/10.1023/A:1010933404324

Calmels, D., Gaillardet, J., Brenot, A., France-Lanord, C., 2007. Sustained sulfide oxidation by physical erosion processes in the Mackenzie River basin: Climatic perspectives. Geol 35, 1003. https://doi.org/10.1130/G24132A.1

Christophersen, N., Wright, R.F., 1981. Sulfate budget and a model for sulfate concentrations in stream water at Birkenes, a Small forested catchment in southernmost Norway. Water Resources Research 17, 377–389. https://doi.org/10.1029/WR017i002p00377

DeCicco, L.A., Lorenz, D., Hirsch, R.M., Watkins, W., Johnson, M., 2024. dataRetrieval: R packages for discovering and retrieving water data available from U.S. federal hydrologic web services.

Driscoll, C.T., Lawrence, G.B., Bulger, A.J., Butler, T.J., Cronan, C.S., Eagar, C., Lambert, K.F., Likens, G.E., Stoddard, J.L., Weathers, K.C., 2001. Acidic Deposition in the Northeastern United States: Sources and Inputs, Ecosystem Effects, and Management Strategies. BioScience 51, 180. https://doi.org/10.1641/0006-3568(2001)051[0180:ADITNU]2.0.CO;2

E, B., Zhang, S., Driscoll, C.T., Wen, T., 2023. Human and natural impacts on the U.S. freshwater salinization and alkalinization: A machine learning approach. Science of The Total Environment 889, 164138. https://doi.org/10.1016/j.scitotenv.2023.164138

Hinckley, E.-L.S., Crawford, J.T., Fakhraei, H., Driscoll, C.T., 2020. A shift in sulfur-cycle manipulation from atmospheric emissions to agricultural additions. Nat. Geosci. 13, 597–604. https://doi.org/10.1038/s41561-020-0620-3

Ho, T.K., 1998. The random subspace method for constructing decision forests. IEEE Trans. Pattern Anal. Machine Intell. 20, 832–844. https://doi.org/10.1109/34.709601

Ho, T.K., 1995. Random decision forests, in: Proceedings of 3rd International Conference on Document Analysis and Recognition. Presented at the 3rd International Conference on Document Analysis and Recognition, IEEE Comput. Soc. Press, Montreal, Que., Canada, pp. 278–282. https://doi.org/10.1109/ICDAR.1995.598994

Hudak, P.F., 2000. Sulfate and chloride concentrations in Texas aquifers. Environment International 26, 55–61. https://doi.org/10.1016/S0160-4120(00)00078-7

Huisman, J.L., Schouten, G., Schultz, C., 2006. Biologically produced sulphide for purification of process streams, effluent treatment and recovery of metals in the metal and mining industry. Hydrometallurgy 83, 106–113. https://doi.org/10.1016/j.hydromet.2006.03.017

Kleeberg, A., 2014. Eintrag und Wirkung von Sulfat in Oberflächengewässern, in: Handbuch Angewandte Limnologie. pp. 1–34. https://doi.org/10.1002/9783527678488.hbal2012004

Le, T.D.H., Kattwinkel, M., Schützenmeister, K., Olson, J.R., Hawkins, C.P., Schäfer, R.B., 2019. Predicting current and future background ion concentrations in German surface water under climate change. Phil. Trans. R. Soc. B 374, 20180004. https://doi.org/10.1098/rstb.2018.0004

Lerman, A., Wu, L., Mackenzie, F.T., 2007. CO2 and H2SO4 consumption in weathering and material transport to the ocean, and their role in the global carbon balance. Marine Chemistry 106, 326–350. https://doi.org/10.1016/j.marchem.2006.04.004

Likens, G.E., Butler, T.J., 2018. Acid Rain: Causes, Consequences, and Recovery in Terrestrial, Aquatic, and Human Systems, in: Encyclopedia of the Anthropocene. Elsevier, pp. 23–31. https://doi.org/10.1016/B978-0-12-809665-9.09977-8

Likens, G.E., Driscoll, C.T., Buso, D.C., 1996. Long-Term Effects of Acid Rain: Response and Recovery of a Forest Ecosystem. Science, New Series 272, 244–246.

Mauk, J.L., Crafford, T.C., Horton, J.D., San Juan, C.A., Robinson Jr., G.R., 2020. Pyrrhotite Distribution in the Conterminous United States, 2020 (Fact Sheet), Fact Sheet.

Miao, Z., Brusseau, M.L., Carroll, K.C., Carreón-Diazconti, C., Johnson, B., 2012. Sulfate reduction in groundwater: characterization and applications for remediation. Environ Geochem Health 34, 539–550. https://doi.org/10.1007/s10653-011-9423-1

Mitchell, M.J., Likens, G.E., 2011. Watershed Sulfur Biogeochemistry: Shift from Atmospheric Deposition Dominance to Climatic Regulation. Environ. Sci. Technol. 45, 5267–5271. https://doi.org/10.1021/es200844n

Nghiem, A.A., Prommer, H., Mozumder, M.R.H., Siade, A., Jamieson, J., Ahmed, K.M., Van Geen, A., Bostick, B.C., 2023. Sulfate reduction accelerates groundwater arsenic contamination even in aquifers with abundant iron oxides. Nat Water 1, 151–165. https://doi.org/10.1038/s44221-022-00022-z

Roesel, L.K., Zak, D.H., 2023. Unravelling the role of sulphate in reed development in urban freshwater lakes. Water Research 233, 119785. https://doi.org/10.1016/j.watres.2023.119785

Ross, M.R.V., Nippgen, F., Hassett, B.A., McGlynn, B.L., Bernhardt, E.S., 2018. Pyrite Oxidation Drives Exceptionally High Weathering Rates and Geologic CO2 Release in Mountaintop‐Mined Landscapes. Global Biogeochemical Cycles 32, 1182–1194. https://doi.org/10.1029/2017GB005798

Sahour, H., Gholami, V., Torkaman, J., Vazifedan, M., Saeedi, S., 2021. Random forest and extreme gradient boosting algorithms for streamflow modeling using vessel features and tree-rings. Environ Earth Sci 80, 747. https://doi.org/10.1007/s12665-021-10054-5

Schlesinger, W.H., Bernhardt, E.S., 2020. Biogeochemistry: An Analysis of Global Change, 4th ed. Academic Press.

Shiklomanov, I.A., 1993. World Freshwater Resources, in: Gleick, P.H. (Ed.), Water in Crisis: A Guide to World’s Freshwater Resources. Oxford University Press, New York, pp. 13–24.

Skousen, J.G., Ziemkiewicz, P.F., McDonald, L.M., 2019. Acid mine drainage formation, control and treatment: Approaches and strategies. The Extractive Industries and Society 6, 241–249. https://doi.org/10.1016/j.exis.2018.09.008

Steger, H.F., Desjardins, L.E., 1978. Oxidation of sulfide minerals, 4. Pyrite, chalcopyrite and pyrrhotite. Chemical Geology 23, 225–237. https://doi.org/10.1016/0009-2541(78)90079-7

Stoddard, J.L., Jeffries, D.S., Lükewille, A., Clair, T.A., Dillon, P.J., Driscoll, C.T., Forsius, M., Johannessen, M., Kahl, J.S., Kellogg, J.H., Kemp, A., Mannio, J., Monteith, D.T., Murdoch, P.S., Patrick, S., Rebsdorf, A., Skjelkvåle, B.L., Stainton, M.P., Traaen, T., Van Dam, H., 

Webster, K.E., Wieting, J., Wilander, A., 1999. Regional trends in aquatic recovery from acidification in North America and Europe. Nature 401, 575–578. https://doi.org/10.1038/44114

Tian, Y., Liu, Q., Ji, Y., Dang, Q., Sun, Y., He, X., Liu, Y., Su, J., 2024. Prediction of sulfate concentrations in groundwater in areas with complex hydrogeological conditions based on machine learning. Science of The Total Environment 923, 171312. https://doi.org/10.1016/j.scitotenv.2024.171312

Torres, M.A., West, A.J., Li, G., 2014. Sulphide oxidation and carbonate dissolution as a source of CO2 over geological timescales. Nature 507, 346–349. https://doi.org/10.1038/nature13030

Torres-Martínez, J.A., Mora, A., Knappett, P.S.K., Ornelas-Soto, N., Mahlknecht, J., 2020. Tracking nitrate and sulfate sources in groundwater of an urbanized valley using a multi-tracer approach combined with a Bayesian isotope mixing model. Water Research 182, 115962. https://doi.org/10.1016/j.watres.2020.115962

USEIA, 2024. Annual Coal Report 2023. U.S. Energy Information Administration.

USEPA, 2012. Sulfate in Drinking Water US EPA [WWW Document]. URL https://archive.epa.gov/water/archive/web/html/sulfate.html (accessed 11.13.24).

Wang, H., Zhang, Q., 2019. Research Advances in Identifying Sulfate Contamination Sources of Water Environment by Using Stable Isotopes. IJERPH 16, 1914. https://doi.org/10.3390/ijerph16111914

Yang, H., Wang, P., Chen, A., Ye, Y., Chen, Q., Cui, R., Zhang, D., 2023. Prediction of phosphorus concentrations in shallow groundwater in intensive agricultural regions based on machine learning. Chemosphere 313, 137623. https://doi.org/10.1016/j.chemosphere.2022.137623

Zak, D., Hupfer, M., Cabezas, A., Jurasinski, G., Audet, J., Kleeberg, A., McInnes, R., Kristiansen, S.M., Petersen, R.J., Liu, H., Goldhammer, T., 2021. Sulphate in freshwater ecosystems: A review of sources, biogeochemical cycles, ecotoxicological effects and bioremediation. Earth-Science Reviews 212, 103446. https://doi.org/10.1016/j.earscirev.2020.103446

Zhang, D., Zhao, Z., Li, X., Zhang, L., Chen, A., 2020. Assessing the oxidative weathering of pyrite and its role in controlling atmospheric CO2 release in the eastern Qinghai-Tibet Plateau. Chemical Geology 543, 119605. https://doi.org/10.1016/j.chemgeo.2020.119605

Zhang, Q., Wang, H., Xu, Z., Li, G., Yang, M., Liu, J., 2023. Quantitative identification of groundwater contamination sources by combining isotope tracer technique with PMF model in an arid area of northwestern China. Journal of Environmental Management 325, 116588. https://doi.org/10.1016/j.jenvman.2022.116588

Zheng, K., Li, H., Wang, L., Wen, X., Liu, Q., 2017. Pyrite oxidation under simulated acid rain weathering conditions. Environ Sci Pollut Res 24, 21710–21720. https://doi.org/10.1007/s11356-017-9804-9

