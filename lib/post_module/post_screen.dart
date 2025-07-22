import 'package:flutter/material.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_common/post_common.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_detail_screen.dart';
import 'package:flutter_riverpod_tutorial/post_module/model/post_model.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostScreen extends ConsumerWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Riverpod Async Post'),
        ),
        body: postList.when(
          data: (post) {
            return showPostList(post, ref);
          },
          error: (error, stackTrace) {
            debugPrint('Error: $error');
            return const Center(
              child: Text('Something went wrong...'),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            PostCommon.showAddPostDialog(context, ref);
          },
          tooltip: 'Fetch Posts',
          child: const Icon(Icons.add),
        ));
  }

  ListView showPostList(List<Post> post, WidgetRef ref) {
    return ListView.builder(
      itemCount: post.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PostDetailScreen(
                      id: post[index].id,
                    )));
          },
          child: Card(
            child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    child:
                        Icon(Icons.person_outline_rounded, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(post[index].title)),
                  PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ];
                      },
                      onSelected: (value) {
                        if (value == 'edit') {
                          // Handle edit action
                          PostCommon.showAddPostDialog(context, ref,
                              isEdit: true, post: post[index]);
                        } else if (value == 'delete') {
                          // Handle delete action
                          ref
                              .read(postProvider.notifier)
                              .deletePost(post[index].id);
                        }
                      })
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(post[index].body),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              PostCommon.showCommentBottomSheet(
                                  context, ref, post[index]);
                            },
                            icon: const Icon(Icons.comment_outlined)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
