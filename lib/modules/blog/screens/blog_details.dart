import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:reddit_clone/widgets/navbar.dart';
import 'package:beamer/beamer.dart';
import 'package:reddit_clone/providers/posts_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reddit_clone/models/models.dart';

class BlogDetailsPage extends HookWidget {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? body;

  const BlogDetailsPage(
      {Key? key,
      required this.id,
      required this.title,
      required this.subtitle,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postProvider = useProvider(postProvider);
    String blogId = Beamer.of(context)
        .currentBeamLocation
        .state
        .pathParameters['blog_id']
        .toString();

    _loadPost() {
      try {
        _postProvider.readPost(id: blogId);
      } catch (error) {
        throw Exception(error);
      }
    }

    useEffect(() {
      _loadPost();
      BeamPage(title: "test", child: const Text("test"));
    }, []);

    return Scaffold(
      appBar: CustomMainAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[700],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2,
                )
              ],
            ),
            constraints: const BoxConstraints.expand(
              width: 750.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    _postProvider.post.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    _postProvider.post.subtitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(_postProvider.post.body),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
