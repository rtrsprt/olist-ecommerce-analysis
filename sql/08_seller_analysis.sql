-- Выручка по продавцам 
select seller_id,
       sum(price) as revenue
from olist.order_items
group by seller_id
order by revenue desc
________________________________
-- Топ продавцов по количеству заказов
select seller_id,
       count( distinct order_id) as total_orders
from olist.order_items
group by seller_id
order by total_orders desc
________________________________
-- Средняя выручка по продавцам
with revenue_per_seller as (
   select seller_id,
          sum(price) as revenue
	from olist.order_items
	group by seller_id
)
select round(avg(revenue),2) as avg_revenue
from revenue_per_seller
-- 4391.48
________________________________
-- Распределение продавцов по штатам 
select seller_state,
       count(seller_id) as sellers
from olist.sellers
group by seller_state
order by sellers desc
________________________________
-- Средний доход с одного заказа на одного продавца
with revenue_sellers as (
   select seller_id,
          sum(price) as revenue
	from olist.order_items
	group by seller_id
),
order_sellers as (
   select seller_id,
          count(distinct order_id) as orders
	from olist.order_items
	group by seller_id
)
select r.seller_id,
       round((r.revenue / nullif(o.orders,0)::numeric),2) as avg_revenue_per_order
from revenue_sellers r
join order_sellers o using(seller_id)
order by avg_revenue_per_order desc
