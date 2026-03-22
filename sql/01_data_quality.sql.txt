-- Проверка на уникальность primary key в olist.customers
select customer_id, count(*)
from olist.customers
group by customer_id
having count(*) > 1
-- Проверка на уникальность primary key в olist.orders
select order_id, count(*)
from olist.orders
group by order_id
having count(distinct order_id) > 1
-- Проверка на уникальность primary key в olist.products
select product_id, count(*)
from olist.products
group by product_id
having count(*) > 1
-- Проверка на уникальность primary key в olist.sellers
select seller_id, count(*)
from olist.sellers 
group by seller_id
having count(*) > 1
-- Проверка на уникальность composite key в olist.order_items
select order_id, order_item_id, count(*)
from olist.order_items
group by order_id, order_item_id
having count(*) > 1
-- Проверка на уникальность composite key в olist.order_payments
select order_id, payment_sequential, count(*)
from olist.order_payments
group by order_id, payment_sequential
having count(*) > 1
STEP 2
-- Проверка NULL в ключевых атрибутах olist.orders
select customer_id
from olist.orders
where customer_id is null
-- Проверка NULL в ключевых атрибутах olist.order_items
select product_id
from olist.order_items
where product_id is null
-- Проверка NULL в ключевых атрибутах olist.order_items
select seller_id
from olist.order_items
where seller_id is null
-- Проверка NULL в ключевых атрибутах olist.order_payments
select payment_value
from olist.order_payments
where payment_value is null
STEP 3
-- Проверка на сломанные связи olist.orders >>> olist.customers
select o.order_id, c.customer_id
from olist.orders o
left join olist.customers c using(customer_id)
where c.customer_id is null
-- Проверка на сломанные связи olist.order_items >>> olist.products
select oi.order_id, p.product_id
from olist.order_items oi
left join olist.products p using(product_id)
where p.product_id is null
-- Проверка на сломанные связи olist.order_items >>> olist.sellers
select oi.order_id, s.seller_id
from olist.order_items oi
left join olist.sellers s using(seller_id)
where s.seller_id is null
STEP 4
-- Проверка на аномалии в данных olist.order_items
select price, freight_value
from olist.order_items
where price < 0
or freight_value < 0
or price = 0
-- Аномалий не обнаружено
____________________________________________________
-- Проверка на аномалии в данных olist.order_payments
select payment_value
from olist.order_payments 
where payment_value < 0
or payment_value = 0
-- Присутсвует 9 строк, где payment_value = 0
_____________________________________________________
-- Проверка на аномалии в данных olist.orders
select order_delivered_customer_date,
       order_purchase_timestamp,
	   order_approved_at,
	   order_delivered_carrier_date
from olist.orders
where order_delivered_customer_date < order_purchase_timestamp
or order_approved_at < order_purchase_timestamp
or  order_delivered_carrier_date <  order_purchase_timestamp
-- Присутсвуют аномалии в 166 строках
____________________________________________________
-- Проверка на аномалии в данных в olist_order_reviews
select review_score
from olist.order_reviews
where review_score < 1
or review_score > 5
-- Аномалий не обнаружено
____________________________________________________
--Декомпозиция аномалий в olist.orders step 1
select order_delivered_customer_date,
       order_purchase_timestamp
from olist.orders
where order_delivered_customer_date < order_purchase_timestamp
-- Аномалий не обнаружено 
____________________________________________________
--Декомпозиция аномалий в olist.orders step 2
select order_purchase_timestamp,
	   order_approved_at   
from olist.orders
where order_approved_at < order_purchase_timestamp
-- Аномалий не обнаружено
____________________________________________________
--Декомпозиция аномалий в olist.orders step 3
select order_purchase_timestamp,
	   order_delivered_carrier_date
from olist.orders
where order_delivered_carrier_date <  order_purchase_timestamp
-- Обнаружено 166 аномалий
