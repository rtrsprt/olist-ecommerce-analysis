-- Количество заказов
select count(order_id) as total_orders
from olist.orders
--99441
______________________________________
-- Количество уникальных заказчиков
select count(distinct customer_unique_id) as total_customers
from olist.customers
--96096
______________________________________
-- Общая выручка
select sum(price) as total_revenue
from olist.order_items
--13591643.70
______________________________________
-- Средний чек
select round((sum(price) / nullif(count(distinct order_id),0)::numeric),2) as AOV
from olist.order_items
-- 137.75
______________________________________
-- Выручка по месяцам 
select date_trunc('month', o.order_purchase_timestamp) as month,
       sum(oi.price) as revenue
from olist.orders o
join olist.order_items oi using(order_id)
group by date_trunc('month', o.order_purchase_timestamp)
order by month  
