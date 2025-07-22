import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/post_module/model/post_model.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_provider.dart';

class PostCommon {
  static Future<dynamic> showAddPostDialog(BuildContext context, WidgetRef ref,
      {bool isEdit = false, Post? post}) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    if (isEdit) {
      titleController.text = post!.title;
      descriptionController.text = post.body;
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Post"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Title"),
                  controller: titleController,
                  onChanged: (value) {
                    // Handle title input
                    titleController.text = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  controller: descriptionController,
                  onChanged: (value) {
                    // Handle description input
                    descriptionController.text = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (isEdit) {
                    // edit post
                    ref.read(postProvider.notifier).updatePost(Post(
                        id: post!.id,
                        userId: post.userId,
                        title: titleController.text,
                        body: descriptionController.text));
                  } else {
                    // Add new post
                    ref.read(postProvider.notifier).addPost(Post(
                        id: Random().nextInt(10),
                        userId: Random().nextInt(10),
                        title: titleController.text,
                        body: descriptionController.text));
                  }
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  //if want to use comment.when(), need to have final commentsProvider = FutureProvider.family<List<Comment>, int>((ref, postId) {
//   return ref.read(postProvider.notifier).getCommentsByPostId(postId);
// }); in provider

  static Future<dynamic> showCommentBottomSheet(
      BuildContext context, WidgetRef ref, Post post) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: ref.read(postProvider.notifier).getCommentsByPostId(post.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No comments available'));
            } else {
              final comments = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Comments',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: comments.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.lightBlue,
                                    child: Icon(Icons.person_outline_rounded,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(comments[index].email),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(comments[index].name),
                            ],
                          ),
                          subtitle: Text(comments[index].body),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
