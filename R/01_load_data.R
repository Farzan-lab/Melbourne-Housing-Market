# =============================================================================
# 01_load_data.R
# Purpose : Load the raw Melbourne housing data and take a first look at it.
# Author  : <your name>
# =============================================================================

# ---- Load packages ----------------------------------------------------------
# tidyverse : data manipulation + plotting (dplyr, ggplot2, readr, ...)
# skimr     : quick, readable summary of a data frame
# janitor   : tidy up messy column names
library(tidyverse)
library(skimr)
library(janitor)

# ---- Load the raw data ------------------------------------------------------
# read_csv() reads a comma-separated file into a "tibble" (a tidy data frame).
# The file lives in data/raw/ and is downloaded from Kaggle.
housing_raw <- read_csv("data/raw/Melbourne_housing_FULL.csv")

# ---- First look -------------------------------------------------------------
# glimpse() shows every column, its data type, and a few example values.
glimpse(housing_raw)

# dim() returns the number of rows and columns: c(rows, columns)
dim(housing_raw)

# head() prints the first 6 rows so we can eyeball the data.
head(housing_raw)

# skim() gives a rich summary: missing values, means, distributions, etc.
skim(housing_raw)
