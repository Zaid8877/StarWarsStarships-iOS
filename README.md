# 🚀 StarWars Starship App

A simple iOS application built using **MVVM architecture** with **Dependency Injection**, **Protocol-Oriented Programming**, and **unit testing support**. This app demonstrates clean code practices and modular design for fetching and displaying Star Wars starship data from a remote API.

---

## 📐 Architecture

This project follows the **MVVM (Model-View-ViewModel)** design pattern:

- **Model**: Represents Starship data.
- **ViewModel**: Handles business logic and communicates with repositories.
- **Controller (View)**: Displays UI and binds to the ViewModel.
- **Repository**: Abstracts API/data source logic.
- **API Layer**: Uses `Alamofire` to interact with Star Wars API.

Dependency injection is achieved using **protocols**, enabling easy mocking and testing.

---

## 📁 Project Structure

```
📦 StarWars
├── Repository/
│   └── StarShipRepository.swift
├── Models/
│   └── Starship.swift
├── API/
│   ├── APIConfiguration.swift
│   └── StarWarsAPIService.swift
├── Starship/
│   ├── ViewModel/
│   │   └── StarshipViewModel.swift
│   └── Controller/
│       └── StarshipViewController.swift
├── AppDelegate.swift
├── SceneDelegate.swift
└── ViewController.swift
```

```
🧪 StarWarsTests/
├── Data/
│   ├── Repository/
│   │   ├── Mock/
│   │   │   └── MockStarShipRepository.swift
│   │   └── Tests/
│   │       └── StarshipViewModelTests.swift
└── StarWarsTests.swift
```

---

## 🔧 Features

- 🔌 **Dependency Injection** via protocols
- 🧪 **Mocked Repository** for testing
- ✅ **Unit Tested ViewModel**
- 📡 Uses `Alamofire` for networking
- 📦 Modular and testable design
- 🚀 Clean, scalable MVVM structure

---

## 📦 Requirements

- Xcode 14+
- iOS 13.0+
- Swift 5+
- Alamofire 5.7.1

---

## 📲 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/starwars-starship.git
   ```
2. Open `StarWars.xcodeproj` in Xcode
3. Run on a simulator or physical device

---

## 🧪 Testing

The app includes basic unit tests for the `ViewModel` using mocked repositories.

Run tests via:

```bash
⌘ + U (Command + U)
```

---

## 🤝 Contribution

Contributions, bug reports, and feature requests are welcome. Feel free to fork the repo and submit a pull request.

---

## 📄 License

This project is licensed under the MIT License.

---

Made with ❤️ by Zaid Tayyab.
