airflow connections add 'destination_pg' \
    --conn-json '{
        "conn_type": "postgres",
        "login": "airflow",
        "password": "airflow",
        "host": "destination_postgres",
        "port": 5432,
        "schema": "airflow"
    }'
