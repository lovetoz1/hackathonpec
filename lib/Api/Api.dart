import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Api {
  late Dio _dio;

  final baseUrl = "https://radiant-cliffs-10482.herokuapp.com";

  Api() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
    initializeInterceptors(); //initializing interceptors
  }

  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    Response res;
    res = await _dio.get(endpoint, queryParameters: body);
    return res;
  }

  Future<Response> post({
    required String endpoint,
    required var data,
  }) async {
    Response res = await _dio.post(endpoint, data: data);
    return res;
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          User? user = FirebaseAuth.instance.currentUser;
          String? token = await user?.getIdToken();
          print(token);
          //adding firebase token on request so we can verify at backend.
          request.headers = {
            "authorization": "Bearer $token",
          };
          return handler.next(request);
        },
      ),
    );
  }

  Future<Image> ImageFromUrl(String url) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? token = await user?.getIdToken();

    return Image.network("$baseUrl$url", headers: {
      "authorization":"Bearer $token"
    });
  }

  Future<NetworkImage> networkImageFromUrl(String url) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? token = await user?.getIdToken();

    return NetworkImage("$baseUrl$url", headers: {
      "authorization":"Bearer $token"
    });
  }
}
