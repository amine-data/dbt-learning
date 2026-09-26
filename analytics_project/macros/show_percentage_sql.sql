{% macro show_percentage_sql() %}
    {% set expression = percentage('4', '6') %}
    {{ log(expression, info=true) }}
{% endmacro %}