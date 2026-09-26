{{ config(materialized='view') }}

select
    order_month,
    total_orders,
    completed_orders,
    {{ percentage('completed_orders', 'total_orders') }} as completed_rate_pct

from {{ ref('orders_by_month_macro') }}