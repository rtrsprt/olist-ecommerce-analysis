-- Количество уникальных клиентов по месяцам
select date_trunc('month',o.order_purchase_timestamp) as month,
       count(distinct c.customer_unique_id) as count_unique_customers
from olist.orders o
join olist.customers c using(customer_id)
group by date_trunc('month',o.order_purchase_timestamp)
order by month
___________________________________________________
-- Количество новых клиентов по месяцам 
with first_orders as (
   select c.customer_unique_id, 
          min(o.order_purchase_timestamp) as first_order_date
	from olist.orders o
	join olist.customers c using(customer_id)
	group by c.customer_unique_id
)
select date_trunc('month', first_order_date) as month,
       count(distinct customer_unique_id) as new_customers
from first_orders
group by date_trunc('month', first_order_date)
order by month
___________________________________________________
-- Количество клиентов повторивших заказ
with orders_cnt as (
   select count(o.order_id) as orders_count,
          c.customer_unique_id
   from olist.orders o 
   join olist.customers c using(customer_id)
   group by c.customer_unique_id
)
select count(distinct customer_unique_id) as repeat_customers
from orders_cnt
where orders_count > 1
___________________________________________________
--Доля вернувшихся клиентов
with orders_cnt as (
   select count(o.order_id) as orders_count,
          c.customer_unique_id
   from olist.orders o 
   join olist.customers c using(customer_id)
   group by c.customer_unique_id
),
repeat_cust as (
   select count(distinct customer_unique_id) as repeat_customers
   from orders_cnt
   where orders_count > 1 
), 
repeat_share as (
   select count(distinct customer_unique_id) as total_customers
   from orders_cnt
) 
select round((rc.repeat_customers / (rs.total_customers)::numeric) * 100,2)||'%' as repeat_rate
from repeat_cust rc
cross join repeat_share rs
___________________________________________________
-- Среднее количество заказов на одного клиента
with orders_cnt as (
   select count(o.order_id) as orders_count,
          c.customer_unique_id
   from olist.orders o 
   join olist.customers c using(customer_id)
   group by c.customer_unique_id
)
select round(avg(orders_count),2) as avg_order_customers
from orders_cnt
