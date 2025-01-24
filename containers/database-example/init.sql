-- init.sql

-- Create a database
CREATE DATABASE network_devices;

-- Connect to the newly created database
\connect network_devices;

-- Create a table for network devices
CREATE TABLE devices (
    id SERIAL PRIMARY KEY,
    device_id INT NOT NULL,
    location VARCHAR(255),
    hostname VARCHAR(10),
    status VARCHAR(50)
);

-- Insert dummy data
INSERT INTO devices (device_id, location, hostname, status) VALUES
(1, 'Lisbon', 'iosxr01', 'active'),
(2, 'Amsterdam', 'iosxr02', 'inactive'),
(3, 'MexicoCity', 'iosxr03', 'active');