# CISCOU-1033: Mastering Test Automation Bliss with Robot Framework

[![Robot Framework](https://img.shields.io/badge/robot-aqua?style=flat&logo=robotframework)]()
[![Docker](https://img.shields.io/badge/docker-gray?style=flat&logo=docker)]()
[![Python](https://img.shields.io/badge/Python-gray?style=flat&logo=python)]()
[![Cisco Live](https://img.shields.io/badge/CiscoLive-2025-blue?style=flat&logo=cisco)]()
[![Linkedin: asandovalros](https://img.shields.io/badge/Howdy!-LinkedIn-blue?style=flat)](https://www.linkedin.com/in/asandovalros)

***

Learn how to effortlessly create comprehensive test suites that address the key points of your upcoming software releases, while integrating into your CI/CD pipelines, generating HTML reports and beyond. Everything with the aid of an open-source framework. Say goodbye to complex unit testing, and hello to your new favourite Robot!

## Demo setup

Your system needs to have the following requirements already installed:

- Docker
- Python v3.8+

It is only needed to install the Python libraries needed for running the Robot test cases of this repository. Preferrably, it should be done in a virtual environment.

Navigate to the root of this repository and issue the following command:

```
pip install requirements.txt
```

## Robot test suites run

This repository contains a Jupyter Notebook from which each test suite can be run. The file ```CISCOU-1033_demo.ipynb``` is located in the root of this repository.

Just click on the play button next to each cell. Each of the test suites contains a ```Suite Setup``` and ```Suite Teardown``` custom keyword. The setup will invoke a specific service within the ```docker-compose``` file located in the ```containers``` folder, and the teardown will destroy the container and volume of this specific service once the tests were executed.

If this demo is being run using a Python virtual environment, it will be required to select it in the corresponding IDE prior to running the blocks in the notebook.