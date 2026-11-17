# Payfast Transaction Analytics & Forecasting

End-to-end analysis of **26,783** payment stage records (**14,040** unique transactions) from **1 June to 15 August 2024**, built with **Python** (`pandas`, `matplotlib`) and **SQL** (`sqlite3`).

## Project Overview
This project answers seven practical data analyst questions covering transaction volume, card scheme distribution, bank-level performance, settlement latency, 16-day forecasting, dashboard design, and business recommendations.

## Data Cleaning
- **Metadata Extraction:** Parsed `TRANS_NO` and `BANK` from the semi-structured `TRANS_NO_INFO` field.
- **Standardization:** Identified and fixed upstream bank typos—`Bank_green` (220 rows) and `Bank_Yelllow` (26 rows)—to reconcile all records into the 5 expected banks.
- **Stage Deduplication:** Prevented double-counting across `Authorise`, `Settlement`, and `Refund` rows by deduplicating on `TRANS_NO` (including 23 transactions with duplicate `Settlement + Paid` records).
- **Currency Conversion:** Converted `AMOUNT` from cents to South African Rand (ZAR).

## Key Results Summary
| Question | Key Finding |
| :--- | :--- |
| **Q1 (15 Jun – 15 Jul)** | **5,729** unique transactions — VISA (**65.8%**), MasterCard (**27.7%**), AMEX (**4.8%**), Diners Club (**1.7%**) |
| **Q2 (Full Period by Bank)** | **14,040** total unique txns (**R15.58M**); **11,967** successful (`Settlement` + `Paid`, **R12.47M**) across 5 banks |
| **Q3 (Bank Green VISA, Jul)** | **770** unique transactions (**R762,893.00**); **623** successful (**R608,003.00**) |
| **Q4 (Bank Blue, 25 Jul)** | **31** successful transactions averaging **515.68 minutes** (**08:35:41**) due to nightly batch settlement |
| **Q5 (Aug 16 – 31 Forecast)** | **2,994** total and **2,462** successful transactions projected using a Day-of-Week seasonal average model |

## Visual Highlights

### Card Type Distribution (15 Jun – 15 Jul 2024)
[payfast-transaction-analysis/images/q1_card_types.png]
<img width="2371" height="1168" alt="q1_card_types" src="https://github.com/user-attachments/assets/949139f0-0362-482b-8c9f-82c4c2360166" />


### Transaction Value by Bank (All vs. Successful)
<img width="2667" height="1320" alt="q2_bank_amounts" src="https://github.com/user-attachments/assets/1c8c6522-25be-4c28-b3b2-d5e8111d22c9" />


### Daily Volume Forecast (16–31 August 2024)
<img width="3251" height="1320" alt="q5_daily_forecast" src="https://github.com/user-attachments/assets/e09047f1-c526-40d3-8cff-e2f83e7d994b" />


### Hourly Traffic Pattern
<img width="2667" height="1168" alt="q7_hourly_volume" src="https://github.com/user-attachments/assets/4b6ab1d3-ea4b-4dea-a9a5-1838ecf4ca68" />


## Recommended Client Dashboard (Q6)
A **Executive & Operations Dashboard** featuring:
1. **KPI Summary Cards:** Unique transactions, successful transactions, settled ZAR value, approval rate, decline rate, and refund rate.
2. **Volume & Forecast Trend:** Daily total vs. successful volume with a 7-day moving average and rest-of-month forecast.
3. **Conversion Funnel & Failure Diagnostics:** Stage drop-off (`Authorise` → `Approved` → `Settlement` → `Paid`) segmented by `RESULT_CODE`, `BANK`, and `CARD_TYPE`.
4. **Settlement & Data Quality Monitor:** Batch settlement lag tracking and alerts for unclosed stages (`DATE_END` nulls) or duplicate settlements.

## Business Insights & Recommendations (Q7)
- **Peak Traffic Windows:** Weekday volume (208–251/day) is over 2x weekend volume (94–113/day), peaking on Mondays and between 09:00–12:00, maintenance windows should run between 00:00–05:00.
- **Card Scheme Conversion:** American Express converts at **98.62%**, whereas MasterCard has the highest decline rate (**14.39%**) and Diners Club has the highest refund rate (**8.74%**).
- Enforce bank-name validation at ingestion and audit the **392** `Not Done` authorisations and **23** duplicate settlement records.

## Repository Structure
- `payfast_analysis.ipynb`- Full step-by-step Python & SQLite analysis notebook
- `payfast-transaction-analysis/images/`- Exported matplotlib charts
- `payfast-transaction-analysis/sql/queries.sql` — Verified SQL queries for Q1–Q4
- `requirements.txt` — Python dependencies
- `README.md` — Project overview and findings

## How to Run
1. Install dependencies: `pip install -r requirements.txt`
2. Open the notebook: `jupyter notebook payfast_analysis.ipynb`
