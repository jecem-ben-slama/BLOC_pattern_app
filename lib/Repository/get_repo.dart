// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import '../Model/get_model.dart';

class GetRepo {
  final Dio dio = Dio();

  GetRepo() {
    final interceptor = InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST[${options.method}] => ${options.uri}');
        return handler.next(options);
      },
      onError: (DioException err, handler) {
        print('ERROR[${err.response?.statusCode}] => ${err.message}');
        return handler.next(err);
      },
      onResponse: (response, handler) {
        print('RESPONSE[${response.statusCode}] => ${'Data retrieved Succ'}');
        return handler.next(response);
      },
    );
    dio.interceptors.add(interceptor);
  }

  Future<List<GetModel>?> fetchAPI() async {
    List<GetModel> posts = [];
    try {
      var response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      final list = response.data as List;
      posts = list.map((post) => GetModel.fromJson(post)).toList();
    } on DioException catch (dioError) {
      print('DioError: ${dioError.message}');
      rethrow;
    } catch (error) {
      print('General error: ${error.toString()}');
    }
    return posts;
  }
}
