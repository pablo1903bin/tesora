import 'package:tesora/app/data/http/http_base.dart';

class MockHttpMmovil extends HttpMmovil {
  MockHttpMmovil({required super.client, required super.hostApi, required super.httpSesionService});
  /*
  MockHttpMmovil(
      {required super.client,
      required super.hostApi,
      required super.httpSesionService});

  @override
  Future<Response> execute(
      Uri url,
      HttpMethod method,
      Map<String, String> headers,
      Map<String, String> params,
      String body) async {
    final filePath = getMockFilePath(url);

    Log.debug("Mock File: $filePath");

    String mockJson = await rootBundle.loadString(filePath);

    await Future.delayed(const Duration(seconds: 1));

    return Response(mockJson, 200);
  }

  String getMockFilePath(Uri url) {
    return "assets/mock${url.path}.json";

    //return "packages/tesora/assets/mock${url.path}.json";
    //return "packages/mmovil/assets/mock${url.path}.json";
    //return "assets/mock${url.path}.json";
  }
  */
}
