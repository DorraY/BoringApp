This project was developped on a Ubuntu 20.04 LTS system using Flutter 3.7.8 channel stable and Dart 2.19.5

## Environment setup

- For installing Flutter on a Unix like system please refer to the following [link](https://docs.flutter.dev/get-started/install/linux)

- For installing Flutter on a macOS system please refer to the following [link](https://docs.flutter.dev/get-started/install/macos)

## Cloning the project

- git clone https://github.com/DorraY/BoringApp


## Running the project on Android

- cd into the project directory
- Attach an Android smartphone by USB and make sure it has developer options and USB debugging authorized.
- Run **adb devices** to get the id of the smartphone
- Run **flutter run -d phoneId**

You can also turn use an Android emulator.
- Open **Android Studio Device Manager** and turn on the desired emulator.
- Get emulator ID with **adb devices**
- Run **flutter run -d emulatorID**

## Running the project on iOS

You would need a macOS computer containing Flutter and xcode.


- cd into the project directory
- Attach an iPhone by USB and please refer to the following [link](https://medium.com/front-end-weekly/how-to-test-your-flutter-ios-app-on-your-ios-device-75924bfd75a8) to allow the application to install on your phone.
- Run **adb devices** to get the id of the iPhone
- Run **flutter run -d iPhoneID**

You could also use a iOs emulator.
- To get a list of the available emulators **xcrun simctl list** witht their UDIDs
- Turn on the desired emulator **xcrun simctl boot UDID**
- Run **flutter run -d UDID**
