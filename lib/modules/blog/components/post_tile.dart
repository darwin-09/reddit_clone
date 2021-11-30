import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reddit_clone/models/models.dart';
import 'package:reddit_clone/providers/posts_provider.dart';
import 'package:intl/intl.dart';

class PostTile extends HookWidget {
  final Post post;

  const PostTile({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postProvider = useProvider(postProvider);
    final _postTitleController =
        useTextEditingController(text: post.title);
    final _postSubtitleController =
        useTextEditingController(text: post.subtitle);
    final _postBodyController =
        useTextEditingController(text: post.body);
    final _formKey = GlobalKey<FormState>();

    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 25, vertical: 10),
        width: double.infinity,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600.0,
                  ),
                  child: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600.0,
                  ),
                  child: Text(
                    post.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600.0,
                  ),
                  child: Text(
                    post.body,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(DateFormat.jm()
                    .format(DateTime.parse(post.date))
                    .toString()),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  "Update blog ${post.id}"),
                              actions: <Widget>[
                                ElevatedButton(
                                  child:
                                      const Text("Update"),
                                  style: ElevatedButton
                                      .styleFrom(
                                    primary: Colors.amber,
                                  ),
                                  onPressed: () {
                                    if (_formKey
                                        .currentState!
                                        .validate()) {
                                      ScaffoldMessenger.of(
                                              context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Blog Updated')),
                                      );

                                      _postProvider
                                          .updatePost(
                                        id: post.id,
                                        title:
                                            _postTitleController
                                                .text,
                                        subtitle:
                                            _postSubtitleController
                                                .text,
                                        body:
                                            _postBodyController
                                                .text,
                                      );

                                      Navigator.of(context)
                                          .pop();
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  child:
                                      const Text('Discard'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop();
                                  },
                                  style: ElevatedButton
                                      .styleFrom(
                                    primary: Colors.red,
                                  ),
                                ),
                              ],
                              content: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize:
                                      MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      width: 750.0,
                                      padding:
                                          const EdgeInsets
                                              .all(8.0),
                                      child: TextFormField(
                                        controller:
                                            _postTitleController,
                                        validator: (value) {
                                          if (value ==
                                                  null ||
                                              value
                                                  .isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        decoration:
                                            const InputDecoration(
                                          icon: Icon(
                                              Icons.title),
                                          labelText:
                                              'Blog Title',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 750.0,
                                      padding:
                                          const EdgeInsets
                                              .all(8.0),
                                      child: TextFormField(
                                        controller:
                                            _postSubtitleController,
                                        validator: (value) {
                                          if (value ==
                                                  null ||
                                              value
                                                  .isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        decoration:
                                            const InputDecoration(
                                          icon: Icon(Icons
                                              .subject),
                                          labelText:
                                              'Subtitle',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 750.0,
                                      padding:
                                          const EdgeInsets
                                              .all(8.0),
                                      child: TextFormField(
                                        controller:
                                            _postBodyController,
                                        validator: (value) {
                                          if (value ==
                                                  null ||
                                              value
                                                  .isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        decoration:
                                            const InputDecoration(
                                          icon: Icon(Icons
                                              .subject),
                                          labelText: 'Body',
                                        ),
                                        maxLines: 5,
                                        minLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.yellow,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _postProvider.deletePost(
                            id: post.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
