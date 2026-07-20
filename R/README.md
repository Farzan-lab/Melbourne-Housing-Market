# R Scripts — Data Cleaning & Exploration

This folder contains the R code for the project. All data loading, cleaning,
pre-processing, and exploratory analysis happens here using the **tidyverse**.
The scripts are numbered and are meant to be run in order.

## Requirements

Install these packages once before running the scripts:

```r
install.packages(c("tidyverse", "skimr", "janitor"))
```

| Package     | Used for                                             |
|-------------|------------------------------------------------------|
| `tidyverse` | data manipulation (dplyr), reading files (readr), dates (lubridate), plotting (ggplot2) |
| `skimr`     | rich summaries of the data (missing values, stats)   |
| `janitor`   | standardising messy column names                     |

> **Working directory:** run the scripts from the project root so that relative
> paths like `data/raw/...` resolve correctly. Using an RStudio Project (`.Rproj`)
> at the project root handles this automatically.

## Scripts

| Script             | Purpose                                                    |
|--------------------|------------------------------------------------------------|
| `01_load_data.R`   | Load the raw CSV and inspect its structure (a first look). |
| `02_clean_data.R`  | Clean and pre-process the data, then save a tidy version.  |
| `03_eda.R`         | Exploratory data analysis on the cleaned dataset.          |

## Data flow

```
data/raw/Melbourne_housing_FULL.csv
        │  01_load_data.R   (inspect only, no changes)
        │  02_clean_data.R  (clean + pre-process)
        ▼
data/processed/melbourne_housing_clean.csv
        │  03_eda.R         (explore the clean data)
        ▼
   plots & summaries in outputs/
```

---

## Cleaning steps in `02_clean_data.R`

The cleaning pipeline is built up step by step. Each step is logged here as it
is added.

### Step 1 — Standardise column names
`clean_names()` (janitor) converts every column name to `lower_snake_case`.
Because it does not fix spelling, the misspelled source columns are then
renamed by hand: `lattitude → latitude`, `longtitude → longitude`,
`regionname → region_name`, `propertycount → property_count`.

### Step 2 — Parse and verify the `date` column
The raw `date` is text in day/month/year format (e.g. `28/01/2016`) and is
converted to a real date type with `dmy()` (lubridate). The conversion is
**verified, not trusted**: the number of missing dates is counted before and
after the conversion. The two counts are equal, confirming that every value was
parsed successfully and no rows had an unexpected or mixed format (any value not
matching day/month/year would have become `NA` and increased the count). Parsed
months also fall within the valid 1–12 range.

### Step 3 — Drop rows with a missing `price`
`price` is the target of the analysis, so rows without it are removed rather
than imputed (see the main README, "Data Cleaning Decisions", for the full
reasoning). Row counts are recorded before and after so the number of dropped
rows is visible.

> More cleaning steps (invalid `year_built` values, zero/outlier land sizes,
> helper columns for year and month) will be added here as the pipeline grows.
