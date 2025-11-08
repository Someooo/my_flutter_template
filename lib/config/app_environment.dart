// Represents runtime environment configuration such as base URLs and versions.

class AppEnvironment {
  AppEnvironment({required this.apiBaseUrl});

  final String apiBaseUrl;

  static AppEnvironment dev() => AppEnvironment(apiBaseUrl: 'https://api.dev.example.com');
}
