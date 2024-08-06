abstract class BaseNetwork {
  Future<Map<String, dynamic>?> get(
      {required String url,
      dynamic query,
      required Map<String, String> header});
  Future<Map<String, dynamic>?> post({
    required String url,
    required dynamic body,
    required Map<String, String> header,
    dynamic query,
  });
}
