with customers as (
    
     select *
        from {{ ref('stg_customers') }}

),

orders as (

     select *
        from {{ ref('stg_orders') }}

    
),

customers_orders as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customers.email,
        customers.created_at,

        count(orders.order_id) as total_orders,
        
        countif(
            orders.order_status = 'completed'
        ) as completed_orders,

        sum(
             case 
                when orders.order_status = 'completed'
                     then orders.amount
                else 0
            end 

        ) as completed_revenue,

        max(orders.order_date) as last_order_date

    from customers

    left join orders
         on customers.customer_id= orders.customer_id

    group by 
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customers.email,
        customers.created_at
       

)

select *
   from  
      customers_orders