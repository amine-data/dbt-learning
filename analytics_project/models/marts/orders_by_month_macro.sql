{{ config(materialized='view') }}

select
    {{ start_of_month('order_date') }} as order_month,
    count(*) as total_orders,
    countif(order_status = 'completed') as completed_orders

from {{ ref('stg_orders') }}

group by order_month
order by order_month