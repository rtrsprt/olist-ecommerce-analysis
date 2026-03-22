-- Среднее время доставки 
select avg(order_delivered_customer_date - order_purchase_timestamp) as avg_delivered_time
from olist.orders
where order_status = 'delivered' 
and order_delivered_customer_date is not null
-- 12 дней 13 часов 23 минуты
__________________________________________
