<div align="center">

# 📊 Power BI Dashboard

**The presentation layer of the project — a three-page interactive report built on the cleaned R output.**

Measures in **DAX** · Styling via **theme files** · Three pages, one shared filter context

[![Power BI](https://img.shields.io/badge/Power%20BI-Desktop-F2C811?logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![DAX](https://img.shields.io/badge/DAX-20%2B%20measures-1F3864)](https://learn.microsoft.com/en-us/dax/)
[![Themes](https://img.shields.io/badge/themes-3%20variants-6366F1)](#-files-in-this-folder)
![Status](https://img.shields.io/badge/status-in%20progress-yellow)

</div>

---

## 📑 Contents

- [Files in this folder](#-files-in-this-folder)
- [The DAX library](#-the-dax-library)
- [Setup order](#-setup-order)
- [Fixes to the current report](#-fixes-to-the-current-report)
- [Page 1 — Market Overview](#-page-1--market-overview)
- [Page 2 — Suburb Explorer](#-page-2--suburb-explorer)
- [Page 3 — Price Drivers](#-page-3--price-drivers)
- [Design rules](#-design-rules)
- [Verification numbers](#-verification-numbers)

---

## 📁 Files in this folder

| File | Purpose |
|------|---------|
| `measures.dax` | The DAX library — every calculation the report depends on. |
| `melbourne_theme.json` | **Light · blue** — clean and corporate, neutral background. |
| `melbourne_theme_dark.json` | **Dark · navy** — bright blue accent, centred card headers. |
| `melbourne_theme_violet.json` | **Light · violet** — monochrome palette, tinted card borders. |
| `README.md` | This build specification. |

Themes are applied via **View → Themes → Browse for themes**. All three work with
the same measures, so you can switch freely without rebuilding anything.

---

## 🧮 The DAX library

<details open>
<summary><strong>What it is</strong></summary>

<br>

`measures.dax` is a plain text file containing every calculation this report
needs, written in **DAX** (Data Analysis Expressions) — the formula language
Power BI uses. It is not something Power BI imports directly; it is a
**reference library** you copy from, organised into eight numbered sections.

It defines three different kinds of object, and each has its own home in Power BI:

| Section | Object type | Where it goes | What it does |
|:---:|---|---|---|
| 1 | Calculated columns | `Modeling → New column` | Adds a column to every row, computed once when the data loads. |
| 2 | Calculated table | `Modeling → New table` | Builds the date table used by all time-based calculations. |
| 3–8 | Measures | `Home → New measure` | Formulas evaluated **live**, recalculating whenever a filter changes. |

> ⚠️ Getting these confused is the most common mistake — pasting a measure into
> `New column` will throw an error.

</details>

<details>
<summary><strong>Why the report needs it</strong></summary>

<br>

**Because a dashboard without measures is just a table.** Dragging a raw `price`
field onto a chart makes Power BI guess an aggregation, and its default guess is
`Sum`. That is exactly how the original line chart ended up plotting total
transaction value while being labelled as price. Measures replace guesswork with
an explicit, named, reusable definition: `Median Price` means one thing, is
written once, and behaves identically in every visual on every page.

**Because interactivity depends on it.** A measure is not a stored number — it is
a rule that re-runs against whatever the user has filtered. When a reader clicks
"Unit / Apartment", `Median Price` recalculates for units alone, and so does every
chart bound to it. This is what makes one chart answer many questions instead of
needing a separate chart per combination.

**Because the analysis needs concepts the raw data does not contain.** The source
data has no column for "how this suburb compares to the market", "growth since
last year", or "is this sample large enough to trust". Those are analytical ideas,
and DAX is where they get defined.

</details>

<details>
<summary><strong>How it helps, section by section</strong></summary>

<br>

**Sections 1–2 · the foundation.** `Property Type` turns the cryptic `h`/`t`/`u`
codes into labels a reader understands. `Distance Band` and `Price Band` convert
continuous numbers into readable buckets, each with a companion *Sort* column so
axes appear in logical rather than alphabetical order. The date table gives every
day in the period a row, including days with no sales, which is what stops time
charts from developing gaps — and it is a hard requirement for Section 5.

**Section 3 · the vocabulary.** `Median Price`, `Total Sales`, `Suburb Count`, and
`Total Market Value`. Everything else is built from these. `Median Price` is
deliberately a median rather than an average: the price distribution is
right-skewed (median $870K against a mean of $1.05M), so an average describes a
property that barely exists.

**Section 4 · asking the right question.** `% Share of Sales` and
`% Share of Market Value` look similar but answer different things: houses are
67.8% of transactions and 77.7% of money. Having both named separately makes it
much harder to accidentally label one as the other.

**Section 5 · change over time.** `Median Price YoY %` and `Median Price 4Q Avg`
turn a snapshot into a trend. The moving average matters here because the first
and last quarters of this dataset are incomplete, and raw quarter-to-quarter
figures wobble accordingly.

**Section 6 · the actual analysis.** This is where the report stops describing and
starts explaining. `Median Price per Room` normalises for size so suburbs with
different housing stock become comparable. `House vs Unit Premium` quantifies the
gap between the two markets. `Suburb Price Rank` and `Price vs Market %` place
each suburb against every other and against the city as a whole.

**Section 7 · honesty guards.** `Median Price (Reliable)` blanks out any suburb
with fewer than 30 sales, and `Sample Size Warning` says so in plain language.
Without this, a suburb with three recorded sales can top the "most expensive"
chart on the strength of a single mansion. Excluding thin samples from rankings
and flagging them in tables is the difference between a report that *looks*
confident and one that *is* trustworthy.

**Section 8 · writing that updates itself.** `Title — Price Trend` rewrites a
chart's heading to name whatever the user has filtered to, and
`Insight — Market Direction` produces a full sentence of interpretation that
changes with the data. The reader gets a written takeaway, not just a shape.

</details>

<details>
<summary><strong>One place, not fifteen</strong></summary>

<br>

The practical payoff is maintenance. If the definition of a headline figure ever
changes, it changes in one measure and every visual across all three pages
updates at once. Calculations buried in individual charts have to be found and
fixed one at a time — and the ones that get missed are how dashboards start
contradicting themselves.

</details>

---

## 🚀 Setup order

Follow this order — later steps depend on earlier ones.

| # | Step | Where |
|:-:|------|-------|
| 1 | **Apply a theme** | View → Themes → Browse for themes |
| 2 | **Create the calculated columns** (Section 1), including both *Sort* columns | Modeling → New column |
| 3 | **Set the sort order**: `Distance Band` → sort by `Distance Band Sort`; same for `Price Band` | Column tools → Sort by column |
| 4 | **Create the date table** (Section 2), mark it as a date table, relate `DateTable[Date]` → `melbourne_housing_clean[date]` | Modeling → New table, then Model view |
| 5 | **Create the measures** (Sections 3–8) | Home → New measure |
| 6 | **Build the pages** as specified below | Report view |

> **How to paste:** open `measures.dax` in any text editor. For each block, click
> the matching button in Power BI, clear the default text in the formula bar, then
> paste the **whole block including the name and the `=` sign**. Lines beginning
> with `//` are comments; Power BI ignores them, so they can be pasted along with
> the formula and are worth keeping as documentation.
>
> If your Power BI Desktop has **DAX query view**, measures can be added in bulk
> there with `DEFINE MEASURE` blocks — but calculated columns and the date table
> still have to be created from the Modeling menu.

---

## 🔧 Fixes to the current report

Two visuals currently measure the wrong thing. These are **analytical errors, not
cosmetic ones**, and should be fixed before adding anything new.

<details open>
<summary><strong>🚨 The line chart shows transaction volume, not price</strong></summary>

<br>

It is bound to `Sum of price`. Summing price across a quarter mostly measures
**how many properties sold**, not what they cost:

| Correlation of `Sum(price)` with… | Value |
|---|:---:|
| number of sales | **0.998** |
| median price | **−0.439** |

The consequence is visible in the data: 2017 Q1 had the **highest** median price
of the whole period ($940K), but the current chart shows a **sharp dip** there,
purely because fewer sales were recorded that quarter. The chart tells the
opposite of the truth.

**Fix:** replace the Y-axis field with the `Median Price` measure.

</details>

<details>
<summary><strong>⚠️ The column chart's title does not match its measure</strong></summary>

<br>

It is bound to `%GT Sum of price` — share of total **value** — but titled
*"Share of sales by property type"*. Those are different questions:

| Property type | Share of **sales** | Share of **value** |
|---|---:|---:|
| House | 67.8% | 77.7% |
| Unit / Apartment | 21.7% | 13.0% |
| Townhouse | 10.5% | 9.3% |

**Fix:** either bind it to `% Share of Sales` and keep the title, or keep the
value measure and retitle it *"Houses account for 78% of total market value"*.
Both are valid — they must simply agree.

</details>

<details>
<summary><strong>Smaller corrections</strong></summary>

<br>

- Two KPI cards show the same figure (`Count of address` ≈ `Total sale` ≈ 27,247).
  Drop one; use `Suburb Count` instead.
- Card display units read `27.247K`. Set **Display units → None** and
  **Value decimal places → 0** so it reads `27,247`.
- The bar chart still uses the raw `type` field (`h`, `u`, `t`). Swap in
  `Property Type`.
- Slicer headers are inconsistently cased (`Property Type`, `date`, `rooms`,
  `suburb`). Standardise to: `Property type`, `Date range`, `Rooms`, `Suburb`.

</details>

---

## 📄 Page 1 — Market Overview

> 💭 **The question this page answers:** what is the market doing overall?

### Header band
A shape across the top with **Melbourne Housing Market**, the subtitle
*January 2016 – March 2018 · 27,247 recorded sales*, and a **Page navigator**
(`Insert → Buttons → Navigator`) aligned right.

### Slicers

| Field | Style |
|---|---|
| `Property Type` | Tile |
| `date` | Between (range slider) |
| `region_name` | Dropdown |
| `rooms` | Dropdown |

> Turn on **View → Sync slicers** and enable *Sync* + *Visible* for all three
> pages, so a filter set here survives when the reader navigates away.

### KPI cards

| Measure | Format |
|---|---|
| `Median Price` | Display units: None, 0 decimals |
| `Average Price` | Display units: None, 0 decimals |
| `Total Sales` | Display units: None, 0 decimals |
| `Suburb Count` | Whole number |
| `Median Price YoY %` | Percentage, 1 decimal |

> Keeping median and average side by side is deliberate: the gap between $870K
> and $1.05M is itself the insight — it shows a minority of very expensive
> properties pulling the average up.

### Visuals

| # | Visual | Fields | Title |
|:-:|--------|--------|-------|
| 1 | **Line chart** (large, left) | X: `DateTable[Year-Quarter]` · Y: `Median Price` · Legend: `Property Type` | Bind to `Title — Price Trend` |
| 2 | **Donut chart** (right) | Legend: `Property Type` · Values: `Total Sales` | `Houses are two in three sales` |
| 3 | **Clustered bar** (bottom left) | Y: `region_name` · X: `Median Price` | `Southern Metro leads on price` |
| 4 | **Card (text)** (bottom right) | `Insight — Market Direction` | *(no title)* |

**On visual 1 —** the three-line split is the point of this page. Houses fell from
a $1,101K to a $933K median while units rose from $546K to $606K — a divergence
that a single averaged line completely hides.

**On visual 1's axis —** use quarters, not years. The dataset starts in late
January 2016 and ends mid-March 2018, so both end years are partial; a
three-point yearly line exaggerates the final drop.

---

## 📄 Page 2 — Suburb Explorer

> 💭 **The question this page answers:** where can I afford to buy?

### Slicers
Same four as Page 1, plus a `Price Band` slicer.

### Visuals

| # | Visual | Fields | Notes |
|:-:|--------|--------|-------|
| 1 | **Map** (large) | Lat: `latitude` · Long: `longitude` · Size: `Total Sales` · Saturation: `Median Price (Reliable)` | Melbourne-wide view |
| 2 | **Bar chart — top 10** | Y: `suburb` · X: `Median Price (Reliable)` · Top-N filter: 10 | `Most expensive suburbs` |
| 3 | **Bar chart — bottom 10** | Same, Bottom-N 10 | `Most affordable suburbs` |
| 4 | **Table** | `suburb`, `Median Price`, `Total Sales`, `Suburb Price Rank`, `Price vs Market %`, `Sample Size Warning` | Conditional-format `Price vs Market %` red → green |

> **Why `Median Price (Reliable)` and not `Median Price` on the ranked charts:**
> it blanks out suburbs with fewer than 30 sales. Without that guard, a suburb
> with three recorded sales can top the "most expensive" chart on the strength of
> one mansion. Excluding thin samples from rankings — and flagging them in the
> table via `Sample Size Warning` — is what separates a report that looks
> confident from one that *is* trustworthy.

---

## 📄 Page 3 — Price Drivers

> 💭 **The question this page answers:** what actually drives the price?

### Visuals

| # | Visual | Fields | Title |
|:-:|--------|--------|-------|
| 1 | **Column chart** | X: `Distance Band` · Y: `Median Price` · Legend: `Property Type` | `Price falls with distance — but not evenly` |
| 2 | **Column chart** | X: `rooms` (filter 1–6) · Y: `Median Price` | `Each extra room adds roughly $200K` |
| 3 | **Scatter chart** | X: `distance` · Y: `Median Price` · Legend: `Property Type` · Details: `suburb` · Size: `Total Sales` | `Suburbs by price and distance` |
| 4 | **100% stacked bar** | Y: `region_name` · X: `Total Sales` · Legend: `Price Band` | `Every region has a different price mix` |
| 5 | **Card (text)** | `House vs Unit Premium` | `House premium over units` |

**On visual 1 —** the relationship is stepped rather than linear. The 0–5 km and
5–10 km bands are close to each other; the real fall begins after 10 km. Adding
`Property Type` as a legend shows whether that pattern holds for units as well
as houses — the kind of two-dimensional question a single chart cannot answer.

**On visual 3 —** the scatter is the analytical centrepiece. Suburbs sitting well
*below* the general price/distance trend are the value opportunities: close to
the city but cheaper than their distance would predict.

**On visual 4 —** a median hides distribution. Two regions can share a median and
have completely different markets; this chart shows the mix behind the number.

---

## 🎨 Design rules

Applying these consistently is most of what makes a report look professional.

<details open>
<summary><strong>The six rules</strong></summary>

<br>

**Typography.** The themes set Segoe UI throughout. Decorative italic serif faces
read as invitations, not analysis. Never override this per-visual.

**Colour carries meaning.** Each theme assigns a fixed colour to each property
type, and those assignments must hold on every page. A reader who learns
"blue = house" on page 1 should not have to relearn it on page 3. Everything that
is *not* a property type stays neutral, so colour always signals something.

**Titles are sentences, not labels.** *"House prices fell while unit prices rose"*
does the reader's work for them; *"Median price by type"* makes them do it
themselves. Where the answer changes with the filters, use the dynamic title
measures in Section 8.

**Alignment.** Select visuals together → Format → Align → Distribute. Misaligned
edges are the single most common tell of an amateur report.

**Whitespace.** Resist filling every pixel — but do not leave a chart floating in
a large empty area either. Either grow the visual or add one that earns the space.

**State the limits.** Put a small footnote on Page 1: *"2016 and 2018 are partial
years. Suburb figures based on fewer than 30 sales are excluded from rankings."*
Naming a limitation builds more trust than hiding it.

</details>

---

## ✅ Verification numbers

After building, check these against the **unfiltered** report. A mismatch means
something is bound incorrectly.

| Measure | Expected |
|---|---:|
| `Total Sales` | 27,247 |
| `Median Price` | $870,000 |
| `Average Price` | $1,050,173 |
| `Suburb Count` | 345 |
| `Min Price` / `Max Price` | $85,000 / $11,200,000 |

<details>
<summary><strong>Median price by property type</strong></summary>

<br>

| Type | Median |
|---|---:|
| House | $1,015,000 |
| Townhouse | $850,000 |
| Unit / Apartment | $580,000 |

</details>

<details open>
<summary><strong>Median price by quarter — the line chart check</strong></summary>

<br>

| Quarter | Median | Sales |
|---|---:|---:|
| 2016 Q2 | $850,000 | 2,530 |
| 2016 Q4 | $910,500 | 2,857 |
| 2017 Q1 | $940,000 | 1,367 |
| 2017 Q3 | $850,000 | 5,272 |
| 2018 Q1 | $836,500 | 3,674 |

> 🚩 If your line chart **dips** at 2017 Q1, it is still bound to a sum. That
> quarter has the **highest** median of the entire period and the **fewest** sales.

</details>
