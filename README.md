# moodie-brainmaps-cognition

This repository contains scripts and data, in support of Brain maps of general cognitive functioning: neuroimaging and neurobiological signatures. Transl Psychiatry 15, 461 (2025). https://doi.org/10.1038/s41398-025-03617-8. 

R scripts were run in R version 4.0.2, MATLAB scripts were run in version 2021b. 

Please get in touch with me at jmoodie@ed.ac.uk if you have any questions.

## /scripts
- /cohort_g_calculations.R  # scripts for the latent _g_ models in SEM for LBC1936, STRADL and UKB. The g scores were extracted from these models, and included in the dataframe that is read in /cohort_brainregion_g_morphometry.m.
- /cohort_brainregion_g_morphometry.m: requires the [surfstat toolbox](https://www.math.mcgill.ca/keith/surfstat/)  # an example of the surfstat script to calculate _g_ with vertex-wise-morphometry associations (here, volume, but comparable scripts were run for all 5 morphometry measures, and all 9 smoothing tolerances. In addition to _g_, age, sex, and measure ~ total surface area "allometric scaling" were calculated by the relevant slight modifications of this script). 
- /metaanalysis_brainregion_g_morphometry.R  # a meta-analysis was calculated for each vertex to combine the results of the three cohorts. Again. this example is only for _g_ ~ volume, but comparable scripts were run for the 5 morphometry measures, and age, sex, and allometric scaling.
- /regional_annot_codes.m # outputs data/annot_info.csv and data/annot_parc_327684.csv, which are required for scripts/regional_spatial_correlations.R
- /regional_spatial_correlations.R # performs regional spatial corerlations for fsaverage 

## /data
- /mask.csv is the cortical mask used in vertex-wise analyses in fsaverage space (298,790)
- /vertexwise_morphometry_g.csv is a matrix containing the _g_-morphometry profiles in fsaverage space (20 fwhm)
- /vertexwise_morphometry_age.csv is a matrix containing the age-morphometry profiles in fsaverage space (20 fwhm)
- /vertexwise_morphometry_sex.csv is a matrix containing the sex-morphometry profiles in fsaverage space (20 fwhm)
- /SmoothingTolerances_UKB.ppt shows g-morphometry associations in UKB at 9 vertex-wise smoothing tolerances.
- /Metaanalysed_morphometry_means.csv
- /PC1_metabolism_fsaverage.csv was calculated for the current paper based on CBF, CMRO2 and CMRGlu maps collected by Vaishnavi et al. https://doi.org/10.1073/pnas.1010459107 and provided in [neuromaps](https://github.com/netneurolab/neuromaps).
- /PCScores.csv contains the vertex-wise scores for the 4 PCs calculated with 33 neurobiological profiles in the current paper.
- /vertexwise_allometricscaling_surfacearea.csv contains the estimates of allometric scaling calculated in the current paper (20 fwhm)

## External repos/toolboxes

- The [neuromaps toolbox](https://github.com/netneurolab/neuromaps) was used to obtain cortical profiles for neurotransmitter receptor densities and metabolism. 
- [BigBrainWarp](https://bigbrainwarp.readthedocs.io/en/latest/) contains the microstrucutral, cytoarchitectural and functional connectivity similarity gradients. 
- The [surfstat toolbox](https://www.math.mcgill.ca/keith/surfstat/) was used to calculate vertex-wise associations and display vertex-wise cortical maps
- The spin-based permutation significance test was done using [Alexander Bloch's method](https://github.com/spin-test/spin-test)

- ## Cohort data sources
- Regional g-morphometry profiles (found in /data/vertexwise_regional_profiles.csv) are calculated by meta-analysis with data from 3 cohorts, from which it is possible to request data from: [the UK Biobank](http://www.ukbiobank.ac.uk/register-apply/),  [the STratifying Resilience and Depression Longitudinally (STRADL) study](https://www.research.ed.ac.uk/en/datasets/stratifying-resilience-and-depression-longitudinally-stradl-a-dep) and the [Lothian Birth Cohort 1936](https://www.ed.ac.uk/lothian-birth-cohorts/data-access-collaboration).



![image](https://github.com/user-attachments/assets/a5108f92-e724-489d-affd-20760b4d8779)

