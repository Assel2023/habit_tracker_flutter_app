# Habit Tracker - A Flutter Habit Building App

![Habit Tracker App Banner](URL_TO_YOUR_BANNER_IMAGE) <!-- Optional: Add a cool banner image here -->

A feature-rich, cross-platform mobile application built with Flutter to help users build, track, and analyze their habits. The app features a modern Glassmorphism UI, advanced statistics, flexible scheduling, and full localization support.

---

## ✨ Features

- ** Modern & Clean UI:** A beautiful and intuitive interface built with a consistent **Glassmorphism** design language.
- ** Light & Dark Mode:** Seamless theme switching with user preference saved locally.
- ** Advanced Statistics:** Visualize your progress with a yearly **heatmap** and weekly performance **bar charts**.
- ** Habit Challenges:** Set time-bound goals (e.g., 30-day challenge) and track your progress with a progress bar.
- ** Flexible Scheduling:** Create daily habits or schedule them for specific days of the week.
- ** Categories:** Organize your habits into custom categories with unique names and colors.
- ** Daily Reminders:** Schedule local notifications to never miss a habit.
- ** Celebratory Animations:** A fun confetti animation celebrates when you complete all habits for the day.
- ** Localization:** Full support for **English** and **Arabic**, adapting automatically to the device language.
- ** Local Storage:** All data is stored securely on the device using the **Hive** database.

---

## 📸 Screenshots

| Light Mode | Dark Mode |
| :---: | :---: |
| ![Light Mode Screenshot 1](![Image](https://github.com/user-attachments/assets/9b299cce-93bf-4ade-8a0c-3c42d3113141)
) | ![Dark Mode Screenshot 1](![Image](https://github.com/user-attachments/assets/5d397c8a-8f10-45d6-8d0c-81fe08cd4ca3)) |
| *Home Screen* | *Home Screen (Dark)* |
| ![Light Mode Screenshot 2](![Image](https://github.com/user-attachments/assets/a9945b0d-d683-461c-9b0d-d3e2a860c7bf)
) | ![Dark Mode Screenshot 2](![Image](https://github.com/user-attachments/assets/413bd3f4-ffe8-422e-b966-100dbe69a4cf)) |
| *Statistics Screen* | *Statistics Screen (Dark)* |
| ![Light Mode Screenshot 3](![Image](https://github.com/user-attachments/assets/3fb8669b-eb93-41ca-ac7f-9299ddc53314)
) | ![Dark Mode Screenshot 3](![Image](https://github.com/user-attachments/assets/15262871-f227-42ee-b416-dddd0be69792)
) |
| *Add Habit Screen* | *Add Habit Screen (Dark)* |

---

##  Tech Stack & Architecture

This project follows a clean architecture approach to ensure scalability and maintainability.

- **Framework:** [Flutter](https://flutter.dev/)
- **Language:** [Dart](https://dart.dev/)
- **State Management:** [Provider](https://pub.dev/packages/provider) - For robust and simple state management.
- **Database:** [Hive](https://pub.dev/packages/hive) - A lightweight and fast NoSQL database for local storage.
- **Charting:** [fl_chart](https://pub.dev/packages/fl_chart) - For beautiful and interactive charts.
- **Localization:** [intl](https://pub.dev/packages/intl) & Flutter's built-in `gen-l10n`.
- **Notifications:** [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications).
- **UI:** Custom widgets, `smooth_page_indicator`, `confetti`, `flutter_heatmap_calendar`.

---

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)

### Installation

1.  **Clone the repo**
    ```sh
    git clone https://github.com/Assel2023/habit_tracker_flutter_app.git
    ```
2.  **Navigate to the project directory**
    ```sh
    cd habit_tracker_flutter_app
    ```
3.  **Install dependencies**
    ```sh
    flutter pub get
    ```
4.  **Generate localization and Hive files**
    ```sh
    flutter gen-l10n
    dart run build_runner build --delete-conflicting-outputs
    ```
5.  **Run the app**
    ```sh
    flutter run
    ```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.