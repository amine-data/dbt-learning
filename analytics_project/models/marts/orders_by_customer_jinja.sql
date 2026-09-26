{{ config(materialized='view') }}

{% set order_statuses = [
    'completed',
    'cancelled',
    'pending'
] %}

{% set include_completed_amount = true %}

with orders as (

    select *
    from {{ ref('stg_orders') }}

)

select
    customer_id,
    count(*) as total_orders

    {% for status in order_statuses %}

        , countif(
            order_status = '{{ status }}'
        ) as {{ status }}_orders

    {% endfor %}

    {% if include_completed_amount %}

        , sum(
            case
                when order_status = 'completed' then amount
                else 0
            end
        ) as completed_amount

    {% endif %}

from orders

group by customer_id