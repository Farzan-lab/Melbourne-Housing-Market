# =============================================================================
# 03_eda.R
# Purpose : Exploratory Data Analysis (EDA) on the cleaned dataset.
#           Summary statistics and plots to understand the data before
#           building the Power BI dashboard.
# Author  : <your name>
# Note    : Specific analyses will be added together after cleaning.
# =============================================================================

# ---- Load packages ----------------------------------------------------------
library(tidyverse)
library(skimr)

# ---- Load the cleaned data --------------------------------------------------
housing <- read_csv("data/processed/melbourne_housing_clean.csv")

# ---- Exploratory analysis (to be filled in together) ------------------------
# Examples of questions we will explore:
#   - Distribution of prices
#   - Average price by suburb
#   - Price trend over time
#   - Price vs. distance from CBD
#   - Comparison across property types (house / unit / townhouse)

# Plots created here can be saved to outputs/figures/ with ggsave(), e.g.:
# ggsave("outputs/figures/price_distribution.png", width = 8, height = 5)
