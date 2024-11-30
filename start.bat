@echo off
setlocal enabledelayedexpansion

:: Set the MySQL root password
set MYSQL_ROOT_PASSWORD=password

:: Build the Docker image for the application
echo Building the app image...
docker build -t conference-management .

:: Check if the build was successful
if %errorlevel% neq 0 (
    echo Docker image build failed. Exiting...
    exit /b 1
)

:: Start the Docker container for the database service
echo Starting db service...
docker-compose up -d db

:: Wait for MySQL to be ready
echo Waiting for db service to be ready...
timeout /t 5

:: Run the MySQL client command to connect to the database
echo Running MySQL command...
docker exec -it db mysql -u root -p%MYSQL_ROOT_PASSWORD% -e "SHOW TABLES;"

:: Start the app service
echo Starting app service...
docker-compose up -d app

echo Services started successfully!
pause