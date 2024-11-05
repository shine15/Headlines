# Articles Headlines App

A demo project that showcases article headlines.

## Features

- Display headlines from different news sources.
- Fetch and display article details.
- Bookmark articles for later reading.
- SwiftUI-based UI with MVVM architecture.
- Unit tests and mock data for testing view models, data store managers and utility functions.

| ![Simulator Screenshot - iPhone 15 Pro - 2024-11-05 at 20 08 59](https://github.com/user-attachments/assets/96bd5a67-9820-44b4-8795-39c5f6158e94) | ![Simulator Screenshot - iPhone 15 Pro - 2024-11-05 at 20 42 25](https://github.com/user-attachments/assets/705abc84-9e94-424c-8226-101f67c922d1) | ![Simulator Screenshot - iPhone 15 Pro - 2024-11-05 at 20 42 58](https://github.com/user-attachments/assets/b87b0f23-a22a-4bc4-befb-11797e7633ac) | ![Simulator Screenshot - iPhone 15 Pro - 2024-11-05 at 20 43 45](https://github.com/user-attachments/assets/13411ed8-8a13-4abd-9d0a-626342996ca1) |
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



