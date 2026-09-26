with source as (

    select *
    from {{source('raw_dbt_training', 'customers')}}
),

cleaned as (

    select 
        customer_id,
        trim(first_name) as first_name,
        trim(last_name) as last_name,
        lower(trim(email)) as email,
        created_at
    from
       source
)

select * 
    from
      cleaned