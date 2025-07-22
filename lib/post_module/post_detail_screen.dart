import 'package:flutter/material.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_common/post_common.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_detail_provider.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PostDetailScreen extends HookConsumerWidget {
  const PostDetailScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = useState(false);
    final titleController = useTextEditingController();
    final bodyController = useTextEditingController();
    final postAsync = ref.watch(postDetailProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
        actions: [
          IconButton(
            onPressed: postAsync.hasValue
                ? () {
                    if (postAsync is AsyncData) {
                      if (!isEditing.value) {
                        // Enter edit mode and set initial values
                        titleController.text = postAsync.value?.title ?? '';
                        bodyController.text = postAsync.value?.body ?? '';
                      }
                      isEditing.value = !isEditing.value;
                    }
                  }
                : null,
            icon: Icon(isEditing.value ? Icons.check : Icons.edit_outlined),
          ),
        ],
      ),
      body: postAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          debugPrint('Error: $error');
          return const Center(
            child: Text('Something went wrong...'),
          );
        },
        data: (postData) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text('Title', style: Theme.of(context).textTheme.headlineLarge),
              isEditing.value
                  ? TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    )
                  : Text(postData.title),
              const SizedBox(height: 10),
              Text('Body', style: Theme.of(context).textTheme.headlineLarge),
              isEditing.value
                  ? TextField(
                      controller: bodyController,
                      decoration: const InputDecoration(labelText: 'Body'),
                      maxLines: null,
                    )
                  : Text(postData.body),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      PostCommon.showCommentBottomSheet(context, ref, postData);
                    },
                    icon: const Icon(Icons.comment_outlined),
                  ),
                  isEditing.value
                      ? IconButton(
                          onPressed: () async {
                            //gives you access to the notifier instance for the current post.
                            await ref
                                .read(postDetailProvider(id).notifier)
                                .updatePost(postData.copyWith(
                                  title: titleController.text,
                                  body: bodyController.text,
                                ));
                            ref.invalidate(
                                postProvider); // to refresh the post list
                            isEditing.value = false; // Exit edit mode
                          },
                          icon: const Icon(Icons.save_outlined))
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//same function without the hookconsumerwidget

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod_tutorial/post_module/post_common/post_common.dart';
// import 'package:flutter_riverpod_tutorial/post_module/post_detail_provider.dart';
// import 'package:flutter_riverpod_tutorial/post_module/post_provider.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class PostDetailScreen extends ConsumerStatefulWidget {
//   const PostDetailScreen({super.key, required this.id});
//   final int id;

//   @override
//   ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
// }

// class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
//   late TextEditingController titleController;
//   late TextEditingController bodyController;
//   bool isEditing = false;

//   @override
//   void initState() {
//     super.initState();
//     titleController = TextEditingController();
//     bodyController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     bodyController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final postAsync = ref.watch(postDetailProvider(widget.id));
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Post Detail'),
//         actions: [
//           IconButton(
//             onPressed: postAsync.hasValue
//                 ? () {
//                     if (postAsync is AsyncData) {
//                       if (!isEditing) {
//                         titleController.text = postAsync.value?.title ?? '';
//                         bodyController.text = postAsync.value?.body ?? '';
//                       }
//                       setState(() {
//                         isEditing = !isEditing;
//                       });
//                     }
//                   }
//                 : null,
//             icon: Icon(isEditing ? Icons.check : Icons.edit_outlined),
//           ),
//         ],
//       ),
//       body: postAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stack) {
//           debugPrint('Error: $error');
//           return const Center(
//             child: Text('Something went wrong...'),
//           );
//         },
//         data: (postData) => Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               Text('Title', style: Theme.of(context).textTheme.headlineLarge),
//               isEditing
//                   ? TextField(
//                       controller: titleController,
//                       decoration: const InputDecoration(labelText: 'Title'),
//                     )
//                   : Text(postData.title),
//               const SizedBox(height: 10),
//               Text('Body', style: Theme.of(context).textTheme.headlineLarge),
//               isEditing
//                   ? TextField(
//                       controller: bodyController,
//                       decoration: const InputDecoration(labelText: 'Body'),
//                       maxLines: null,
//                     )
//                   : Text(postData.body),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       PostCommon.showCommentBottomSheet(context, ref, postData);
//                     },
//                     icon: const Icon(Icons.comment_outlined),
//                   ),
//                   isEditing
//                       ? IconButton(
//                           onPressed: () async {
//                             await ref
//                                 .read(postDetailProvider(widget.id).notifier)
//                                 .updatePost(postData.copyWith(
//                                   title: titleController.text,
//                                   body: bodyController.text,
//                                 ));
//                             ref.invalidate(postProvider);
//                             setState(() {
//                               isEditing = false;
//                             });
//                           },
//                           icon: const Icon(Icons.save_outlined))
//                       : const SizedBox.shrink(),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
