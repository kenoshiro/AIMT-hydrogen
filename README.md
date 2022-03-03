# Global hydrogen analysis by AIM/Technology

## Introduction

- This repository contains code for data analysis and plot generation for the hydrogen-analysis by AIM/Technology.
- Details on the analysis can be found in the following manuscript:  
  Oshiro, K., Fujimori, S. Role of hydrogen-based energy carriers as an alternative option to reduce residual emissions associated with mid-century decarbonization goals, *Applied Energy*, 313, 118803. https://doi.org/10.1016/j.apenergy.2022.118803

## How to use

- To run this script, scenario data file `hydrogen_data.csv` needs to be downloaded and copied to `/data/`. The instruction for the data file download can be found from [the Data Availability statement in the manuscript](https://www.sciencedirect.com/science/article/pii/S0306261922002501#s0095).
- Execute `/prog/main.R` on the command line or main console in RStudio. The figures are generated in `/output/`.
- Following R packages are required: tidyverse, cowplot, ggtern
