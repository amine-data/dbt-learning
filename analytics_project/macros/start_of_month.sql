{% macro start_of_month(date_column) %}
    date_trunc({{ date_column }}, month)
{% endmacro %}