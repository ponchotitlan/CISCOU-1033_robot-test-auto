# Example of a dummy API server for Robot testing purposes
# Author: @ponchotitlan

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

# Dummy storage for network devices
devices = []

# Pydantic model for device
class Device(BaseModel):
    id: int
    name: str
    ip_address: str



# GET endpoint for a specific device based on ID
@app.get("/devices/{id}")
def get_device(id: int):
    for device in devices:
        # An existing device matches the requested device ID
        if device.id == id:
            return {"device":device.dict()}
        
    # The requested device ID was not found
    raise HTTPException(status_code=400, detail="Device ID not found!")



# POST endpoint for devices
@app.post("/devices")
def add_device(device: Device):
    # Appending of the new device to the devices list
    devices.append(device)
    return {"message": "Device added successfully! 🤖", "device": device}