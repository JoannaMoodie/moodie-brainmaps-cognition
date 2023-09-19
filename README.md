# moodie-braingradients-cognition


This repository contains __ that I wrote in support of the preprint "Neurobiological cortical profiles as spatial correlates of complex cognitive functioning" [available here](). R scripts were run in R version 4.0.2, MATLAB scripts were run in version 2021b. 

Please get in touch with me at jmoodie@ed.ac.uk if you have any questions.

## /scripts
### _g_-morphometry associations
Scripts: 
- /cohort_brainregion_g_morphometry.m: requires the [surfstat toolbox](https://www.math.mcgill.ca/keith/surfstat/)
- /metaanalysis_brainregion_g_morphometry.R

Data sources: 
- Regional g-morphometry profiles (found in /data/vertexwise_regional_profiles.csv) are calculated by meta-analysis with data from 3 cohorts, from which it is possible to request data from: [the UK Biobank](http://www.ukbiobank.ac.uk/register-apply/),  [the STratifying Resilience and Depression Longitudinally (STRADL) study](https://www.research.ed.ac.uk/en/datasets/stratifying-resilience-and-depression-longitudinally-stradl-a-dep) and the [Lothian Birth Cohort 1936](https://www.ed.ac.uk/lothian-birth-cohorts/data-access-collaboration).

### Neurobiological profiles

The [neuromaps toolbox](https://github.com/netneurolab/neuromaps) was used to obtain cortical profiles for neurotransmitter receptor densities and metabolism. [BigBrainWarp](https://bigbrainwarp.readthedocs.io/en/latest/) contains the microstrucutral, cytoarchitectural and functional connectivity similarity gradients. 

### Correlations between _g_-morphometry associations and neurobiological profiles

The spin-based permutation significance test was done using [Alexander Bloch's method](https://github.com/spin-test/spin-test)

## /data
- /vertexwise_morphometry_g.csv is a matrix containing the _g_-morphometry profiles
- /vertexwise_morphometry_age.csv is a matrix containing the age-morphometry profiles
- /vertexwise_morphometry_sex.csv is a matrix containing the sex-morphometry profiles 

