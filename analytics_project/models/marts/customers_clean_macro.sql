{{ config(materialized='view') }}

select
    customer_id,
    first_name,
    {{ clean_string('first_name') }} as first_name_clean,
    last_name,
     {{ clean_string('last_name') }} as last_name_clean

from {{ ref('stg_customers') }}