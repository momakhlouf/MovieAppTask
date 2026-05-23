#  Movies App

A modular iOS application that displays trending movies with offline support, built with SwiftUI, Combine, and Clean Architecture.

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 - 2026-05-23 at 23 01 10" src="https://github.com/user-attachments/assets/ac62b1ba-8704-4843-858d-7618e975e975" /><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 - 2026-05-23 at 22 59 17" src="https://github.com/user-attachments/assets/5a579da6-b347-43f3-87a6-5c816c9c3738" /><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 - 2026-05-23 at 22 59 07" src="https://github.com/user-attachments/assets/65b1ed5c-bbc8-4a6c-88dc-0b1971d5ec02" />



---

## Features

- **Movies List** with infinite pagination
- **Local Search** to filter movies 
- **Genre Filter Chips** to filter movies by category
- **Movie Details Screen** with a stretched header image
- **Offline Support** via local caching with Realm
- **Coordinator-based Navigation** using `NavigationPath`

---

## Architecture

The app follows **Clean Architecture** with **MVVM** as the presentation pattern, and is fully **modularized** using Swift Package Manager.

## Modularization

The project is split into independent Swift packages:

| Module | Responsibility |
|---|---|
| `Networking` | Generic HTTP client, API request handling, error mapping |
| `DesignSystem` | reusable UI components |
| `Commons` | Shared utilities, extensions |
| `MoviesList` | Movies list screen — ViewModel, Views, Use Case, Repository |
| `MovieDetails` | Movie details screen — ViewModel, Views, Use Case, Repository |
