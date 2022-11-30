import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoiYmVsZW5pbmdhbGluYSIsImEiOiJjbGIxaDl5d3MxdDEyM29vNzZ2NW82ZHFwIn0.4yVR67LUcByYaCOGPHbvzw';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
    });

    super.onRequest(options, handler);
  }
}
