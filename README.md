<br />
<p
  
  <h1 align="center">CUSTOM EMOJIBOARD</h1>

  <p align="center">
    A  Capstone Project!
    <br />

  </p>
</p>


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#Authors">Authors</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>






<!-- ABOUT THE PROJECT -->
## About The Project



Custom Emojiboard is an Android custom keyboard and emoji application developed with Android studio using Java and Flutter (Dart) respectively. This app allows users to upload their own images and GIFs onto the emoji application. The user has the option to edit the image (cropping, tilting, etc.) before finally uploading it on the app.

Once uploaded, the user can view all their uploads on a grid view. The images are uploaded to a Firebase Storage Bucket, which is further referenced in Firebase's backend Realtime Database.

Paired with the Emoji Application is a custom system-wide Android Soft keyboard which has two layouts and functions; 
A standard mobile keyboard with a qwerty layout for regular text typing.

An image-view layout that displays a grid of clickable images and GIF’s that the user has uploaded over on the Emoji app. This is accomplished through Android's SDK which includes the Commit Content API, that provides a universal way for IME's to send images and other rich content directly to a text editor in an app.

On the Image-view on the keyboard up, are all the images and GIF's that the user has uploaded over on the main Emoji app, organized into a grid-view ready to be viewed, clicked-on and shared to friends and family.

Users can go back and forth between both standard keyboard and 'Emojiboard' layouts with a special button on the keyboard.

### Built With

* [Flutter](https://flutter.dev/)
* [Java](https://www.java.com/en/)
* [Firebase](https://firebase.google.com/)






<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

* [Android Studio](https://developer.android.com/studio/install)
* [Visual Studio Code](https://code.visualstudio.com/download)
* [Flutter](https://flutter.dev/docs/development/tools/vs-code)

### Installation

1. Install Android Studio, Visual Studio Code and Flutter.
2. Clone the repo
	```sh
    git clone https://github.com/awadahmed97/custom_emojiboard.git
   ```

*Android Studio:*
1. Launch Android Studio and open the 'CustomKeyboard'  file under the 'Keyboard App' directory.
2. Setup a virtual device (AVD manager) to install and run the app using the inbuilt Android Emulator.
3. Run the project.


*Visual Studio Code:*
1. Launch Visual Studio Code and open the 'Main Application' folder in the project directory.
2. Click on 'main.dart' and run. This will launch the app in the Android Studio Emulator.



*Setting Up the Keyboard app:*
1. Once the emulator launches the device, head into 
settings -> System -> Languages & input -> On-screen keyboard -> Manage on-screen keyboards,

2. Turn on CustomEmojiKeyboard.

3. Finally, tap on any text field, and tap on the little keyboard icon at the right of the navigation bar. turn on 'Show virtual keyboard' then switch input method to 'CustomEmojiKeyboard'.
 
You only need to do this setup once.




<!-- USAGE EXAMPLES -->
## Usage

<!-- INSERT IMAGES AND SNAPSHOTS-->

![Screenshot 2021-06-02 154444](https://user-images.githubusercontent.com/38057565/121861488-dcce5500-ccc7-11eb-8106-534b69d34027.png)
![Screenshot 2021-06-02 154413](https://user-images.githubusercontent.com/38057565/121861490-dcce5500-ccc7-11eb-900f-982444e288de.png)
![Screenshot 2021-06-14 040553](https://user-images.githubusercontent.com/38057565/121861492-dd66eb80-ccc7-11eb-8e0c-8bdfe438c771.png)
![Screenshot 2021-06-14 040517](https://user-images.githubusercontent.com/38057565/121861493-dd66eb80-ccc7-11eb-8c3a-77639aeabf12.png)
![Screenshot 2021-06-14 040449](https://user-images.githubusercontent.com/38057565/121861495-dd66eb80-ccc7-11eb-8f30-45bfc816a102.png)
![Screenshot 2021-06-14 040357](https://user-images.githubusercontent.com/38057565/121861498-dd66eb80-ccc7-11eb-987e-209c55c04bf3.png)
![Screenshot 2021-06-14 040245](https://user-images.githubusercontent.com/38057565/121861499-ddff8200-ccc7-11eb-94ca-798f3020fa1c.png)
![Screenshot 2021-06-14 035638](https://user-images.githubusercontent.com/38057565/121861501-ddff8200-ccc7-11eb-90f8-4dcf1afd11c4.png)
![Screenshot 2021-06-14 035403](https://user-images.githubusercontent.com/38057565/121861502-de981880-ccc7-11eb-8409-d080123292f1.png)
![Screenshot 2021-06-14 035153](https://user-images.githubusercontent.com/38057565/121861505-de981880-ccc7-11eb-9f1c-d28b6e69b93e.png)
![Screenshot 2021-06-14 035058](https://user-images.githubusercontent.com/38057565/121861507-de981880-ccc7-11eb-8bd0-f4c78dd040ae.png)
![Screenshot 2021-06-14 034938](https://user-images.githubusercontent.com/38057565/121861508-df30af00-ccc7-11eb-9587-e2e7111073ac.png)
![Screenshot 2021-06-14 034755](https://user-images.githubusercontent.com/38057565/121861510-df30af00-ccc7-11eb-81c0-5538d70efc32.png)
![Screenshot 2021-06-14 034538](https://user-images.githubusercontent.com/38057565/121861511-df30af00-ccc7-11eb-97c6-20cc5cac0ad2.png)
![Screenshot 2021-06-14 034038](https://user-images.githubusercontent.com/38057565/121861512-df30af00-ccc7-11eb-89bf-4522391b4375.png)
![Screenshot 2021-06-14 034005](https://user-images.githubusercontent.com/38057565/121861514-dfc94580-ccc7-11eb-84ec-a8670f774790.png)
![Screenshot 2021-06-14 033809](https://user-images.githubusercontent.com/38057565/121861516-dfc94580-ccc7-11eb-8063-cafee5b7cf41.png)
![Screenshot 2021-06-04 160735](https://user-images.githubusercontent.com/38057565/121861519-e061dc00-ccc7-11eb-948a-bb5ff83b6d0f.png)
![Screenshot 2021-06-02 155543](https://user-images.githubusercontent.com/38057565/121861521-e061dc00-ccc7-11eb-8831-4e00f21c7303.png)
![Screenshot 2021-06-02 154955](https://user-images.githubusercontent.com/38057565/121861522-e061dc00-ccc7-11eb-9764-5c462dcca90f.png)
![Screenshot 2021-06-02 154912](https://user-images.githubusercontent.com/38057565/121861524-e061dc00-ccc7-11eb-92b8-2d2838842ccc.png)
![Screenshot 2021-06-02 154718](https://user-images.githubusercontent.com/38057565/121861525-e0fa7280-ccc7-11eb-8328-c8772be829fd.png)
![Screenshot 2021-06-02 154637](https://user-images.githubusercontent.com/38057565/121861527-e0fa7280-ccc7-11eb-988e-b74380303764.png)
![Screenshot 2021-06-02 154538](https://user-images.githubusercontent.com/38057565/121861528-e0fa7280-ccc7-11eb-897c-dfacb12a315a.png)





<!-- CONTRIBUTING -->
## Authors

Shakeel Iddrisu - [Github](https://github.com/shakeel30) - [Email](shakeelidds@gmail.com)

Awad Ahmed - [Github](https://github.com/awadahmed97)

Raymond Chan - [Github](https://github.com/ray12125)






<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.





<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
Raj Korpan - [LinkedIn](https://www.linkedin.com/in/rajkorpan)

```
