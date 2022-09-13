airflow connections add 'source_pg' \
    --conn-json '{
        "conn_type": "postgres",
        "login": "airflow",
        "password": "airflow",
        "host": "postgres",
        "port": 5432,
        "schema": "airflow"
    }'
