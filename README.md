# Articles Headlines App

A demo project that showcases article headlines.

## Features

- Display headlines from different news sources.
- Fetch and display article details.
- Bookmark articles for later reading.
- SwiftUI-based UI with MVVM architecture.
- Unit tests and mock data for testing view models, data store managers and utility functions.

| ![Simulator Screenshot - iPhone 15 Pro - 2024-11-05 at 20 08 59](https://github.com/user-attachments/assets/927f4c41-5474-493f-bc2f-f9f29f190be5) | ![Simulator Screenshot - iPhone 15 Pro - 2024-11-05 at 20 42 25](https://github.com/user-attachments/assets/b0c3815a-8c9f-4091-8715-f7fd5da6ee54) | ![Simulator Screenshot - iPhone 15 Pro - 2024-11-05 at 20 42 58](https://github.com/user-attachments/assets/707abb6e-e38f-49c8-be77-bbd9ad78db00) | ![Simulator Screenshot - iPhone 15 Pro - 2024-11-05 at 20 43 45](https://github.com/user-attachments/assets/2a71e696-8413-4398-aace-bd16ad4270e6) |
| - | - | - | - |

## Get Started

To get started with this project, please follow these steps:

1. **Xcode Version**:  
   **Xcode 15.2** (Xcode 16 is not available due to the developer’s macOS version — macOS Ventura).

2. **Open the Project**:  
   Open the `Demo.xcodeproj` in Xcode.

3. **Dependencies**:  
   Swift Package Manager (SPM) is used for managing dependencies. No further installation steps are required for third-party libraries.

4. **Unit Tests**:  
   Unit tests are included as part of the main `Demo` scheme.

## Architecture

This app follows a **MVVM (Model-View-ViewModel)** architecture using **SwiftUI** for building the user interface. The app is organized into two main layers:

### 1. **Presentation Layer**:
   - Responsible for controlling the UI.
   - Uses **MVVM** to manage data flow between the UI and the data layer.

### 2. **Data Layer**:
   - Handles API requests and local storage.
   - All calls to data providers (`URLSession`, `UserDefaults`, `CoreData`, etc.) are abstracted into protocols. This approach enables **dependency injection** and makes it easy to swap out data providers for testing.

## 3rd Party Libraries

This project uses the following libraries to enhance functionality:

- **[Kingfisher](https://github.com/onevcat/Kingfisher)**: For asynchronous image loading and caching.

## Notes

- **Mock & Stub**:  
  Mocks and stubs are used throughout the project to cover all view models, data store managers, and utility functions. This ensures that data flow is predictable and testable.

- **News Source Supported Languages & Regions**:  
  News Source supports sources for **English** language articles and is restricted to **Australia**.



