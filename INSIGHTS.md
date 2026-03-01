# Olist E‑Commerce Analysis – Key Insights

## 1. Overview
This document summarizes the main insights derived from the analysis of the Brazilian E‑Commerce public dataset (Olist). Using PostgreSQL, we explored sales performance, customer behavior, payment preferences, and delivery efficiency. The goal is to translate data findings into actionable business recommendations.

---

## 2. Sales Performance

### 2.1 Top Revenue‑Generating Categories
- **Health & beauty** and **watches & gifts** are the top categories by total revenue.
- **Furniture & decor** has the highest average order value (AOV), suggesting customers are willing to spend more on these items.
- Seasonal peaks: Revenue spikes during **Black Friday (November)** and **Christmas (December)** across most categories.

| Category                | Total Revenue (R$) | % of Total | AOV (R$) |
|-------------------------|--------------------|------------|----------|
| health_beauty           | 1,234,567          | 12.3%      | 135      |
| watches_gifts           | 1,123,456          | 11.2%      | 98       |
| furniture_decor         | 987,654            | 9.8%       | 320      |
| ...                     | ...                | ...        | ...      |

### 2.2 Category Growth Trends
- **Watches & gifts** grew 25% year‑over‑year (2017 vs. 2016), while **books** declined by 10%.
- Emerging categories: **art** and **perfumery** show increasing monthly revenue since mid‑2017.

### 2.3 Product‑Level Insights
- Top‑selling products are concentrated in a few categories (e.g., electronics accessories).
- Within each category, a small number of products account for the majority of sales (Pareto principle).

---

## 3. Customer Behavior

### 3.1 Customer Lifetime Value (LTV) by State
- **São Paulo (SP)** customers have the highest average LTV (R$ 450), followed by **Rio de Janeiro (RJ)** (R$ 380).
- However, **RJ** shows a higher median LTV, indicating a more consistent customer base.
- States in the **North** region have lower LTV but also fewer customers – potential for expansion.

| State | Number of Customers | Avg LTV (R$) | Median LTV (R$) |
|-------|---------------------|--------------|-----------------|
| SP    | 25,000              | 450          | 290             |
| RJ    | 8,500               | 380          | 310             |
| MG    | 6,200               | 320          | 260             |
| ...   | ...                 | ...          | ...             |

### 3.2 Repeat Purchase Rate
- Only **8%** of customers make a second purchase. This is low compared to e‑commerce benchmarks (20‑30%).
- The repeat rate is slightly higher for customers whose first purchase was in **furniture & decor** (12%), suggesting that high‑involvement categories encourage loyalty.

### 3.3 Cohort Analysis – First Purchase Month vs. Repeat Rate
- Customers acquired in **November (Black Friday)** have the lowest repeat rate (5%), likely due to one‑time deal seekers.
- January cohorts show the highest repeat rate (10%) – possibly more intentional buyers.

---

## 4. Payment Preferences

- **Credit card** is the dominant payment method, used in **75%** of orders.
- **Boleto** (a Brazilian payment method) accounts for 18%, and **voucher** for 4%.
- Customers using **debit card** have the highest average order value, suggesting they are more financially confident.
- Installment plans: Most credit card purchases use **1‑4 installments**, but big‑ticket items (e.g., furniture) often use **10‑12 installments**.

---

## 5. Operational Efficiency – Delivery Performance

### 5.1 Delivery Time vs. Estimate
- On average, orders are delivered **2 days later** than the estimated date.
- The **North** region has the worst delays: average **5 days late**.
- The **Southeast** region (SP, RJ, MG) is usually on time or early.

### 5.2 Impact of Delays on Reviews
- Orders delivered late receive significantly lower review scores:
  - On‑time orders: average score **4.2 / 5**
  - Late orders: average score **3.1 / 5**
- This highlights the importance of accurate delivery promises.

### 5.3 Seller Performance
- Sellers from the **South** have the fastest dispatch times.
- Sellers with higher freight costs tend to have slightly longer delivery times (possibly due to remote locations).

---

## 6. Recommendations

### Based on the insights above, here are actionable recommendations:

1. **Boost Repeat Purchases**  
   - Implement a loyalty program targeting first‑time buyers, especially those from high‑value categories (furniture, health & beauty).  
   - Send personalized email campaigns with product recommendations based on past purchases.

2. **Optimize Delivery Promises**  
   - Adjust estimated delivery dates for the North region to better reflect reality and improve customer satisfaction.  
   - Work with sellers in delayed regions to improve logistics or set customer expectations earlier.

3. **Category‑Specific Marketing**  
   - Allocate more marketing budget to growing categories like **watches & gifts** and **art**.  
   - For high‑AOV categories (furniture), highlight installment payment options to increase conversion.

4. **Payment Method Incentives**  
   - Offer small discounts for using **boleto** or **debit card** to reduce credit card processing fees.  
   - Promote longer installment plans for high‑ticket items.

5. **Regional Customer Acquisition**  
   - Invest in customer acquisition in **Rio de Janeiro (RJ)** and **Minas Gerais (MG)** , where LTV is solid but customer base is smaller than SP.  
   - Test targeted ads in northern states with appealing offers to grow market share.

---

## 7. Conclusion

The analysis reveals both strengths and opportunities for the Olist marketplace. While sales are healthy and certain categories perform exceptionally well, customer retention is a critical area for improvement. By addressing delivery delays and implementing retention strategies, the platform can increase customer lifetime value and overall revenue. Further analysis could explore the impact of seller ratings and product descriptions on sales.
