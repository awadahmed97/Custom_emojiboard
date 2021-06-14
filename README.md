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

This section should list any major frameworks that you built your project using. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.
* [Flutter](https://flutter.dev/)
* [Java](https://www.java.com/en/)
* [Firebase](https://firebase.google.com/)






<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
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
