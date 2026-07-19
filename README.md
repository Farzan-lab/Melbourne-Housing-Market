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
