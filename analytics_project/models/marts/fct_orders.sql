{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

with orders as (

    select *
    from {{ ref('stg_orders') }}
)

select 
     order_id,
     customer_id,
     order_date,
     order_status,
     amount,

     case 
         when order_status = 'completed' then 1
         else 0
    end  as completed_order_count,

    case 
        when order_status= 'completed' then amount
        else 0
    end as completed_amount

from orders

{% if is_incremental() %}

where order_date >= (
    select coalesce(
        date_sub(max(order_date), interval 7 day),
        date('1900-01-01')
    )
    from {{ this }}
)
{% endif %}
