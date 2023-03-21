import 'package:dio/dio.dart';
import 'package:dio_tutorial/models/posts.dart';

import 'api.dart';

class Service {
  static final _singleton = Service._internal();
  factory Service() => _singleton;

  Service._internal();

  Future<List<Post>> getPosts() async {
    var response = await Api().dio.get<String>("/posts");
    return postFromJson(response.data ?? "");
  }
}
