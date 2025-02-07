# TaskFlow

## 📝 Task Management App

## 📌 Overview
The **Task Management App** is a simple and efficient Flutter-based mobile application that allows users to add, edit, delete, and manage their tasks seamlessly. It supports **light & dark mode**, **search functionality**, and **tablet-responsive design**.

## 🚀 Features
### ✅ Task Management
- Add, Edit, and Delete tasks easily.
- Supports long-press to delete with a confirmation dialog.

### 🔍 Search Functionality
- Search for tasks using a dynamic search bar.

### 📱 Responsive Design
- Optimized for both **Mobile & Tablet**.
- In **Tablet View**, the task title appears on the left and the description on the right.

### 🌙 Theme Mode
- Toggle between **Light Mode** and **Dark Mode**.

## 🏗️ Tech Stack
- **Flutter** (Dart)
- **Riverpod** (State Management)
- **SQLite & Hive** (Local Storage & Preferences)
- **MVVM Architecture** (Clean Code Structure)

## 📸 Screenshots
| Light Mode  | Dark Mode | Search |
|------------|------------|------------| 
| ![lightmode](https://github.com/user-attachments/assets/10f73eff-5652-4062-b1c9-4a14460965c7) | ![darkmode](https://github.com/user-attachments/assets/8dd69f75-339e-40e3-99ce-1dd20dd04ba8) | ![search](https://github.com/user-attachments/assets/ea7b96e6-9548-4ae0-90b2-9489105960c2) |

| Add Task  | Edit Task | Delete Task |
|------------|------------|------------| 
| ![addtask](https://github.com/user-attachments/assets/fdd14484-1923-429f-8389-7e162814472e) | ![edittask](https://github.com/user-attachments/assets/6b69d295-c3f9-48f7-bf60-b4b6be15c57a) | ![deletetask](https://github.com/user-attachments/assets/50615882-9e8f-4b38-ba74-c991d55281b0) |

| Tablet View |
| --- |
| ![tab view](https://github.com/user-attachments/assets/32b2b20c-e761-484e-a067-ccaeef5356aa) |

## 📌 How to Use?
1. Open the app and add a new task.
2. Search tasks using the search bar.
3. Tap on a task to edit it.
4. Long press a task to delete it.
5. Toggle theme using the button in the app bar.
6. Get reminders through local notifications.

## 🛠️ Project Structure
```
lib/
│-- models/       # Data models
│-- view_models/  # State management (Riverpod)
│-- screens/      # UI Screens
│-- services/     # Notification & Database Services
│-- main.dart     # Entry Point
```

## Getting Started 🚀

To get a local copy up and running follow these simple steps.

### Prerequisites ✅

Make sure you have Flutter installed on your machine. You can download it from [here](https://flutter.dev/docs/get-started/install).


### Installation 🛠️
**Clone the repository:**
```bash
  git clone https://github.com/hozefa-hs/TaskFlow.git
  cd TaskFlow
```

**Install dependencies:**
```bash
  flutter pub get
```

**Run the application:**
```bash
  flutter run
```

## Contributing 🤝

1. Fork the repository.
2. Create a new branch:
```bash
  git checkout -b feature-name
```
3. Make your changes.
4. Commit your changes:
```bash
  git commit -m 'Add some feature'
```
5. Push to the branch:
```bash
  git push origin feature-name
```
6. Open a pull request.

## Support 💖

If you like this project, please consider giving it a ⭐ on [GitHub](https://github.com/hozefa-hs/TaskFlow)!

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact 📧

Connect with me on [LinkedIn](https://www.linkedin.com/in/hozefa-sailanawala/).
For any inquiries, please [Contact me via Email](mailto:hozefawork16@gmail.com).
