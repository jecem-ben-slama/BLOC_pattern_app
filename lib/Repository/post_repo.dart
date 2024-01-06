// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

import '../Model/post_model.dart';

class PostRepo {
  final Dio dio = Dio(); 

  PostRepo() {
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
        print('RESPONSE[${response.statusCode}] => ${response.statusMessage}');
        return handler.next(response);
      },
    );
    dio.interceptors.add(interceptor);
  }

  Future<PostModel> createPost(PostModel postModel) async {
    try {
      final response = await dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: postModel.toJson(),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.data;
        print('Post creation successful');
        return PostModel.fromJson(data);
      } else {
        print('Post creation failed with status code: ${response.statusCode}');
        throw Exception('Failed to create post');
      }
    } catch (error) {
      print('Exception during post creation: $error');
      throw Exception('Failed to create post: $error');
    }
  }
}
