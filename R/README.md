# R Scripts — Data Cleaning & Exploration

This folder contains the R code for the project. All data loading, cleaning,
pre-processing, and exploratory analysis happens here using the **tidyverse**.
The scripts are numbered and are meant to be run in order.

## Requirements

Install these packages once before running the scripts:

```r
install.packages(c("tidyverse", "skimr", "janitor", "scales"))
```

| Package     | Used for                                             |
|-------------|------------------------------------------------------|
| `tidyverse` | data manipulation (dplyr), reading files (readr), dates (lubridate), plotting (ggplot2) |
| `skimr`     | rich summaries of the data (missing values, stats)   |
| `janitor`   | standardising messy column names                     |
| `scales`    | readable axis labels in plots (commas, dollars, K/M) |

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
rows is visible. About 7,600 rows are removed, leaving ~27,200.

### Step 4 — Fix invalid `year_built` values
Melbourne was founded around 1835, so any building year before 1840 (or in the
future, after 2019) is almost certainly a data-entry error. These values
(e.g. 1196, 1820, 1830) are set to `NA` rather than guessing the true year,
since inventing a value would be fabricating data. After this step the year
range is a sensible 1850–2019.

> **Order matters:** because Step 3 removes missing-price rows first, some
> invalid years attached to those rows disappear before Step 4 runs. Running
> the steps out of order gives different results, which is why the script is
> written to run top-to-bottom.

### Step 5 — Handle zero values in `landsize` and `building_area`
A building cannot have zero floor area, so `building_area == 0` is treated as
unknown and set to `NA`. Land size is more subtle: a zero is expected for a
**unit** (you do not own land when buying an apartment) and is kept, but for a
**house or townhouse** a zero almost certainly means the value was not recorded,
so it is set to `NA`. This decision uses domain knowledge — ~84% of the zero
land sizes belong to units — instead of blindly treating every zero the same.

### Step 6 — Create helper columns for time analysis
Two columns, `sale_year` and `sale_month`, are extracted from the parsed `date`
with `year()` and `month()` (lubridate). These make it easy to group prices by
year or month, both in R and later in Power BI. Note that 2016 and 2018 are
partial years (the data spans late January 2016 to mid-March 2018), which must
be kept in mind when comparing yearly totals.

### Step 7 — Save the cleaned data and run final checks
The tidy dataset is written to `data/processed/melbourne_housing_clean.csv` so
the raw file is never modified. A few final checks confirm each step took
effect: `date` is a real date type, `year_built` falls in 1850–2019,
`sale_year` spans 2016–2018, and there are no missing prices.

## Outlier note

Extreme `landsize` values (e.g. a 433,014 m² record, versus a ~553 m² median)
are **kept** rather than deleted, because they may be genuine large or rural
properties. They are handled at visualisation time instead (for example by
using the median or by filtering), so no real data is discarded during
cleaning.
