# 🍕 Pizza Sales SQL Project

## 📌 Project Overview
This SQL project explores a pizza sales database to understand customer behavior, revenue, and ordering trends.

---

## 🎯 Objectives
- Set up the pizza sales database tables.  
- Clean and explore the data with SQL.  
- Answer business questions such as top‑selling pizzas, peak hours, and revenue share.  
- Practice SQL skills: `JOIN`, `GROUP BY`, window functions, date‑time functions.

---

## 🗂️ Database Structure
| Table | Purpose |
|-------|---------|
| **pizzas** | Pizza ID, size, price |
| **pizza_types** | Pizza name, category, ingredients |
| **orders** | Order ID, date, time |
| **order_details** | Quantity of each pizza per order |

```sql
-- example table
CREATE TABLE pizzas (
  pizza_id TEXT,
  pizza_type_id TEXT,
  size TEXT,
  price FLOAT
);
```

---

## 📊 Key SQL Queries

| Level | Example Questions |
|-------|-------------------|
| ✅ Basic | Total number of orders, highest‑priced pizza |
| 📈 Intermediate | Orders by hour, category‑wise quantity |
| 💡 Advanced | Revenue share by pizza type, cumulative daily revenue |

Example query (total revenue):
```sql
SELECT SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p ON p.pizza_id = od.pizaa_id;
```

---

## 🔍 Insights
- **Most popular size:** quickly identified with an aggregate query.  
- **Top 3 pizza types** generate the bulk of revenue.  
- Sales **peak around specific hours**, useful for staffing.  
- Category analysis shows where to expand the menu.

---

## ✅ How to Run
1. Create tables in pgAdmin using the SQL scripts.  
2. Import CSV data or insert sample rows.  
3. Run the analysis queries from `analysis_queries.sql`.  
4. Modify queries or add new ones to dig deeper.

---

## 🏁 Conclusion
A fun, hands‑on project for learning SQL. You’ll practice real business analytics with joins, aggregations, and window functions while answering questions about pizza sales.

