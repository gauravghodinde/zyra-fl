# Zyra Fashion Marketplace

A modern fashion e-commerce mobile application built with Flutter, showcasing a seamless shopping experience with elegant UI design and robust functionality.

![Zyra Logo](assets/logo.png)

## 📱 Features

### Core Features
- **Splash Screen**: Engaging landing page with Zyra branding and smooth animations
- **Authentication**: Mobile number-based OTP authentication system
- **Product Catalog**: Grid/List view of fashion products with search functionality
- **Product Details**: Detailed product view with size selection and cart integration
- **Persistent Login**: Maintains user session across app restarts

### Additional Features
- Dark Mode Support
- Session Management
- Responsive Design
- Custom Animations

## 🛠️ Project Structure

```
lib/
├── api/                    # API related files
├── components/            # Reusable UI components
│   ├── app/              # App-wide components
│   ├── location/         # Location related components
│   └── product/          # Product related components
├── model/                # Data models
├── pages/                # Main screen implementations
│   ├── home/            # Home screen
│   ├── location/        # Location screens
│   ├── login/           # Authentication screens
│   └── product/         # Product related screens
├── providers/           # State management
├── services/           # Business logic and services
└── utils/             # Helper functions and constants
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (Latest Version)
- Android Studio / VS Code
- Android SDK
- iOS Developer Tools (for Mac)

### Installation

1. Clone the repository
```bash
git clone https://github.com/gauravghodinde/zyra-fl.git
```

2. Navigate to project directory
```bash
cd zyra-fl
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## 🔐 Authentication Flow

1. Launch Screen (3 seconds)
2. Login Screen (if not authenticated)
   - Enter mobile number
   - Receive OTP (static: "1234")
   - Verify OTP
3. Product Listing Screen

## 📱 Screen Details

### Landing Page (Splash Screen)
- Displays Zyra branding
- Non-skippable 3-second duration
- Progress indicator
- Automatic navigation to next screen

### Login Screen
- Mobile number input with validation
- OTP verification system
- Error handling for invalid inputs
- Session management

### Product Listing Screen
- Grid/List view toggle
- Search functionality
- Product cards with:
  - Product image
  - Name
  - Brand
  - Price
- Floating action button for view toggle

### Product Detail Screen
- Large product image
- Detailed product information
- Size selector (S, M, L, XL)
- Add to Cart functionality
- Back navigation

## 🔧 State Management

The app uses Provider for state management, organizing the application state into:
- AuthProvider
- CategoryProvider
- LocationListProvider
- ProductProvider
- UserProvider

## 🎨 UI Components

Custom components are organized in the `components` directory:
- LocationCard
- ProductCard
- OverlayRackBar
- Custom Alerts
- Loading Indicators

## 🔍 Testing

To run the tests:
```bash
flutter test
```

## 📦 Dependencies

Key packages used in this project:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  shared_preferences: ^2.0.0
  http: ^0.13.0
  # Add other dependencies from pubspec.yaml
```

## 🤝 Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Gaurav Ghodinde** - *Initial work* - [gauravghodinde](https://github.com/gauravghodinde)

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Material Design for the design guidelines
- All contributors who helped in building this project
