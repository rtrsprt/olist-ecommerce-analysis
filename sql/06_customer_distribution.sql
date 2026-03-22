-- Распределение клиентов
with customer_orders as (
   select c.customer_unique_id,
          count(o.order_id) as total_orders
	from olist.customers c 
	join olist.orders o using(customer_id)
	group by c.customer_unique_id
),
customer_segments as (
   select customer_unique_id,
          total_orders,
		  case
		     when total_orders = 1 then '1 order'
			 when total_orders = 2 then '2 orders'
			 when total_orders > 2 then '3+ orders'
			 end as segment
	from customer_orders
)
select count(customer_unique_id) as customers,
       segment
from customer_segments
group by segment
order by segment

-- Распределение заказов по количеству позиций
with item_counts as (
   select order_id,
          count(order_item_id)  as total_items
	from olist.order_items
	group by order_id
),
order_segments as (
   select order_id,
          case
		     when total_items = 1 then '1 item'
			 when total_items = 2 then '2 items'
			 else '3+ items' 
			 end as segment
	from item_counts
)
select count(order_id) as orders,
       segment
from order_segments
group by segment
order by segment
