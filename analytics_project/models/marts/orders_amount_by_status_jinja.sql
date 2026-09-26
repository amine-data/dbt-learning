{{ config(materialized='view') }}

{% set order_statuses = [
    'completed',
    'cancelled',
    'pending'
] %}

select
    customer_id

    {% for status in order_statuses %}

        , sum(
            case
                when order_status = '{{ status }}' then amount
                else 0
            end
        ) as {{ status }}_amount

    {% endfor %}

from {{ ref('stg_orders') }}

group by customer_id

