with source as (
    select *
       from {{ source('raw_dbt_training', 'orders') }}
),

cleaned as (

    select
        cast(order_id as int64) as order_id,
        cast(customer_id as int64) as customer_id,
        order_date,
        lower(trim(status)) as order_status,
        cast(amount as numeric) as amount
     from
         source 
)

select *
     from cleaned