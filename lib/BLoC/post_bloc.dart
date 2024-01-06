// ignore_for_file: avoid_print

import 'package:rxdart/rxdart.dart';
import '../Model/post_model.dart';
import '../Repository/post_repo.dart';

class PostBloc {
  final PostRepo _postRepo = PostRepo();
  final _postSubject =
      BehaviorSubject<PostModel>.seeded(PostModel(id: 0, title: '', body: ''));

  Stream<PostModel> get post => _postSubject.stream;
  Stream<bool> get successStream => _successSubject.stream;

  final _successSubject = BehaviorSubject<bool>.seeded(false);

  void createPost(PostModel postModel) async {
    try {
      final createdPost = await _postRepo.createPost(postModel);
      _postSubject.add(createdPost);
      _successSubject.add(true);
    } catch (error) {
      print("Failed to create post: $error");
      _successSubject.add(false);
    }
  }

  void dispose() {
    _postSubject.close();
    _successSubject.close();
  }
}
