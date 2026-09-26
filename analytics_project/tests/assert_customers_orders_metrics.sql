select *
  from {{ ref('int_customers_orders') }} 
  where total_orders < 0
      or completed_orders < 0
      or completed_orders > total_orders
      or completed_revenue < 0