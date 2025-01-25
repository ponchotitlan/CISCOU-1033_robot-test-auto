*** Settings ***
Library           Process
Library           OperatingSystem
Metadata   Version   1.3
Metadata   Purpose   Test a script for managing network devices

*** Variables ***
${SCRIPT}         python ../scripts/test_script_devices.py 
${DEVICE_NAME}    iosxr01
${LOCATION}       Amsterdam
${IP_ADDRESS}     192.168.1.1

*** Test Cases ***
Run Device Script And Check Output
    [Documentation]    Test case to run the device_info.py script and verify a successful output: test_script_devices.py --device_name iosxr01 --location Amsterdam --ip_address 192.168.1.1

    # Construct the command with arguments
    ${cmd}=    Set Variable    ${SCRIPT} --device_name ${DEVICE_NAME} --location ${LOCATION} --ip_address ${IP_ADDRESS}

    # Run the process
    ${result}=    Run Process    ${cmd}    stdout=stdout.txt    stderr=stderr.txt    shell=True

    # Check the return code
    Should Be Equal As Numbers    ${result.rc}    0

    # Verify the output contains the expected message
    ${stdout}=    Get File    stdout.txt
    Should Contain    ${stdout}    Success