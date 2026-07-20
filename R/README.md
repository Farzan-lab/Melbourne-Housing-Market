# Melbourne Housing Market Analysis

An end-to-end data analysis project exploring the Melbourne, Australia
residential real estate market. Raw data is cleaned and pre-processed in **R
(tidyverse)**, and the results are visualised in an interactive **Power BI**
dashboard.

The goal is to help ordinary residents and real-estate businesses understand
how the Melbourne property market changes over time and across different
suburbs, property types, and price ranges.

---

## Project Objective

Explore change in the Melbourne housing industry from multiple angles by
answering questions such as:

- How have property prices trended over time?
- Which suburbs are the most and least expensive?
- Does distance from the Central Business District (CBD) affect price?
- How do house, unit, and townhouse prices compare?
- Which areas offer the best value for money?

> These questions are a starting point and will be refined as we explore the data.

---

## Dataset

**Source:** [Melbourne Housing Market on Kaggle](https://www.kaggle.com/datasets/anthonypino/melbourne-housing-market)
created by Tony Pino, scraped from publicly available weekly results on
Domain.com.au (from January 2016 onward).

The primary file used is `Melbourne_housing_FULL.csv`.

### Key columns

| Column        | Description                                                    |
|---------------|----------------------------------------------------------------|
| `Suburb`      | Suburb name                                                    |
| `Address`     | Street address                                                 |
| `Rooms`       | Number of rooms                                                |
| `Type`        | `h` = house/cottage/villa/terrace, `u` = unit/duplex, `t` = townhouse |
| `Price`       | Sale price in AUD                                              |
| `Method`      | Sale method (`S` sold, `SP` sold prior, `PI` passed in, etc.)  |
| `SellerG`     | Real estate agent                                             |
| `Date`        | Date of sale                                                   |
| `Distance`    | Distance from the CBD (km)                                     |
| `Postcode`    | Postcode                                                       |
| `Bedroom2`    | Number of bedrooms (from a secondary source)                  |
| `Bathroom`    | Number of bathrooms                                           |
| `Car`         | Number of car spaces                                          |
| `Landsize`    | Land size                                                      |
| `BuildingArea`| Building size                                                 |
| `YearBuilt`   | Year the property was built                                   |
| `CouncilArea` | Governing council for the area                                |
| `Lattitude`   | Latitude (original spelling kept from source)                 |
| `Longtitude`  | Longitude (original spelling kept from source)                |
| `Regionname`  | General region (West, North West, etc.)                       |
| `Propertycount`| Number of properties that exist in the suburb                |

> **Note:** The raw data contains missing values and inconsistencies, which is
> exactly why it is a good dataset for practising data pre-processing.

---

## Project Structure

```
melbourne-housing-analysis/
├── README.md                # Project overview (this file)
├── .gitignore               # Files and folders Git should ignore
├── data/
│   ├── raw/                 # Original, immutable data (NOT committed to Git)
│   └── processed/           # Cleaned data ready for analysis
├── R/                       # R scripts, run in numbered order
│   ├── 01_load_data.R       # Load raw data and take a first look
│   ├── 02_clean_data.R      # Clean and pre-process the data
│   └── 03_eda.R             # Exploratory data analysis
├── outputs/
│   ├── figures/             # Exported charts and plots
│   └── tables/              # Exported summary tables
├── powerbi/                 # Power BI dashboard file (.pbix)
└── docs/                    # Notes, findings, and documentation
```

---

## Workflow

1. **Load** the raw data and inspect its structure (`R/01_load_data.R`).
2. **Clean** the data: handle missing values, fix data types, remove
   duplicates and outliers (`R/02_clean_data.R`).
3. **Explore** the data through summary statistics and plots (`R/03_eda.R`).
4. **Export** the cleaned dataset to `data/processed/`.
5. **Build** an interactive dashboard in Power BI using the cleaned data.

---

## Project Phases

The project is broken into clear phases, each with its own deliverable.

### Phase 0 — Setup (done)
Create the project structure, initialise the Git repository, and write the
README.
**Deliverable:** a ready-to-use project skeleton.

### Phase 1 — Data Understanding (R)
Load the raw file and get to know it: number of rows and columns, data type of
each column, which columns have missing values, and basic statistics. Nothing
is changed yet — we only observe and take notes on what needs cleaning.
**Deliverable:** a list of data issues to fix in the next phase.

### Phase 2 — Data Cleaning & Pre-processing (R)
The core R work: handle missing values, fix data types (e.g. parse dates),
remove duplicates, review invalid values and outliers, and create helper
columns (such as sale year and month). Save the clean data to
`data/processed/`.
**Deliverable:** a clean CSV file ready for analysis.

### Phase 3 — Exploratory Data Analysis / EDA (R)
Explore the clean data with plots and summaries to find patterns: price
distribution, price vs. distance from the CBD, most expensive suburbs, and so
on. This is where we test our analytical questions against the real data.
**Deliverable:** initial charts and insights that shape the dashboard.

### Phase 4 — Data Modeling in Power BI
Import the clean data into Power BI. Learn core Power BI concepts: building a
Date Table, checking data types in Power Query, and preparing the data model
for calculations.
**Deliverable:** a ready data model in Power BI.

### Phase 5 — Measures & KPIs (DAX)
Build key performance indicators with the DAX language: average price, number
of sales, year-over-year price growth, and more. These power the dashboard's
calculations.
**Deliverable:** a set of reusable measures.

### Phase 6 — Dashboard Design (Visualization)
Arrange the charts, design the layout and colours, and add filters and
interactivity so users can explore the data themselves.
**Deliverable:** an interactive, polished dashboard.

### Phase 7 — Insights & Storytelling
Summarise the main findings in plain language for the target audience
(residents and businesses), document them in `docs/`, and finalise the README.
**Deliverable:** a complete project ready to present on GitHub.

---

## Data Cleaning Decisions

This section documents *why* key cleaning choices were made, not just what was
done. Recording the reasoning keeps the analysis transparent and reproducible.

### Rows with a missing `price` are dropped (not imputed)

About 21.8% of rows (7,610 out of 34,857) have no sale price. Rather than
estimating these values with a model (e.g. linear regression) or filling them
with a statistic (e.g. the mean), these rows are removed. The reasoning:

- **`price` is the target of the analysis.** The whole dashboard exists to
  show what prices actually are — real trends and real suburb comparisons. If
  ~22% of prices were generated by a model, we would be analysing and
  reporting our own estimates rather than the real market. This also risks
  circular reasoning: a model might assume "more rooms means a higher price",
  and then we would "discover" that same relationship in the imputed data.
  Imputing a *helper* column is defensible; imputing the *target* column is
  not.
- **Enough real data remains.** After dropping these rows, roughly 27,247
  records with genuine sale prices remain — more than enough for every
  question in this project. Imputation is worth its risk only when data is
  scarce, which is not the case here.
- **Transparency for a general audience.** This is a descriptive project for
  ordinary readers, not a predictive model. It is important to keep a clear
  line between observed data and estimated data. When a resident sees an
  average price for a suburb, it should be a real figure, not a blend of real
  prices and model guesses.

> Note: In a *predictive* project (one whose goal is to predict price), the
> approach would differ — but even then, real prices are kept to train and
> evaluate the model, never fabricated up front.

### Very sparse columns are kept as-is (not imputed, not dropped)

`building_area` (~61% missing) and `year_built` (~55% missing) are more than
half empty. Imputing them would mean inventing the majority of the column,
and dropping every row that lacks them would throw away over half of otherwise
useful data. Since the project's core questions do not depend on these two
columns, they are kept in the dataset untouched: no rows are removed because of
them, and their gaps are not filled. Any future chart that needs them simply
uses the subset of rows where they are present.

### The `date` column is parsed and verified as day/month/year

The raw `date` column is stored as text in day/month/year format
(e.g. `28/01/2016`). It is converted to a real date type with `dmy()` from
lubridate so that time-based analysis (sorting, extracting year/month, trend
lines) becomes possible.

Because a mixed or ambiguous date format could be parsed incorrectly and
silently, the conversion is verified rather than trusted: the number of missing
dates is counted *before* and *after* the conversion. The two counts are equal,
which confirms that `dmy()` successfully parsed every value and that no rows had
an unexpected format. (Any value that did not match day/month/year would have
become `NA`, increasing the count.) The parsed month values also fall within
the valid 1–12 range, giving further confidence the format is consistent.

---

## Tools

- **R** (tidyverse, skimr, janitor) — data cleaning and exploration
- **Power BI** — interactive dashboard and visualisation
- **Git / GitHub** — version control

---

## How to Reproduce

1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/melbourne-housing-analysis.git
   ```
2. Download `Melbourne_housing_FULL.csv` from Kaggle and place it in `data/raw/`.
3. Open the project in RStudio and run the scripts in `R/` in numbered order.
4. Open the Power BI file in `powerbi/` to view the dashboard.

---

## Author

Created as a hands-on project for learning the full data analysis workflow,
from raw data to an interactive dashboard.
