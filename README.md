<div align="center">

# 🏙️ Melbourne Housing Market Analysis

**An end-to-end data analysis project — from raw scraped data to an interactive dashboard.**

Cleaning and exploration in **R (tidyverse)** · Visualisation in **Power BI**

[![R](https://img.shields.io/badge/R-4.x-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![tidyverse](https://img.shields.io/badge/tidyverse-1A162D?logo=tidyverse&logoColor=white)](https://www.tidyverse.org/)
[![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=white)](https://git-scm.com/)
![Status](https://img.shields.io/badge/status-in%20progress-yellow)
![License](https://img.shields.io/badge/license-MIT-green)

</div>

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Dashboard Preview](#-dashboard-preview)
- [Key Findings](#-key-findings)
- [Objectives & Questions](#-objectives--questions)
- [Dataset](#-dataset)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Methodology](#-methodology)
- [Data Cleaning Decisions](#-data-cleaning-decisions)
- [How to Reproduce](#-how-to-reproduce)
- [Roadmap](#-roadmap)
- [Author](#-author)

---

## 📖 Overview

This project explores the **Melbourne, Australia** residential real estate
market between **January 2016 and March 2018**. It walks through the complete
data analysis workflow: acquiring real scraped data, cleaning and
pre-processing it in R, exploring it for patterns, and presenting the results
in an interactive Power BI dashboard.

The intended audience is **ordinary residents and real-estate businesses** who
want to better understand how the market changes over time and across suburbs,
property types, and price ranges — with plain-language, trustworthy insights
rather than jargon.

---

## 🖼️ Dashboard Preview

> _The interactive Power BI dashboard will be added here once built (Phase 6)._

<div align="center">

<!-- Replace this placeholder with a real screenshot: -->
<!-- ![Dashboard preview](outputs/figures/dashboard_preview.png) -->

`[ dashboard screenshot coming soon ]`

</div>

---

## 💡 Key Findings

> _This section will be filled in after the exploratory analysis (Phase 3) and
> dashboard (Phase 6). Each finding will be written in plain language for a
> general audience._

- _Finding 1 — coming soon_
- _Finding 2 — coming soon_
- _Finding 3 — coming soon_

---

## 🎯 Objectives & Questions

The project examines change in the Melbourne housing market from several angles,
answering questions such as:

- How have property **prices trended over time**?
- Which **suburbs** are the most and least expensive?
- Does **distance from the Central Business District (CBD)** affect price?
- How do **house, unit, and townhouse** prices compare?
- Which areas offer the **best value for money**?

> These questions are a starting point and are refined as the data is explored.

---

## 📊 Dataset

**Source:** [Melbourne Housing Market on Kaggle](https://www.kaggle.com/datasets/anthonypino/melbourne-housing-market),
created by Tony Pino and scraped from publicly available weekly results on
Domain.com.au. The primary file is `Melbourne_housing_FULL.csv`
(~34,850 rows × 21 columns).

<details>
<summary><strong>Click to see the key columns</strong></summary>

<br>

| Column          | Description                                                          |
|-----------------|---------------------------------------------------------------------|
| `Suburb`        | Suburb name                                                         |
| `Address`       | Street address                                                      |
| `Rooms`         | Number of rooms                                                     |
| `Type`          | `h` = house/cottage/villa/terrace, `u` = unit/duplex, `t` = townhouse |
| `Price`         | Sale price in AUD                                                   |
| `Method`        | Sale method (`S` sold, `SP` sold prior, `PI` passed in, etc.)       |
| `SellerG`       | Real estate agent                                                  |
| `Date`          | Date of sale                                                       |
| `Distance`      | Distance from the CBD (km)                                          |
| `Postcode`      | Postcode                                                           |
| `Bedroom2`      | Number of bedrooms (from a secondary source)                       |
| `Bathroom`      | Number of bathrooms                                                |
| `Car`           | Number of car spaces                                               |
| `Landsize`      | Land size (m²)                                                     |
| `BuildingArea`  | Building size (m²)                                                 |
| `YearBuilt`     | Year the property was built                                        |
| `CouncilArea`   | Governing council for the area                                     |
| `Lattitude`     | Latitude (original misspelling from source)                        |
| `Longtitude`    | Longitude (original misspelling from source)                       |
| `Regionname`    | General region (West, North West, etc.)                            |
| `Propertycount` | Number of properties that exist in the suburb                      |

</details>

> **Note:** The raw data contains missing values and inconsistencies — which is
> exactly what makes it a realistic dataset for practising data pre-processing.

---

## 🛠️ Tech Stack

| Tool | Role |
|------|------|
| **R** (tidyverse, janitor, skimr, scales) | Data cleaning, pre-processing, and exploratory analysis |
| **R Markdown** | Reproducible report combining code, output, and narrative |
| **Power BI** | Interactive dashboard and data modelling (DAX) |
| **Git / GitHub** | Version control and project hosting |

---

## 📁 Project Structure

```
melbourne-housing-analysis/
├── README.md                 # Project overview (this file)
├── .gitignore                # Files and folders Git should ignore
├── data/
│   ├── raw/                  # Original, immutable data (NOT committed to Git)
│   └── processed/            # Cleaned data, ready for analysis
├── R/
│   ├── README.md             # Documentation for the R scripts
│   ├── 01_load_data.R        # Load raw data and take a first look
│   ├── 02_clean_data.R       # Clean and pre-process the data
│   ├── 03_eda.R              # Exploratory data analysis
│   └── melbourne_housing_analysis.Rmd  # Full reproducible report
├── outputs/
│   ├── figures/              # Exported charts and plots
│   └── tables/               # Exported summary tables
├── powerbi/                  # Power BI dashboard file (.pbix)
└── docs/                     # Notes, findings, and documentation
```

---

## 🔬 Methodology

The project is delivered in clear phases, each with its own output.

| Phase | Focus | Tool | Deliverable | Status |
|:-----:|-------|------|-------------|:------:|
| **0** | Project setup & repository | Git | Project skeleton | ✅ |
| **1** | Data understanding | R | List of data issues to fix | ✅ |
| **2** | Data cleaning & pre-processing | R | Clean CSV ready for analysis | ✅ |
| **3** | Exploratory data analysis (EDA) | R | Charts & insights | 🔄 |
| **4** | Data modelling | Power BI | Ready data model | ⬜ |
| **5** | Measures & KPIs | DAX | Reusable measures | ⬜ |
| **6** | Dashboard design | Power BI | Interactive dashboard | ⬜ |
| **7** | Insights & storytelling | — | Final documented findings | ⬜ |

_Legend: ✅ done · 🔄 in progress · ⬜ planned_

---

## 🧹 Data Cleaning Decisions

A core part of this project is documenting *why* each cleaning choice was made,
not just what was done. This keeps the analysis transparent and reproducible.

<details>
<summary><strong>1. Rows with a missing <code>price</code> are dropped, not imputed</strong></summary>

<br>

About 21.8% of rows (7,610 of 34,857) have no sale price. Rather than estimating
these with a model or filling them with a statistic, these rows are removed:

- **`price` is the target of the analysis.** The dashboard exists to show what
  prices *actually* are. Generating ~22% of them with a model would mean
  analysing our own estimates, and risks circular reasoning (a model assumes
  "more rooms → higher price", then we "discover" that same relationship).
  Imputing a *helper* column is defensible; imputing the *target* is not.
- **Enough real data remains.** ~27,247 genuine records remain — more than
  enough for every question here. Imputation is worth its risk only when data
  is scarce.
- **Transparency.** This is a descriptive project for a general audience. A
  suburb's average price should be a real figure, not a blend of real prices
  and model guesses.

> In a *predictive* project the approach would differ — but even then, real
> prices are kept to train and evaluate the model, never fabricated up front.

</details>

<details>
<summary><strong>2. Very sparse columns are kept as-is</strong></summary>

<br>

`building_area` (~61% missing) and `year_built` (~55% missing) are more than
half empty. Imputing them would invent the majority of the column; dropping
every row that lacks them would discard over half of otherwise useful data.
Since the core questions don't depend on these columns, they are kept untouched
— no rows removed, no gaps filled. Any chart that needs them uses the subset of
rows where they are present.

</details>

<details>
<summary><strong>3. The <code>date</code> column is parsed and verified</strong></summary>

<br>

The raw `date` is text in day/month/year format (e.g. `28/01/2016`), converted
to a real date with `dmy()`. Because a mixed format could be parsed incorrectly
and silently, the conversion is **verified, not trusted**: missing dates are
counted before and after. The counts are equal, confirming every value parsed
successfully (any unparseable value would have become `NA`). Parsed months also
fall within the valid 1–12 range.

</details>

<details>
<summary><strong>4. Invalid <code>year_built</code> values are set to NA</strong></summary>

<br>

Melbourne was founded ~1835, so years before 1840 (or after 2019) are
data-entry errors (e.g. 1196, 2106). These are set to `NA` rather than guessed.
Order matters: dropping missing-price rows first (Step 3) removes some invalid
years before this step runs.

</details>

<details>
<summary><strong>5. Zero land sizes are handled with domain knowledge</strong></summary>

<br>

A zero `building_area` is impossible → `NA`. A zero `landsize` is expected for a
**unit** (no land is owned) and is kept, but for a **house/townhouse** it almost
certainly means "not recorded" → `NA`. About 84% of zero land sizes belong to
units, so treating every zero the same would have been wrong. Extreme land-size
outliers are kept (they may be genuine large properties) and handled at
visualisation time instead.

</details>

---

## ▶️ How to Reproduce

1. **Clone** the repository:
   ```bash
   git clone https://github.com/<your-username>/melbourne-housing-analysis.git
   cd melbourne-housing-analysis
   ```
2. **Download** `Melbourne_housing_FULL.csv` from
   [Kaggle](https://www.kaggle.com/datasets/anthonypino/melbourne-housing-market)
   and place it in `data/raw/`.
3. **Install** the R packages:
   ```r
   install.packages(c("tidyverse", "janitor", "skimr", "scales", "rmarkdown"))
   ```
4. **Run** the scripts in `R/` in numbered order (or knit the `.Rmd` report).
5. **Open** the Power BI file in `powerbi/` to explore the dashboard.

---

## 🗺️ Roadmap

- [x] Project setup and Git repository
- [x] Data understanding
- [x] Data cleaning and pre-processing (7 steps)
- [ ] Exploratory data analysis
- [ ] Power BI data model and DAX measures
- [ ] Interactive dashboard
- [ ] Final insights and storytelling

---

## 👤 Author

Created as a hands-on project for learning the full data analysis workflow —
from raw data to an interactive dashboard.

> Feedback and suggestions are welcome via issues or pull requests.
