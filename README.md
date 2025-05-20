# MedaCare Mobile App

MedaCare Mobile App is a Flutter application for Android that enables patients to manage healthcare appointments, complete their profiles, view recommended physicians and institutions, and join telemedicine meetings. The app also features AI Assist for quick health-related queries.

## Features

- **User Authentication:** Sign up, sign in, email verification, forgot password, and reset password.
- **Profile Completion:** Guided multi-step profile completion for new users.
- **Home Dashboard:**
  - Personalized greeting with user's name.
  - Recommended physicians and institutions.
  - Specialty browsing.
- **Appointments:**
  - View upcoming and past appointments.
  - Join telemedicine meetings (with camera and microphone support).
- **Doctors & Institutions:**
  - Browse all physicians and hospitals.
  - View detailed profiles.
- **AI Assist:** Get instant answers to health-related questions.
- **Responsive UI:** Optimized for Android devices.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (3.x recommended)
- Android Studio or a real Android device

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/MedaCare-Mobile.git
   cd MedaCare-Mobile
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

### Android Permissions

- The app requests camera and microphone permissions for telemedicine meetings.

## Project Structure

```
lib/
  feature/
    Auth/           # Authentication and profile
    home/           # Home, appointments, doctors, institutions, AI Assist
  main.dart         # App entry point
  ...
```

## Key Packages Used

- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) - State management
- [`url_launcher`](https://pub.dev/packages/url_launcher) - Open meeting links in browser
- [`flutter_inappwebview`](https://pub.dev/packages/flutter_inappwebview) - In-app webview for web content
- [`intl`](https://pub.dev/packages/intl) - Date formatting
- [`intl_phone_field`](https://pub.dev/packages/intl_phone_field) - Phone number input

## Contribution

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.



---

**MedaCare Mobile App** – Empowering healthcare, one tap at a time.