# Islamic Tabu Game

A modern Flutter-based word guessing game with Islamic themes, implementing Clean Architecture principles and state-of-the-art state management.

## 🌟 Features

### Game Mechanics
- Multi-team gameplay support (2-8 teams)
- Automated team rotation system
- Dynamic scoring mechanism with penalty system
- Forbidden word violation tracking (-2 points per violation)
- Continuous gameplay until manual exit
- Pass limit system with configurable penalties

### Architecture & Technical Stack
- **Clean Architecture** implementation with distinct layers:
  - Domain Layer (entities, repository interfaces, use cases)
  - Data Layer (models, repository implementations)
  - Presentation Layer (viewmodels, UI widgets)
- **State Management**: Riverpod with StateNotifier
- **Dependency Injection**: GetIt with proper service locator pattern
- **Local Storage**: Hive for persistent data storage
- **Error Handling**: Comprehensive error states with SelectableText.rich

### User Interface
- Islamic-themed holographic design
- Dark mode optimized interface
- Responsive layout supporting multiple screen sizes
- Animated orb buttons for navigation
- Dynamic color transitions and animations
- RefreshIndicator for data refresh operations

### Game Settings
- Configurable game duration (30-180 seconds)
- Adjustable pass limits (1-5 passes)
- Customizable penalty duration (0-10 seconds)
- Word shuffling options
- Persistent settings storage

### Statistics & Analytics
- Detailed game statistics tracking
- Team performance metrics
- Success/pass ratios
- Word usage analytics
- UUID-based game session tracking
- Historical game data management

## 🛠 Technical Requirements

- Flutter SDK: Latest stable version
- Dart SDK: >=3.0.0
- iOS: 11.0 or newer
- Android: API 21 (Android 5.0) or newer

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  riverpod: ^2.0.0
  get_it: ^7.0.0
  hive: ^2.0.0
  hive_flutter: ^1.0.0
  uuid: ^3.0.0
```

## 🏗 Architecture

The project follows Clean Architecture principles with three main layers:

```
lib/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── models/
│   └── repositories/
└── presentation/
    ├── screens/
    ├── widgets/
    └── viewmodels/
```

## 🚀 Getting Started

1. Clone the repository:
```bash
git clone https://github.com/yourusername/islamic_tabu.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate Hive adapters:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
flutter run
```

## 🧪 Testing

The project includes comprehensive testing:
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for feature workflows

Run tests using:
```bash
flutter test
```

## 📱 Screenshots

[Screenshots will be added here]

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- The open-source community for their invaluable contributions
- All contributors who have helped shape this project
