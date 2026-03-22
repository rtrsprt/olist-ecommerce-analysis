-- Средняя цена по категориям
select pt.product_category_name_english,
       round(avg(oi.price),2) as avg_price
from olist.order_items oi
join olist.products p using(product_id)
join olist.product_category_name_translation pt  using(product_category_name)
group by pt.product_category_name_english
order by avg_price desc
____________________________________________
-- Количество проданных товаров по категориям
select pt.product_category_name_english,
	   count(order_item_id) as sold_items
from olist.order_items oi
join olist.products p using(product_id)
join olist.product_category_name_translation pt  using(product_category_name)
group by pt.product_category_name_english
order by sold_items desc
____________________________________________
-- Топ 10 проданных товаров по категориям 
select pt.product_category_name_english,
	   count(order_item_id) as sold_items
from olist.order_items oi
join olist.products p using(product_id)
join olist.product_category_name_translation pt  using(product_category_name)
group by pt.product_category_name_english
order by sold_items desc
limit 10
____________________________________________
-- Среднее количество товаров в заказе
with item_per_orders as (
   select order_id,
          count(order_item_id) as items
	from olist.order_items
	group by order_id		 
)
select round(avg(items),2) as avg_item_per_order
from item_per_orders
-- 1.14
