*** Settings ***
Library    RequestsLibrary
Library    Process
Metadata   Author    @ponchotitlan
Metadata   Version   1.8
Metadata   Purpose   Test API endpoints for managing network devices

Suite Setup    Mock API Server Setup
Suite Teardown    Mock API Server Teardown

*** Variables ***
${COMPOSE_FILE}    ../containers/docker-compose.yml
${COMPOSE_SERVICE}    fastapi-app
${BASE_URL}    http://localhost:8000
${DEVICE_ID}   1
${DEVICE_NAME}   iosxr01
${DEVICE_IP}   192.168.1.1

*** Test Cases ***
Create a Network Device
    [Documentation]    Test the creation of a network device in the API server- http://localhost:8000/devices - body: {"id","name","ip_address"}

    # Create a session for HTTP requests
    Create Session    http    ${BASE_URL}

    # Send POST request to create a new network device
    ${device_data}=   Create Dictionary    id=${DEVICE_ID}    name=${DEVICE_NAME}    ip_address=${DEVICE_IP}
    Log    ${device_data}
    ${response}=      POST On Session    http    /devices    json=${device_data}

    # Verify the response status for POST request
    Should Be Equal As Numbers    ${response.status_code}    200

Retrieve a Network Device
    [Documentation]    Test the retrieval of an existing network device from the API server- http://localhost:8000/devices/id

    # Create a session for HTTP requests
    Create Session    http    ${BASE_URL}

    # Send GET request to retrieve a new network device
    ${response}=      GET On Session    http    /devices/${DEVICE_ID}

    # Verify the response status and content for GET request
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Be Equal    ${response.json()}[device][name]    ${DEVICE_NAME}
    Should Be Equal    ${response.json()}[device][ip_address]    ${DEVICE_IP}

*** Keywords ***
Mock API Server Setup
    [Documentation]    Setup of the mock API server using docker-compose and a FastAPI container

    # Spin docker-compose specific service
    Run Process    docker-compose    -f    ${COMPOSE_FILE}    up    -d     ${COMPOSE_SERVICE}
    Sleep    3

Mock API Server Teardown
    [Documentation]    Setup of the mock API server using docker-compose and a FastAPI container

    # Stop and delete docker-compose specific service
    Run Process    docker-compose    -f    ${COMPOSE_FILE}    stop     ${COMPOSE_SERVICE}
    Run Process    docker-compose    -f    ${COMPOSE_FILE}    rm    -f    ${COMPOSE_SERVICE}