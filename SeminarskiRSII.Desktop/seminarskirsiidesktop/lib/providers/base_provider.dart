class BaseProvider {
  // static String baseUrl = "https://localhost:7113/api";
static String baseUrl = const String.fromEnvironment("baseUrl", defaultValue: "http://10.0.2.2:8080/api");
}
