// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://newsapi.org';
  final Dio dio;
  ApiService(this.dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await dio.get('$_baseUrl$endPoint');
    return response.data;
  }
  // Future<Map<String, dynamic>> getForComment({required String endPoint}) async {
  //   var commentResponse = await dio.get('$_commentUrl$endPoint');
  //   return commentResponse.data;
  // }
}
