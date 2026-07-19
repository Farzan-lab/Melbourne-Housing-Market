# =============================================================================
# 02_clean_data.R
# Purpose : Clean and pre-process the raw data, then save a tidy version.
# Author  : <your name>
# Note    : The specific cleaning steps will be added once we have inspected
#           the raw data in 01_load_data.R. This file is a scaffold.
# =============================================================================

# ---- Load packages ----------------------------------------------------------
library(tidyverse)
library(janitor)

# ---- Load the raw data ------------------------------------------------------
housing_raw <- read_csv("data/raw/Melbourne_housing_FULL.csv")

# ---- Cleaning steps (to be filled in together) ------------------------------
# The pipe operator |> passes the result on the left into the function on the
# right, so we can chain cleaning steps in a readable top-to-bottom flow.

housing_clean <- housing_raw |>
  # 1. Standardise column names (lower_snake_case) ---------------------------
  clean_names()

  # 2. Fix data types (e.g. parse dates)     -> TODO
  # 3. Handle missing values                 -> TODO
  # 4. Remove duplicates                     -> TODO
  # 5. Handle outliers / invalid values      -> TODO
  # 6. Create helper columns (year, month)   -> TODO

# ---- Save the cleaned data --------------------------------------------------
# We save to data/processed/ so the raw file is never modified.
write_csv(housing_clean, "data/processed/melbourne_housing_clean.csv")
