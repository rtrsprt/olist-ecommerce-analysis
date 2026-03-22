-- Выручка по статусу заказа
select o.order_status,
       sum(oi.price) as revenue
from olist.orders o
join olist.order_items oi using(order_id)
group by o.order_status
order by revenue desc
________________________________________
-- Выручка по категории 
select pt.product_category_name_english as category_name,
       sum(oi.price) as revenue
from olist.products p
join olist.order_items oi using(product_id)
join olist.product_category_name_translation pt using(product_category_name)
group by pt.product_category_name_english
order by revenue desc
________________________________________
-- Выручка по штату продавца
select s.seller_state,
       sum(oi.price) as revenue
from olist.sellers s
join olist.order_items oi using(seller_id)
group by s.seller_state
order by revenue desc
________________________________________
-- Топ 10 категорий по выручке
select pt.product_category_name_english as category_name,
       sum(oi.price) as revenue
from olist.products p
join olist.order_items oi using(product_id)
join olist.product_category_name_translation pt using(product_category_name)
group by pt.product_category_name_english
order by revenue desc
limit 10
________________________________________
-- Топ 10 продавцов по выручке
select s.seller_id,
       sum(oi.price) as revenue
from olist.sellers s
join olist.order_items oi using(seller_id)
group by s.seller_id
order by revenue desc
limit 10
