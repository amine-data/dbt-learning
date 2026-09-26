{{ config(materialized='view') }}

with orders as (

    select *
    from {{ ref('fct_orders') }}

),

order_statuses as (

    select *
    from {{ ref('order_statuses') }}

)

select
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.order_status,

    order_statuses.status_label,
    order_statuses.is_final,

    orders.amount,
    orders.completed_order_count,
    orders.completed_amount

from orders

left join order_statuses
    on orders.order_status = order_statuses.order_status