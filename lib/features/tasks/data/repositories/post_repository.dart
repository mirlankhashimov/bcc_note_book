import 'package:bcc_note_book/features/tasks/data/dtos/post_dto.dart';
import 'package:dio/dio.dart';

import '../../presentation/dvo/note.dart';

abstract class PostRepository {
  Future<List<PostDto>> getPostsData();

  Future<void> addPost(Note note);
}

class PostRepositoryImpl extends PostRepository {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    headers: {'Authorization': 'Bearer 123456', 'charset': 'UTF-8'},
    contentType: 'application/json',
  ));

  @override
  Future<List<PostDto>> getPostsData() async {
    Response response = await dio.get("/users/1/posts");
    return (response.data as List)
        .map((post) => PostDto.fromJson(post))
        .toList();
  }

  @override
  Future<void> addPost(Note note) async {
    final post = PostDto(
        title: note.title,
        userId: 1,
        body: "body");
    Response response = await dio.post("/users/1/posts", data: post.toJson());
  }

/**
 *
 * Response response = await dio.get('/users');
    // Make a POST request
    Response response = await dio.post('/users', data: {'name': 'John'});
    // Make a PUT request
    Response response = await dio.put('/users/1', data: {'name': 'Jane'});
    // Make a DELETE request
    Response response = await dio.delete('/users/1');
 * */
}
