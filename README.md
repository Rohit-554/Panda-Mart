# **Panda-Mart**

Panda-Mart is a Flutter-based e-commerce application designed for seamless and dynamic product browsing. It supports categories such as beauty products, furniture, food, and beverages. The app integrates Firebase services to provide real-time updates, notifications, and remote configuration management.

## **Table of Contents**

- [Tech Stack](#tech-stack)
- [Features](#features)
- [Installation](#installation)
- [Firebase Setup](#firebase-setup)
- [Usage](#usage)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## **Tech Stack**

- **Framework**: Flutter (Dart)
- **Backend Services**: Firebase (Authentication, Firestore, Cloud Messaging, Remote Config)
- **State Management**: Provider
- **Architecture**: Clean Architecture (Domain, Data, Presentation Layers)
- **Platform Support**: iOS and Android

## **Features**

- Dynamic product listing based on categories.
- Remote configuration using Firebase Remote Config for displaying pricing dynamically.
- Integration with Firebase Firestore for real-time data fetching and updates.

## **Installation**

### Prerequisites

- Flutter SDK installed (>= 3.0.0)
- Firebase CLI installed
- Android Studio or Xcode for building Android/iOS versions

### Steps

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/panda-mart.git
   ```
2. **Navigate to the Project Directory**:
   ```bash
   cd panda-mart
   ```
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Configure Firebase**:
   Follow the [Firebase Setup](#firebase-setup) section below to set up your Firebase project.

5. **Run the App**:
   ```bash
   flutter run
   ```

## **Firebase Setup**

### Step 1: **Create a Firebase Project**

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Click on **Add Project** and enter your project name (e.g., `Panda-Mart`).
3. Follow the steps to complete the project creation.

### Step 2: **Add Android and iOS Apps**

1. **Add Firebase to your Android App**:
   - Download the `google-services.json` file and place it in the `android/app/` directory.
2. **Add Firebase to your iOS App**:
   - Download the `GoogleService-Info.plist` file and place it in the `ios/Runner/` directory.

### Step 3: **Set Up Firebase Messaging**

1. In the Firebase Console, enable **Cloud Messaging**.
2. Make sure to set up your Android and iOS manifests for push notifications.

### Step 4: **Configure Firebase Remote Config**

1. In the Firebase Console, navigate to **Remote Config** and add a new parameter:
   - Key: `show_discounted_price`
   - Value: `true` or `false` (to control whether the app shows discounted prices or original prices).

## **Usage**

### Displaying Prices Based on Remote Config

- If the `show_discounted_price` parameter is set to `true`, the app calculates the discounted price using the `discountPercentage` from the API and displays it. Otherwise, it shows the original price.

### Fetching FCM Token for Testing

To test push notifications using a specific device, obtain the FCM token using:

```dart
FirebaseMessaging.instance.getToken().then((token) {
  print("FCM Token: $token");
});
```

## **Screenshots**

Add some screenshots of the app here, like the home screen, product listing, and detailed product view.

## **Contributing**

We welcome contributions from the community! To contribute:

1. **Fork the repository**.
2. **Create a new branch**:
   ```bash
   git checkout -b feature/new-feature
   ```
3. **Make your changes and commit**:
   ```bash
   git commit -m "Add new feature"
   ```
4. **Push to your fork**:
   ```bash
   git push origin feature/new-feature
   ```
5. **Create a Pull Request** on the main repository.

### Guidelines

- Follow the Clean Architecture structure: Separate code into `domain`, `data`, and `presentation` layers.
- Make sure all new code is well-documented.
- Write tests for any new feature or module you add.

## **License**

Panda-Mart is licensed under the MIT License. See `LICENSE` for more details.

---
Made with love by Rohit ♥
