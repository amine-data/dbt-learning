with fact_metrics as (

    select
        customer_id,
        count(order_id) as total_orders,
        sum(completed_order_count) as completed_orders,
        sum(completed_amount) as completed_revenue

    from {{ ref('fct_orders') }}

    group by customer_id

)

select
    d.customer_id,
    d.total_orders as total_orders_dim,
    coalesce(f.total_orders, 0) as total_orders_fact,
    d.completed_orders as completed_orders_dim,
    coalesce(f.completed_orders, 0) as completed_orders_fact,
    d.completed_revenue as completed_revenue_dim,
    coalesce(f.completed_revenue, 0) as completed_revenue_fact

from {{ ref('dim_customers') }} as d

left join fact_metrics as f
    on d.customer_id = f.customer_id

where d.total_orders != coalesce(f.total_orders, 0)
   or d.completed_orders != coalesce(f.completed_orders, 0)
   or abs(
       d.completed_revenue - coalesce(f.completed_revenue, 0)
   ) > 0.01