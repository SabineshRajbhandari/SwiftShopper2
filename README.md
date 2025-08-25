# SwiftShopper2

**SwiftShopper2** is a cross-platform shopping application developed using Flutter, designed to provide a seamless shopping experience across Android, iOS, Web, Windows, macOS, and Linux platforms.

## Features

- **Cross-Platform Compatibility**: Supports Android, iOS, Web, Windows, macOS, and Linux.
- **User Authentication**: Secure login and registration functionalities.
- **Product Management**: Add, update, and remove products from the shopping list.
- **Shopping Cart**: Add products to the cart and proceed to checkout.
- **Firebase Integration**: Utilizes Firebase for backend services.

## Folder Structure

To provide a clear understanding of the project's organization, here's the folder structure:

```plaintext
lib/
├── main.dart                         # App entry point and Firebase initialization

├── models/                          # Data classes for entities
│   ├── user.dart
│   ├── product.dart
│   ├── order.dart

├── views/                           # UI screens and reusable widgets
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── product_detail_screen.dart
│   ├── cart/
│   │   ├── cart_screen.dart
│   │   └── checkout_screen.dart
│   ├── orders/
│   │   ├── order_list_screen.dart
│   │   └── order_tracking_screen.dart
│   ├── admin/
│   │   ├── inventory_screen.dart
│   │   └── order_management_screen.dart
│   └── shared/
│       ├── product_card.dart
│       └── loading_spinner.dart

├── controllers/                    # Business logic and event handling
│   ├── auth_controller.dart
│   ├── product_controller.dart
│   ├── cart_controller.dart
│   ├── order_controller.dart
│   └── admin_controller.dart

├── services/                       # Backend integration and APIs
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   ├── notification_service.dart
│   └── payment_service.dart

├── utils/                         # Shared helpers and utility functions
│   ├── validators.dart
│   ├── constants.dart
│   └── formatters.dart

├── config/                        # App configuration files (optional)
````

*Figure: Folder structure of SwiftShopper2.*

## Architecture Overview

The app follows a modular architecture pattern, ensuring scalability and maintainability. Here's a high-level overview:



### Layers:

1. **Presentation Layer**:

   * Comprises Flutter widgets that display the UI.
   * Interacts with the ViewModel to fetch and display data.

2. **ViewModel Layer**:

   * Contains business logic and prepares data for the UI.
   * Communicates with repositories to fetch data.

3. **Repository Layer**:

   * Acts as an intermediary between the ViewModel and data sources.
   * Fetches data from Firebase Firestore and Firebase Storage.

4. **Data Sources**:

   * **Firebase Firestore**: Stores product information and user data.
   * **Firebase Storage**: Manages media files associated with products.

## Firebase Integration

SwiftShopper2 integrates with Firebase to handle authentication, data storage, and media management. The Firebase architecture is as follows:


### Components:

* **Firebase Authentication**: Manages user sign-in and registration.
* **Firebase Firestore**: Stores and retrieves product and user data.
* **Firebase Storage**: Handles storage and retrieval of media files.

## Installation

### Prerequisites

Ensure you have the following installed:

* Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
* Dart SDK: [Install Dart](https://dart.dev/get-dart)
* Firebase CLI: [Install Firebase CLI](https://firebase.google.com/docs/cli)

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/SabineshRajbhandari/SwiftShopper2.git
   cd SwiftShopper2
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase:

   * Follow the Firebase setup instructions for each platform:

     * [Android Firebase Setup](https://firebase.flutter.dev/docs/overview#installation)
     * [iOS Firebase Setup](https://firebase.flutter.dev/docs/overview#installation)
     * [Web Firebase Setup](https://firebase.flutter.dev/docs/overview#installation)
     * [Windows Firebase Setup](https://firebase.flutter.dev/docs/overview#installation)
     * [macOS Firebase Setup](https://firebase.flutter.dev/docs/overview#installation)
     * [Linux Firebase Setup](https://firebase.flutter.dev/docs/overview#installation)

4. Run the application:

   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your proposed changes.

