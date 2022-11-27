# Artic: Senior Design Project
version: 11/27/2022

Mobile application that aims to assist undergraduates in developing a degree plan for a specified major or exploring alternative majors based on past course history

## How to Run
Requires [Android Studio](https://developer.android.com/studio) and [Flutter](https://docs.flutter.dev/get-started/install)

### Flutter Set Up
- Extract and place the Flutter folder in the C drive (C:\src\flutter)
  - Add the Flutter's bin folder to the environment PATH
  - Verify if Flutter is correctly set up by running the following lines in command prompt: <code>flutter --version</code> and <code>flutter doctor</code>

### Android Studio Set Up
- Download and open Android Studio
- Go to the 'Plugins' tab and search/install Flutter
  - Restart Android Studio and verify that the 'New Flutter Project' option is enabled
- Select 'Get from Version Control...' and clone the project

### Database Set Up
- Open the project and go to 'Device Manager'
- Either create a new device (Nexus 6 API 28, Pie (OS), Graphics: Hardware - GLES 2.0) or use a pre-existing device
- Launch the emulator
  - run 'main.dart' and restart the emulator after the program launches successfully
- Access 'Device File Explorer'
  - In the device's file explorer, navgiate to data\data\articSJSU.edu.artic\databases
  - Right click the databases folder and upload the three files found in Artic\lib\Database
  - Run main.dart
 <br></br>
 
 ## Application Features
