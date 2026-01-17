# SoulSensei App

A SwiftUI demo application showcasing MVVM architecture, async networking, and modern iOS development practices.

## Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern with clear separation of concerns:

```
SoulSenseiApp/
├── Models/
│   └── Models.swift          # Codable data models (APIResponse, Rail, FAQ, etc.)
├── ViewModels/
│   └── MainViewModel.swift   # Business logic and state management
├── Views/
│   ├── ContentView.swift     # Main container view
│   └── Components/
│       ├── CarouselView.swift      # Horizontal carousel container
│       ├── CarouselCardView.swift  # Individual carousel card
│       ├── FAQView.swift           # FAQ section container
│       ├── FAQItemView.swift       # Expandable FAQ item
│       ├── AsyncImageView.swift    # Async image loading component
│       ├── LoadingView.swift       # Loading state UI
│       └── ErrorView.swift         # Error state UI with retry
├── Services/
│   └── NetworkService.swift  # Async/await networking layer
├── Utilities/
│   └── Constants.swift       # App-wide constants (colors, fonts, layout)
└── Preview Content/
    └── Preview Assets.xcassets
```

### Key Architecture Decisions

1. **Strict MVVM**: All business logic resides in ViewModels. Views are purely declarative.
2. **Protocol-based Networking**: `NetworkServiceProtocol` enables easy mocking for previews and testing.
3. **State Management**: Uses `@Published` properties with Combine for reactive updates.
4. **Dependency Injection**: ViewModels accept network service via initializer.

## Features

### 1. Horizontal Carousel
- Swipeable card carousel using `ScrollView` with `scrollTargetBehavior`
- Fade animation on inactive cards (opacity + scale)
- Page indicator dots
- Displays mentor images, names, and short descriptions

### 2. FAQ Section
- Expandable/collapsible question-answer pairs
- Smooth spring animation on expand/collapse
- All FAQs collapsed by default
- Clean, minimal design

### 3. Loading & Error States
- Loading spinner while fetching data
- Error view with retry button
- Graceful error handling

## Requirements

- **Xcode**: 15.0+
- **iOS**: 17.0+
- **Swift**: 5.9+

## How to Run

1. Clone the repository
2. Open `SoulSenseiApp.xcodeproj` in Xcode
3. Select a simulator or device (iOS 17+)
4. Press `Cmd + R` to build and run

No external dependencies required.

## API

The app fetches data from:
```
https://gist.githubusercontent.com/sanjeevworkstation/c27e6cc85b7d4bcaf8ec73d96a0ae25b/raw/4a2ce8c5215f2d7a7201338a6af49a77c0f81f6a/assignment.json
```

### Response Structure
```json
{
  "data": {
    "rail": {
      "name": "1 on 1",
      "items": [...],
      "bgImage": "..."
    },
    "railPageFaqs": [...]
  }
}
```

## Code Quality

- No hardcoded values (uses `Constants.swift`)
- Reusable SwiftUI components
- Clean naming conventions
- Production-ready error handling
- SwiftUI previews for all components

## Extending the App

### Adding New Carousel Types
1. Create new model conforming to `Identifiable`
2. Create card view component
3. Reuse `CarouselView` pattern with new data type

### Adding New API Endpoints
1. Add method to `NetworkServiceProtocol`
2. Implement in `NetworkService`
3. Add mock implementation in `MockNetworkService`

## License

This project is for demonstration purposes.
