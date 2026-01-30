
![BINNY'S LOGO](Branding/Binny-Header.png)

### Meet Binny

An Interactive, AI-Powered Smart Bin System, that promotes recycling in a friendly manner. Built for SmartXP @ University of Twente as a M2 (Smart Environments) Project 

### Authors
* Razvan Samoila (@d_ytme)
* Bart Koning
* A.M.S Lukacie 
* Aikaterini Constantinou
* Anniek Meinders

### Demo & Awards

The project has been showcased during the Module 2 Demo-Day 2026, at the University of Twente, where it has won second place in the project competition.

### Functionality

Our system is comprised of a Processing-Based UI Client, which talks directly with a series of Arduino-Powered Smart Bins. The client can use either an ESP32 camera or a connected WebCam as a camera feed source. 

The AI Model employed is based on the YOLOv5 Architecture, with this specific instance being trained as the [TrashAI Project of Open Sacremento](https://github.com/opensacorg/trash-ai). We implemented this model as a separate instance, through a NodeJS-Powered Docker Container, [TrashAI-API](https://github.com/dytme/TrashAI-API).



