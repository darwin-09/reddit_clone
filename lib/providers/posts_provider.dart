import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reddit_clone/models/models.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final postProvider =
    ChangeNotifierProvider<PostNotifier>((ref) {
  return PostNotifier();
});

class PostNotifier extends ChangeNotifier {
  List<Post> _posts = [
    Post(
      id: '1',
      title: 'title 1',
      subtitle: 'subtitle 1',
      body: 'body 1',
      date: DateTime.now().toString(),
    ),
    Post(
      id: '2',
      title: 'title 2',
      subtitle: 'subtitle 2',
      body: 'body 2',
      date: DateTime.now().toString(),
    ),
    Post(
      id: '3',
      title: 'title 3',
      subtitle: 'subtitle 3',
      body: 'body 3',
      date: DateTime.now().toString(),
    ),
    Post(
      id: '4',
      title: 'title 4',
      subtitle: 'subtitle 4',
      body: 'body 4',
      date: DateTime.now().toString(),
    ),
  ];

  Post _post = Post(
    id: 'default',
    title: 'default',
    subtitle: 'default',
    body: 'default',
    date: DateTime.now().toString(),
  );

  List<Post> get posts => _posts;
  Post get post => _post;

  // Add BLOG POST
  Future<void> addPost({
    required String body,
    required String title,
    required String subtitle,
  }) async {
    final newTodo = Post(
      id: uuid.v1(),
      title: title,
      subtitle: subtitle,
      body: body,
      date: DateTime.now().toString(),
    );
    _posts = [..._posts, newTodo];
    notifyListeners();
  }

  void readPost({required String id}) async {
    int index = _posts.indexWhere((post) => post.id == id);
    _post = _posts[index];
    notifyListeners();
  }

  // Update BLOG POST

  Future<void> updatePost({
    required String id,
    required String title,
    required String subtitle,
    required String body,
  }) async {
    int index = _posts.indexWhere((post) => post.id == id);

    _posts[index].title = title;
    _posts[index].subtitle = subtitle;
    _posts[index].body = body;

    // update the element with the index

    notifyListeners();
  }

  // Remove BLOG POST
  Future<void> deletePost({required String id}) async {
    _posts.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
