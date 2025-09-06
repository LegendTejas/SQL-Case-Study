# 🏦 Banking Fraud Detection & Customer Analytics

## 📌 Case Study
**Case:** Real-Time Fraud Detection and Customer Analytics in a Banking System  

### Scenario
A bank wants to **detect fraudulent transactions** and **analyze customer spending behavior** using a well-normalized database.  
The system must handle millions of transactions efficiently while identifying **suspicious patterns** based on customer behavior and transaction history.

---

## 🔑 Functional & Multivalued Dependencies
- `CustomerID → CustomerName` (Each customer has a unique name)  
- `AccountID → CustomerID` (Each account belongs to one customer)  
- `TransactionID → AccountID, Amount, Merchant, Category, Status` (Each transaction has unique details)  
- `Location, Merchant` are **multivalued** (a merchant can exist in multiple locations).  

---

## 🗄️ Normalized Schema
The database is divided into three tables:  
- **Customers** → Stores customer details  
- **Accounts** → Each account is linked to a customer  
- **Transactions** → Stores all transaction records with metadata  

👉 See [`schema.sql`](./schema.sql) for table creation scripts.  

---

## 📊 Problem Statements & Solutions

### 1️⃣ Detecting Suspicious Transactions Using Window Functions
Find transactions where the amount is significantly higher than the customer’s average transaction value in the past month.  

### 2️⃣ Customer Spending Trend – Rolling 7-Day Average
Calculate a **7-day moving average** for customer spending.  

### 3️⃣ Ranking High-Spending Customers
Identify the **top 5% of customers** based on their total transaction value.  

### 4️⃣ Time-Based Fraud Detection – Unusual Location Changes
Detect transactions where a customer made purchases in **different locations within 1 hour**.  

👉 See [`queries.sql`](./queries.sql) for complete SQL solutions.  

---

## 🛠️ Technologies Used
- **Database:** MySQL  
- **Concepts:** Normalization, Window Functions, Aggregations, Ranking, Fraud Detection Patterns  

---

## 📂 Files in This Folder
- `schema.sql` → Database schema (Customers, Accounts, Transactions)  
- `queries.sql` → SQL queries for solving the case study problems  
- `README.md` → Explanation of case study & problem breakdown  

---

## 🎯 Learning Outcomes
- Designing **normalized schemas** for real-world systems  
- Using **SQL window functions** for anomaly detection  
- Applying **ranking & aggregation** for analytics  
- Detecting **fraudulent transaction patterns**  

---
