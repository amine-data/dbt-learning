with customers_orders as (

    select *
    from {{ ref('int_customers_orders') }}
)

select
    customer_id,
    first_name,
    last_name,
    email,
    created_at,
    total_orders,
    completed_orders,
    completed_revenue,
    last_order_date
from 
    customers_orders