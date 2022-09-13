# docker_airflow

---
### Step 0: Set DOCKER_AIRFLOW_HOME

define environment variable DOCKER_AIRFLOW_HOME as path to the current directory
using `export DOCKER_AIRFLOW_HOME=/home/ubuntu/docker_airflow` for eg.
It is important to define this environment variable as all scripts run 
relative to this path.

---
### Step 1: Download official docker-compose
Download the official `docker-compose.yaml` using `./cli/startup/1-download-official-docker-compose.sh` 

---
### Step 2: Customise Docker Compose
1. Change default webserver port for `airflow-webserver` (8080 -> 5884)
2. Add extra postgres db service named `destination_postgres`

---
### Step 3: Initialize environment
Initialize the environment using `./cli/manage/1-initialize-environment.sh`

It does two things mainly:
1. create three folders `./dags`, `./logs`, `./plugins`
2. create a `./.env` file which saves current users UID

---
### Step 4: Initialize Airflow Database
Initialise airflow database using `./cli/manage/2-initialize-database.sh`

| this will run database migrations and create the first user account with 
username: *airflow* & password: *airflow*

---
### Step 5: Start all services
Start all services using `./cli/manage/3-start-all-services.sh`

---
### Step 6: Health Check
Check that all containers/services in docker are in **healthy** state once all 
services are started using `./cli/manage/4-health-check.sh`

---
### Step 7: Access Webserver
You should be able to access airflow-webserver at [http://localhost:5884]()

---
### Step 8: Check registered DAG
After a while you should see a DAG named **Etl** on the webUI. This is 
because this repository has `./dags/etl.py` which is eventually registered 
in the WebUI because docker-compose mounts the three folders created in 
**Step 3** above.

---
### Step 9: Create Airflow DB Connections
The **Etl** DAG just registered contains the necessary code for populating 
and transferring data between two postgres services contained inside the 
`docker-compose.yaml` viz. postgres, destination_postgres.

| However airflow needs Postgres connection to both DB services. We can do 
that via command line or via WebUI.

Using UI we can create Postgres connection by going to Admin -> Connections.
For filling in the details, refer to `./db_connections` folder which 
contains the credentials for both databases.

These scripts make use of 
`airflow` CLI utility which is present in `airflow-worker` service running 
with `docker-compose.yaml`

---
### Step 10: Trigger DAG manually
Visit the webUI and trigger **Etl** DAG manually

This will make use of `./dags/files/products.csv` file and upload it to 
source database.Data of `source_a` in source database is then copied to 
`destination_b` in destination database.

---
### Step 11: Check final output

Observe  the two tables in both databases using inside corresponding docker 
container for postgres `psql -U airflow` and enter 
*airflow* as password when prompted.

`select * from source_a;`

`select * from destination_b;`
