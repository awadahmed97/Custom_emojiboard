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


<p float="left">
  <img src="https://user-images.githubusercontent.com/38057565/121862195-93323a00-ccc8-11eb-98ef-4d04dfa98baf.png" width="200" />
  <img src="https://user-images.githubusercontent.com/38057565/121862254-a34a1980-ccc8-11eb-9701-13d37fa5ac2c.png" width="200" /> 
  <img src="https://user-images.githubusercontent.com/38057565/121862268-a6450a00-ccc8-11eb-9961-6efa32c817e7.png" width="200" />
</p>

![Screenshot 2021-06-02 155543]()
![Screenshot 2021-06-02 154637]()
![Screenshot 2021-06-02 154718](https://user-images.githubusercontent.com/38057565/121862288-a93ffa80-ccc8-11eb-9245-0bb01b89fc56.png)
![Screenshot 2021-06-02 154912](https://user-images.githubusercontent.com/38057565/121862294-ab09be00-ccc8-11eb-8705-b4bae4dd8c7e.png)
![Screenshot 2021-06-02 154955](https://user-images.githubusercontent.com/38057565/121862317-b230cc00-ccc8-11eb-9c15-22fbedc68ff3.png)
![Screenshot 2021-06-14 034005](https://user-images.githubusercontent.com/38057565/121862391-c379d880-ccc8-11eb-8e64-431d87e9779f.png)
![Screenshot 2021-06-14 033809](https://user-images.githubusercontent.com/38057565/121862403-c674c900-ccc8-11eb-8011-1b21516cc09d.png)
![Screenshot 2021-06-14 034038](https://user-images.githubusercontent.com/38057565/121862409-c7a5f600-ccc8-11eb-981b-9e7fe09c3cd0.png)
![Screenshot 2021-06-14 034538](https://user-images.githubusercontent.com/38057565/121862519-dd1b2000-ccc8-11eb-9d69-2a2781410361.png)
![Screenshot 2021-06-14 035153](https://user-images.githubusercontent.com/38057565/121862579-ee642c80-ccc8-11eb-8cda-2d762891f9e9.png)
![Screenshot 2021-06-02 154413](https://user-images.githubusercontent.com/38057565/121862605-f6bc6780-ccc8-11eb-9c5e-f65f807da635.png)





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
