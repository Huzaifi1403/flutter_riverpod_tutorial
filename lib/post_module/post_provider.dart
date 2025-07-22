import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/post_module/model/comment_model.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_apihandler.dart';
import 'package:flutter_riverpod_tutorial/post_module/model/post_model.dart';

final apiServiceProvider = Provider((ref) => PostApihandler());

class PostProvider extends AsyncNotifier<List<Post>> {
  // List<Post> is the state
  @override
  Future<List<Post>> build() async {
    //In build(), Riverpod handles loading/error/data for you.
    return await ref.read(apiServiceProvider).getPosts();
  }

  Future<void> addPost(Post post) async {
    state = const AsyncValue
        .loading(); // Set the state to loading (provided by riverpod)
    state = await AsyncValue.guard(
      () async {
        final newPost = await ref.read(apiServiceProvider).createPost(post);
        return [...state.value ?? [], newPost];
      },
      (p0) {
        // Handle error if needed
        print('Error creating post: $p0');
        throw p0;
      },
    );
  }

  // Future<Post> getPostById(int id) async {
  //   //In custom methods, you must manage the state transitions yourself.
  //   final post = await ref.read(apiServiceProvider).getPostById(id);
  //   return post;
  // }

  Future<List<Comment>> getCommentsByPostId(int postId) async {
    debugPrint('Fetching comments for post ID: $postId');
    final comments =
        await ref.read(apiServiceProvider).getCommentsByPostId(postId);
    return comments;
  }

  Future<void> updatePost(Post post) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(apiServiceProvider).updatePost(post);
      return state.value?.map((p) => p.id == post.id ? post : p).toList() ?? [];
    });
  }

  Future<void> deletePost(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(apiServiceProvider).deletePost(id);
      return state.value?.where((post) => post.id != id).toList() ?? [];
    });
  }
}

final postProvider =
    AsyncNotifierProvider<PostProvider, List<Post>>(() => PostProvider());
