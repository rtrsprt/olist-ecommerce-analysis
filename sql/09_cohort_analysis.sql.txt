with first_order as (
   select c.customer_unique_id, 
          date_trunc('month', min(o.order_purchase_timestamp)) as cohort_month
	from olist.customers c
	join olist.orders o using(customer_id)
	group by c.customer_unique_id
),
size_c as (
   select count(distinct customer_unique_id) as cohort_size,
          cohort_month
	from first_order
	group by cohort_month
),
active_month as (
   select  distinct c.customer_unique_id,
          date_trunc('month', o.order_purchase_timestamp) as order_month
	from olist.customers c
	join olist.orders o using(customer_id)
),
cohort_base as (
   select f.customer_unique_id,
          f.cohort_month,
		  a.order_month,
		  (
          (extract(year from a.order_month) - extract(year from f.cohort_month)) * 12 
		  + (extract (month from a.order_month) - extract(month from f.cohort_month))
		  )::int as month_number,
		  s.cohort_size
	from first_order f
	join active_month a using(customer_unique_id)
	join size_c s using(cohort_month)
)
select to_char(cohort_month, 'YYYY-MM') as cohort_month,
       month_number,
       count(distinct customer_unique_id) as customers,
	   cohort_size,
	   round((count(distinct customer_unique_id) / nullif(cohort_size,0)::numeric)*100,2)||'%' as retention_rate
from cohort_base
group by cohort_month,
	     month_number,
	     cohort_size
order by cohort_month, month_number
