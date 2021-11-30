import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reddit_clone/widgets/navbar.dart';
import 'package:reddit_clone/modules/blog/components/blog_components.dart';
import 'package:reddit_clone/providers/posts_provider.dart';
import 'package:beamer/beamer.dart';

class BlogPage extends HookWidget {
  const BlogPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postProvider = useProvider(postProvider);
    final _postTitleController = useTextEditingController();
    final _postSubtitleController =
        useTextEditingController();
    final _postBodyController = useTextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomMainAppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 750,
          ),
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = _postProvider.posts[index];

                    return InkWell(
                      child: PostTile(post: post),
                      onTap: () {
                        Beamer.of(context).beamToNamed(
                          '/blogs/${post.id}',
                          data: {
                            'title': post.title,
                            'subtitle': post.subtitle,
                            'body': post.body,
                          },
                        );
                      },
                    );
                  },
                  childCount: _postProvider.posts.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Post a blog"),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text("Post"),
                    onPressed: () {
                      if (_formKey.currentState!
                          .validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                              content: Text('Blog Posted')),
                        );

                        _postProvider.addPost(
                          body: _postBodyController.text,
                          title: _postTitleController.text,
                          subtitle:
                              _postSubtitleController.text,
                        );

                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Discard'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ],
                content: BlogForm(
                  formKey: _formKey,
                  titleController: _postTitleController,
                  subtitleController:
                      _postSubtitleController,
                  bodyController: _postBodyController,
                ),
              );
            },
          );
        },
        tooltip: "Add a blog",
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey[700],
      ),
    );
  }
}
