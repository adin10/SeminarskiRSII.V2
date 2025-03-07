class BaseProvider {
  // static String baseUrl = "https://localhost:7113/api";
static String baseUrl = const String.fromEnvironment("baseUrl", defaultValue: "http://localhost:8080/api");
}
