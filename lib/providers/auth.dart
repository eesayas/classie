import '../exports.dart';

Future<Map<String, String>> tokenConfig() async {
  String token = await storage.read(key: "jwt");
  final Map<String, String> headers = {
    "Content-type": "application/json",
    "x-auth-token": token
  };

  return headers;
}
