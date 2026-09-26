{{ config(materialized='view') }}

select
    customer_id,
    total_orders,
    completed_orders,
    {{ percentage('completed_orders', 'total_orders') }} as completed_rate_pct

from {{ ref('orders_by_customer_jinja') }}