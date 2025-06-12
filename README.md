# Articles Reader - Flutter Mobile App

A modern, feature-rich Flutter mobile application that displays articles fetched from a public API with a beautiful Material Design interface.

## 🚀 Features

### Core Features
- **Article List View**: Displays articles with title and snippet (first 50 characters)
- **Article Detail View**: Shows full article content with comments
- **Loading & Error States**: Proper error handling with retry functionality
- **Material Design**: Modern UI following Material Design 3 principles

### Bonus Features
- **Search Functionality**: Real-time search to filter articles by title
- **Pull-to-Refresh**: Swipe down to refresh the article list
- **Local Caching**: Articles cached locally using SharedPreferences (5-minute validity)
- **Smooth Animations**: Beautiful transitions and micro-interactions
- **Dark Theme Support**: Automatic dark/light theme switching

## 🛠 Setup & Installation

### Prerequisites
- Flutter SDK (>=3.5.3)
- Dart SDK
- iOS Simulator / Android Emulator or physical device

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd recrex_interview
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Additional Commands
- **Run on specific device**: `flutter run -d <device-id>`
- **Build APK**: `flutter build apk`
- **Run tests**: `flutter test`
- **Analyze code**: `flutter analyze`

## 📚 Libraries Used

### Core Dependencies
- **provider** (^6.1.2): State management solution
- **get_it** (^7.6.4): Service locator for dependency injection
- **http** (^1.2.1): HTTP client for API calls
- **shared_preferences** (^2.2.3): Local storage for caching
- **cupertino_icons** (^1.0.8): iOS-style icons

### Development Dependencies
- **flutter_test**: Unit and widget testing
- **flutter_lints** (^4.0.0): Dart/Flutter linting rules

## 🏗 Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

### Project Structure
```
lib/
├── core/
│   ├── constants/          # App constants and configuration
│   └── utils/             # Utility functions and helpers
├── data/
│   ├── datasources/       # API service and cache service
│   ├── models/           # Data models (Article, Comment)
│   └── repositories/     # Repository implementations
├── domain/
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business logic use cases
└── presentation/
    ├── providers/        # State management (Provider)
    ├── screens/          # UI screens
    └── widgets/          # Reusable UI components
```

### Architecture Layers

1. **Presentation Layer**
   - UI screens and widgets
   - State management with Provider
   - User interaction handling

2. **Domain Layer**
   - Business logic and entities
   - Repository interfaces
   - Use cases (future extension)

3. **Data Layer**
   - API service for network calls
   - Cache service for local storage
   - Repository implementations
   - Data models with JSON serialization

## 🔧 Key Implementation Details

### State Management
- **Provider**: Chosen for its simplicity and Flutter team recommendation
- **ArticleProvider**: Manages articles, comments, loading states, and search functionality

### Dependency Injection
- **GetIt**: Service locator pattern for dependency injection
- **Services Registration**: All services registered in service locator at app startup
- **Clean Dependencies**: Clear separation between service instantiation and usage

### Caching Strategy
- **Local Storage**: SharedPreferences for article caching
- **Cache Validity**: 5-minute expiration for fresh data
- **Fallback**: Graceful fallback to API when cache is unavailable

### API Integration
- **REST API**: JSONPlaceholder API for posts and comments
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Network Resilience**: Retry mechanisms and timeout handling

### UI/UX Features
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Animations**: Smooth transitions and micro-interactions
- **Material Design 3**: Modern design system with proper theming
- **Accessibility**: Semantic labels and proper contrast ratios

## 🧪 Testing

The app includes comprehensive testing structure:

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## 📱 Screenshots

The app features:
- Clean, modern interface with card-based design
- Smooth animations and transitions
- Beautiful gradient backgrounds
- Intuitive navigation with hero animations
- Dark theme support

## 🚀 Performance Optimizations

- **Efficient List Rendering**: Using ListView.separated for optimal performance
- **Image Optimization**: Lazy loading and caching strategies
- **Memory Management**: Proper disposal of controllers and resources
- **Network Optimization**: Request debouncing and caching



