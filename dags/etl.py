import datetime
import pendulum
import os

import requests
from airflow.decorators import dag, task
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.postgres.operators.postgres import PostgresOperator


@dag(schedule_interval="0 0 * * *", start_date=pendulum.datetime(2021, 1, 1, tz="UTC"), catchup=False,
        dagrun_timeout=datetime.timedelta(minutes=60), )
def Etl():
    create_source_table = PostgresOperator(task_id="create_source_table", postgres_conn_id="source_pg",
            sql="""
            DROP TABLE IF EXISTS source_a;
            CREATE TABLE source_a (
                "id" INTEGER,
                "creation_date" DATE,
                "sale_value" INTEGER
            );""", )

    create_destination_table = PostgresOperator(task_id="create_destination_table",
            postgres_conn_id="destination_pg", sql="""
            DROP TABLE IF EXISTS destination_b;
            CREATE TABLE destination_b (
                "id" INTEGER,
                "creation_date" DATE,
                "sale_value" INTEGER
            );""", )

    @task
    def create_source_data():
        # NOTE: configure this as appropriate for your airflow environment
        data_path = "/opt/airflow/dags/files/products.csv"

        postgres_hook = PostgresHook(postgres_conn_id="source_pg")
        conn = postgres_hook.get_conn()
        cur = conn.cursor()
        with open(data_path, "r") as file:
            cur.copy_expert("COPY source_a FROM STDIN WITH CSV HEADER DELIMITER AS ',' QUOTE '\"'", file, )
        conn.commit()

    @task
    def transfer_source_data():
        data_path = "/opt/airflow/dags/files/products.csv"

        postgres_hook = PostgresHook(postgres_conn_id="destination_pg")
        conn = postgres_hook.get_conn()
        cur = conn.cursor()
        with open(data_path, "r") as file:
            cur.copy_expert("COPY destination_b FROM STDIN WITH CSV HEADER DELIMITER AS ',' QUOTE '\"'", file, )
        conn.commit()

    [create_source_table, create_destination_table] >> create_source_data() >> transfer_source_data()


dag = Etl()
