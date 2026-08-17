{% macro clean_string(column_name) %}

    TRIM(UPPER({{ column_name }}))

{% endmacro %}