*** Settings ***
Library    Collections
Library    DatabaseLibrary
Library    Process
Metadata   Author    @ponchotitlan
Metadata   Version   1.6
Metadata   Purpose   Test Database for managing network devices

Suite Setup    Mock Database Setup
Suite Teardown    Mock Database Teardown

*** Variables ***
${COMPOSE_FILE}    ../containers/docker-compose.yml
${COMPOSE_SERVICE}    postgres
${DB_HOST}        localhost
${DB_PORT}        5432
${DB_NAME}        network_devices
${DB_USER}        admin
${DB_PASSWORD}    cisco123
${DB_DRIVER}      psycopg2

*** Test Cases ***
Create a Network Device
    [Documentation]    Test the creation of a network device in the database "network_devices" - table "devices" - values (4, 'Guanajuato', 'iosxr04', 'active')
    Connect To Database    ${DB_DRIVER}    ${DB_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB_HOST}    ${DB_PORT}

    # New record in the database
    ${insert_query}=    Catenate
    ...    INSERT INTO devices (device_id, location, status, hostname)
    ...    VALUES (4, 'Guanajuato', 'iosxr04', 'active');
    Execute Sql String    ${insert_query}

    Disconnect From Database

Retrieve a Network Device
    [Documentation]    Test the retrieval of a network device in the database "network_devices" - table "devices" - record (2, 'Amsterdam', 'iosxr02', 'inactive')
    Connect To Database    ${DB_DRIVER}    ${DB_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB_HOST}    ${DB_PORT}

    # Query record from the database
    ${query_result}=    Query    SELECT * FROM devices WHERE location='Amsterdam';
    ${row}=    Get From List    ${query_result}    0
    Should Be Equal As Integers    ${row}[1]    2
    Should Be Equal    ${row}[2]    Amsterdam
    Should Be Equal    ${row}[3]    iosxr02
    Should Be Equal    ${row}[4]    inactive

    Disconnect From Database

*** Keywords ***
Mock Database Setup
    [Documentation]    Setup of the mock Database using docker-compose and a FastAPI container

    # Spin docker-compose specific service
    Run Process    docker-compose    -f    ${COMPOSE_FILE}    up    -d     ${COMPOSE_SERVICE}
    Sleep    3

Mock Database Teardown
    [Documentation]    Setup of the mock Database using docker-compose and a FastAPI container

    # Stop and delete docker-compose specific service
    Run Process    docker-compose    -f    ${COMPOSE_FILE}    stop     ${COMPOSE_SERVICE}
    Run Process    docker-compose    -f    ${COMPOSE_FILE}    rm    -f    ${COMPOSE_SERVICE}