# Bounce Ball

An app where you can see implementation of a ball with animations. State is being managed with the help of Riverpod.

## Setup

| Name           | Version              |
| -------------- | -------------------- |
| Flutter SDK    | v3.7.3 (stable)      |
| Dart SDK       | 2.19.2               |
| Android Studio | v2022.1              |
| Xcode          | 14.3                 |
| VSCode         | v1.77.2              |

### Running the project

1. Verify your Flutter and Dart SDK versions

   Verify Flutter SDK installation

   ```bash
   flutter doctor -v
   ```

   Getting Dart SDK version

   ```bash
   dart --version
   ```

2. Clone the project

   ```bash
   https://github.com/harshkumarkhatri/Bounce-Ball.git
   ```

3. Install dependencies

   ```bash
   flutter pub get
   ```

4. Run the app

    ```bash
    flutter run
    ```

5. Run the tests

   Run all tests

   ```bash
   flutter test test
   ```

   Run specific tests

   ```bash
   flutter test test/state/reset_provider_test.dart
   ```

## Contributing Guidelines

### Project Structure

```groovy
lib/
    -screens/
        -<module_name>/ [When more than one screens for same module]
            -<screen_name>.dart
    -state/
        -<module_name>/
            -<provider_name>.dart
```

### Code structure should ideally look like the one below

```groovy
- variables (use public variables only when needed)
- state initialization logic (if any)
- widget build method
- sub-build methods (should start with _build prefix and follow invocation order)
- other methods
- utility methods 
- dispose logic (if any)
```

### Coverage
<img width="1440" alt="coverage" src="https://user-images.githubusercontent.com/42743629/233311095-122326aa-a89a-4928-bf0c-aeb68298679a.png">

### Example
https://user-images.githubusercontent.com/42743629/233310335-f7bf0a5c-575b-431f-8c3c-458a95ae31c5.mp4

#### TODO
* Spring curve animation

Try to generally follow the git-flow conventions for this.
