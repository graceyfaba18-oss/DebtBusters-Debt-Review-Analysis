DebtBusters South Africa
SA Consumer Credit and Debt Review Analysis
Author: Gracey F.
Tools: SQL (SQLite) | Microsoft Excel | DB Browser for SQLite
Data Source: National Credit Regulator (NCR) — Consumer Credit Market Reports Q4 2019 to Q4 2024
Source URL: https://www.ncr.org.za
---

DebtBusters is South Africa's largest debt counselling company. The business operates under the National Credit Act 34 of 2005, which created a formal debt review process allowing over-indebted consumers to restructure their debt obligations under the supervision of a registered debt counsellor.
I work as a Financial Assessor in the DebtBusters Onboarding team. My daily work involves assessing client income and expenditure, calculating debt ratios, and preparing legal proposals for restructured repayment plans. This project analyses the macro environment that drives demand for DebtBusters' services using real publicly available data from the NCR — the regulatory body that oversees all credit and debt counselling activity in South Africa.
---
What This Project Analyses
This project answers 10 real business questions using SQL queries and an Excel dashboard:
Market Overview
How has total consumer credit outstanding grown from 2019 to 2024?
What percentage of South African consumers hold defaulted accounts?
How did COVID-19 affect new credit granted in 2020?
Debt Review Trends
How has the volume of debt review applications grown over time?
What is the approval versus rejection rate per quarter?
What is the year-on-year growth in new debt review applications?
How many consumers successfully exited debt review?
Defaulted Accounts Analysis
Which credit type carries the highest default rate?
How many South Africans are financially strained across all credit types?
Combined market health snapshot across three years
---
Key Findings
As of Q4 2024, South Africa's total consumer credit outstanding stood at R2 418.5 billion across approximately 29 million credit-active consumers. Over 10.7 million of those consumers — representing 36.8% of all credit-active individuals — held defaulted accounts.
Debt review applications have grown consistently since 2021, reaching 57 100 new applications in Q4 2024 alone. The total number of consumers under formal debt review reached 483 500 by the end of 2024, up from approximately 248 300 in Q4 2019. This represents a 95% increase over five years, driven by rising household debt burdens and sustained economic pressure on South African consumers.
Retail accounts and personal loans show the highest impairment rates at 43.0% and 41.0% respectively — meaning nearly half of all consumers with personal loan or retail credit obligations are in arrears. This directly explains the volume of unsecured debt cases handled by DebtBusters' Financial Assessors on a daily basis.
The COVID-19 lockdown period in Q2 2020 caused a sharp 42% decline in new credit granted compared to Q1 2020, followed by a strong recovery from 2021 onward.
---
Project Structure
```
project1_debtbusters/
│
├── data/
│   ├── debtbusters_ncr.db          — SQLite database (3 tables, 21 quarters of data)
│   ├── ncr_credit_market.csv       — Credit market summary data
│   ├── ncr_debt_review.csv         — Debt review applications data
│   └── ncr_impaired_accounts.csv   — Impaired accounts by credit type
│
├── sql/
│   └── debtbusters_queries.sql     — 10 business intelligence SQL queries
│
├── excel/
│   └── DebtBusters_NCR_Dashboard.xlsx  — 4-sheet Excel dashboard
│
└── README.md
```
---
Database Schema
Table 1: credit_market_summary
Quarterly consumer credit market figures published by the NCR.
Column	Description
quarter	Reporting quarter (e.g. Q4 2024)
year	Calendar year
total_credit_outstanding_bn	Total credit outstanding in R billions
total_credit_active_consumers	Number of consumers with active credit
impaired_accounts_count	Number of consumers with impaired records
impaired_accounts_pct	Impairment rate as a percentage
new_credit_granted_bn	New credit granted that quarter in R billions
number_of_credit_providers	Registered credit providers
Table 2: debt_review_applications
Quarterly debt review statistics published by the NCR.
Column	Description
quarter	Reporting quarter
new_applications	New debt review applications lodged
total_under_debt_review	Total consumers currently under debt review
applications_granted	Applications approved by the court
applications_rejected	Applications rejected
rescissions_granted	Debt review orders rescinded (successful exits)
registered_debt_counsellors	Active registered debt counsellors
Table 3: impaired_by_credit_type
Impairment breakdown by credit type for Q4 2024.
Column	Description
credit_type	Mortgage, Vehicle Finance, Credit Cards, Personal Loans, Retail Accounts, Other
total_accounts	Total accounts in that category
impaired_count	Number of impaired accounts
impaired_pct	Impairment rate percentage
---
Excel Dashboard Sheets
Sheet	Contents
Dashboard	KPI summary cards, credit market by year table, debt review by year table, two charts
Debt Review Trends	Full quarterly debt review data with approval rate formula, line chart
Impairment Analysis	Impairment by credit type with conditional formatting, bar chart
Raw Data — NCR	Full quarterly credit market raw data for reference
---
How to Open and Run the SQL Queries
Download and install DB Browser for SQLite (free):
`https://sqlitebrowser.org/dl/`
Open DB Browser for SQLite
Click Open Database and select the file:
`data/debtbusters_ncr.db`
Click the Execute SQL tab at the top
Open the file `sql/debtbusters_queries.sql` in Notepad
Copy any query from that file and paste it into the SQL editor in DB Browser
Click the Play button (or press F5) to run the query
Results appear in the panel below the editor
---
Data Source and Citation
National Credit Regulator (NCR). Consumer Credit Market Report Q4 2024. Pretoria: NCR, 2025. Available at: https://www.ncr.org.za/documents/CCMR/
All figures in this project are drawn from NCR quarterly Consumer Credit Market Reports published between Q4 2019 and Q4 2024. The NCR is the statutory body established under the National Credit Act 34 of 2005 to regulate the South African credit industry.
---
This project is part of the Gracey F. Data Analytics Portfolio.
View full portfolio: https://github.com/gracey-faba/DATA-ANALYST-PORTFOLIO
