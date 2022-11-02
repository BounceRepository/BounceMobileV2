abstract class IApi {
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
  });
  Future<dynamic> post(
    String url, {
    required dynamic body,
    Map<String, String>? headers,
    bool isFormData = false,
  });
  Future<dynamic> put(
    String url, {
    required dynamic body,
    Map<String, String>? headers,
  });
  Future<dynamic> patch(
    String url, {
    required dynamic body,
    Map<String, String>? headers,
    bool isFormData = false,
  });
  Future<dynamic> delete({required String url});
}
