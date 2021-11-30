import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BlogForm extends HookWidget {
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final TextEditingController bodyController;
  final Key formKey;

  const BlogForm({
    Key? key,
    required this.formKey,
    required this.titleController,
    required this.subtitleController,
    required this.bodyController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 750.0,
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                labelText: 'Blog Title',
              ),
            ),
          ),
          Container(
            width: 750.0,
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: subtitleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.subject),
                labelText: 'Subtitle',
              ),
            ),
          ),
          Container(
            width: 750.0,
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: bodyController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.subject),
                labelText: 'Body',
              ),
              maxLines: 5,
              minLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
