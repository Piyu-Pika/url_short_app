# Url Shortener App

A Flutter application for shortening URLs.

## Overview

This app allows users to shorten long URLs into more manageable links.  It provides a user-friendly interface to create, manage, and share shortened URLs.  The app uses a remote API to handle the shortening process and stores the created URLs for easy access.

## Features

*   **URL Shortening:** Converts long URLs into shorter, shareable links.
*   **URL Listing:** Displays a list of all shortened URLs, including the original and shortened versions, click counts, and creation dates.
*   **Click Tracking:** Shows the number of clicks for each shortened URL.
*   **URL Launching:** Allows users to open the original URL from within the app.
*   **Sharing:** Enables easy sharing of shortened URLs.
*   **Error Handling:** Provides informative error messages for common issues like invalid URLs or network connectivity problems.

## Tech Stack

*   **Flutter:** For building cross-platform mobile applications.
*   **Dart:** The programming language used for Flutter development.
*   **`http` package:** For making HTTP requests to the URL shortening API.
*   **`url_launcher` package:** For launching URLs in an external browser.
*   **`share_plus` package:** For sharing the shortened URLs.

## Project Structure

```
url_short_app/
├── android/          # Android platform-specific code
├── ios/              # iOS platform-specific code
├── lib/
│   ├── api/
│   │   └── api.dart  # Manages API calls for URL shortening and retrieval.
│   ├── models/
│   │   └── url.dart  # Defines the UrlModel class.
│   ├── screens/
│   │   └── Homescreen.dart # Contains the main UI.
│   ├── main.dart     # Entry point of the Flutter application.
├── web/              # Web platform-specific code (if applicable)
├── test/
│   └── widget_test.dart  # Contains example widget tests.
├── .gitignore
├── pubspec.yaml      # Project dependencies and metadata.
├── README.md         # This file.
```

## Getting Started

1.  **Clone the repository:**

    ```bash
    git clone <repository_url>
    ```

2.  **Navigate to the project directory:**

    ```bash
    cd url_short_app
    ```

3.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

4.  **Run the app:**

    ```bash
    flutter run
    ```

    Choose the target platform (Android, iOS, or Web).

## API Endpoints

The app interacts with the following API endpoints:

*   **`GET /urls`:** Retrieves a list of all shortened URLs.
*   **`POST /shorten`:** Creates a new shortened URL for a given original URL.

## Dependencies

The `pubspec.yaml` file lists the dependencies required for this project. Some key dependencies include:

*   `flutter`: Flutter SDK
*   `http`: For making HTTP requests.
*   `url_launcher`: For launching URLs.
*   `share_plus`: For sharing content.

## Configuration

The base URL for the API is defined in `lib/api/api.dart`:

```dart
static const String baseUrl = 'localhost:8080/api';
```

## Potential Improvements

*   **UI Enhancements:** Improve the user interface for a better user experience.
*   **Error Handling:** Add more robust error handling, including specific error messages and retry mechanisms.
*   **Local Storage:** Implement local storage (e.g., using Shared Preferences or SQLite) to cache URLs and improve performance.
*   **Testing:** Add more comprehensive unit and integration tests.
*   **Analytics:** Integrate analytics to track usage and identify areas for improvement.
*   **Custom URL ID:** Allow the user to specify a custom URL ID when creating short links.

## Contributing

Contributions are welcome! Feel free to submit pull requests or open issues to suggest improvements or report bugs.

## License

[Choose a license, e.g., MIT License]

```
MIT License

Copyright (c) [2025] [com.piyush]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
