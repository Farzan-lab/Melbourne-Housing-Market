<div align="center">

# 🧮 R Scripts — Data Cleaning & Exploration

**The R side of the project: loading, cleaning, and exploring the Melbourne housing data with the tidyverse.**

[![R](https://img.shields.io/badge/R-4.x-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![tidyverse](https://img.shields.io/badge/tidyverse-1A162D?logo=tidyverse&logoColor=white)](https://www.tidyverse.org/)
[![R Markdown](https://img.shields.io/badge/R%20Markdown-report-75AADB?logo=rstudio&logoColor=white)](https://rmarkdown.rstudio.com/)

</div>

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Requirements](#-requirements)
- [Scripts](#-scripts)
- [Data Flow](#-data-flow)
- [Cleaning Pipeline](#-cleaning-pipeline)
- [Outlier Note](#-outlier-note)

---

## 📖 Overview

This folder contains all the R code for the project. Data loading, cleaning,
pre-processing, and exploratory analysis happen here using the **tidyverse**.
The scripts are numbered and are meant to be run **in order**, since later steps
depend on earlier ones.

There are two ways to run the work:

- **Scripts** (`.R`) — run interactively, step by step, ideal while developing.
- **Report** (`.Rmd`) — knit to a single HTML document that combines the code,
  its output, and the narrative. Ideal for sharing and presentation.

---

## ⚙️ Requirements

Install these packages once before running anything:

```r
install.packages(c("tidyverse", "janitor", "skimr", "scales", "rmarkdown"))
```

| Package     | Used for                                                             |
|-------------|----------------------------------------------------------------------|
| `tidyverse` | data manipulation (dplyr), reading (readr), dates (lubridate), plots (ggplot2) |
| `janitor`   | standardising messy column names                                     |
| `skimr`     | rich summaries of the data (missing values, statistics)              |
| `scales`    | readable axis labels in plots (commas, dollars, K/M)                 |
| `rmarkdown` | knitting the `.Rmd` report to HTML                                   |

> **⚠️ Working directory:** run everything from the **project root** so relative
> paths like `data/raw/...` resolve correctly. An RStudio Project (`.Rproj`) at
> the root handles this automatically. _(The `.Rmd` uses `../data/...` because it
> lives inside this `R/` folder.)_

---

## 📜 Scripts

| File                              | Purpose                                                    |
|-----------------------------------|------------------------------------------------------------|
| `01_load_data.R`                  | Load the raw CSV and inspect its structure (a first look). |
| `02_clean_data.R`                 | Clean and pre-process the data, then save a tidy version.  |
| `03_eda.R`                        | Exploratory data analysis on the cleaned dataset.          |
| `melbourne_housing_analysis.Rmd`  | Full reproducible report (code + output + narrative).      |

---

## 🔀 Data Flow

```
data/raw/Melbourne_housing_FULL.csv
        │
        │  01_load_data.R      inspect only, no changes
        │  02_clean_data.R     clean + pre-process (7 steps)
        ▼
data/processed/melbourne_housing_clean.csv
        │
        │  03_eda.R            explore the clean data
        ▼
   plots & summaries in outputs/
```

---

## 🧹 Cleaning Pipeline

The cleaning pipeline in `02_clean_data.R` runs top-to-bottom in seven steps.
**Order matters** — for example, the date must be parsed (Step 2) before the
year and month can be extracted from it (Step 6).

<details>
<summary><strong>Step 1 — Standardise column names</strong></summary>

<br>

`clean_names()` (janitor) converts every column name to `lower_snake_case`.
Because it does not fix spelling, the misspelled source columns are renamed by
hand: `lattitude → latitude`, `longtitude → longitude`,
`regionname → region_name`, `propertycount → property_count`.

</details>

<details>
<summary><strong>Step 2 — Parse and verify the <code>date</code> column</strong></summary>

<br>

The raw `date` is text in day/month/year format (e.g. `28/01/2016`), converted
to a real date type with `dmy()` (lubridate). The conversion is **verified, not
trusted**: missing dates are counted before and after. The counts are equal,
confirming every value parsed successfully and no row had an unexpected or mixed
format (any unparseable value would have become `NA` and increased the count).
Parsed months also fall within the valid 1–12 range.

</details>

<details>
<summary><strong>Step 3 — Drop rows with a missing <code>price</code></strong></summary>

<br>

`price` is the target of the analysis, so rows without it are removed rather
than imputed (see the main [README](../README.md#-data-cleaning-decisions) for
the full reasoning). Row counts are recorded before and after. About 7,600 rows
are removed, leaving ~27,200.

</details>

<details>
<summary><strong>Step 4 — Fix invalid <code>year_built</code> values</strong></summary>

<br>

Melbourne was founded ~1835, so any year before 1840 (or after 2019) is almost
certainly a data-entry error (e.g. 1196, 1820, 1830). These are set to `NA`
rather than guessed. After this step the year range is a sensible 1850–2019.

> **Order matters:** because Step 3 removes missing-price rows first, some
> invalid years attached to those rows disappear before Step 4 runs. Running the
> steps out of order gives different results — hence the top-to-bottom design.

</details>

<details>
<summary><strong>Step 5 — Handle zero values in <code>landsize</code> and <code>building_area</code></strong></summary>

<br>

A building cannot have zero floor area, so `building_area == 0` is set to `NA`.
Land size is subtler: a zero is expected for a **unit** (no land is owned) and is
kept, but for a **house or townhouse** it almost certainly means "not recorded"
and is set to `NA`. This uses domain knowledge — ~84% of zero land sizes belong
to units — instead of treating every zero the same.

</details>

<details>
<summary><strong>Step 6 — Create helper columns for time analysis</strong></summary>

<br>

`sale_year` and `sale_month` are extracted from the parsed `date` with `year()`
and `month()` (lubridate), making it easy to group prices by year or month in R
and in Power BI. Note that 2016 and 2018 are **partial years** (the data spans
late January 2016 to mid-March 2018), which matters when comparing yearly totals.

</details>

<details>
<summary><strong>Step 7 — Save the cleaned data and run final checks</strong></summary>

<br>

The tidy dataset is written to `data/processed/melbourne_housing_clean.csv` so
the raw file is never modified. Final checks confirm each step took effect:
`date` is a real date type, `year_built` falls in 1850–2019, `sale_year` spans
2016–2018, and there are no missing prices.

</details>

---

## 📌 Outlier Note

Extreme `landsize` values (e.g. a 433,014 m² record versus a ~553 m² median) are
**kept** rather than deleted, since they may be genuine large or rural
properties. They are handled at visualisation time instead (e.g. by using the
median or by filtering), so no real data is discarded during cleaning.
