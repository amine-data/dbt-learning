{{ config(materialized='view') }}

with customers_history as (

    select *
    from {{ ref('customers_snapshot') }}
)

select
    customer_id,
    first_name,
    last_name,
    email,
    created_at,
    dbt_valid_from,
    dbt_valid_to,

    case
        when dbt_valid_to is null then true
        else false
    end as is_current

from customers_history
