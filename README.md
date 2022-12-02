# Artic: Senior Design Project
version: 11/27/2022 [GitHub](https://github.com/Jellyfish25/Artic)

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
The welcome screen should be visible on launch, providing options for users to create a new account (Join now), or to sign into an existing account. Note: Since the application uses SQLite, the database is local to the device.

### Some key features of the application:
- Exploring what majors are offered at different colleges
- Entering courses to the account's course history
- Generating a degree plan for a school (Currently only supports SJSU)
- Favoriting an existing plan
- Comparing the required courses between two existing plans
 
### Sample Pages
#### Welcome Screen
![image](https://user-images.githubusercontent.com/73325837/204152542-98490afd-cc23-4e1f-a261-770973a841f7.png)
![image](https://user-images.githubusercontent.com/73325837/204153702-b9a27929-bbbe-4ef9-befc-d1beecee2a47.png)
<br></br>
#### Overview Screen
![image](https://user-images.githubusercontent.com/73325837/204153451-108badd7-2b33-44bc-a609-bc9f64dd05f4.png)
![image](https://user-images.githubusercontent.com/73325837/204153738-1e04ecaf-690e-49d1-9525-1039ad3f45a9.png)
<br></br>
#### Course History Screen
![image](https://user-images.githubusercontent.com/73325837/204153627-fd7c9a9b-e731-4f13-b254-edcc9834719a.png)
![image](https://user-images.githubusercontent.com/73325837/204153668-19a800f8-a2f4-4176-baf8-91d748f141d1.png)
<br></br>
#### My Plans Screen
![image](https://user-images.githubusercontent.com/73325837/204153782-55bb98dd-8f3d-43ab-8249-3c0dd8568406.png)
![image](https://user-images.githubusercontent.com/73325837/204153794-f764777a-3a32-4919-863f-3824f5cba140.png)
<br></br>
#### Explore Majors Screen
![image](https://user-images.githubusercontent.com/73325837/204153870-4da94dc9-a7f4-4785-a63c-b3ecaa440a6c.png)
![image](https://user-images.githubusercontent.com/73325837/204153875-b12540a2-e6f0-410a-af69-44d15e85af99.png)
<br></br>
#### Compare Plans Screen
![image](https://user-images.githubusercontent.com/73325837/204153898-2ec3930b-dc7a-43f8-92b1-2060592c1aaa.png)
![image](https://user-images.githubusercontent.com/73325837/204153910-3a7c8a20-95a8-4c19-b479-ae45b7205b99.png)
<br></br>
