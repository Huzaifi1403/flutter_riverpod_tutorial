import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/post_module/model/post_model.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_apihandler.dart';

final postApiServiceProvider = Provider((ref) => PostApihandler());

class PostDetailProvider extends FamilyAsyncNotifier<Post, int> {
  @override
  Future<Post> build(int postId) async {
    try {
      final post = await ref.read(postApiServiceProvider).getPostById(postId);
      return post;
    } catch (e) {
      debugPrint('Error fetching post: $e');
      rethrow;
    }
  }

  Future<Post> updatePost(Post post) async {
    state = const AsyncValue.loading(); // Set the state to loading
    state = await AsyncValue.guard(() async {
      final updatedPost =
          await ref.read(postApiServiceProvider).updatePost(post);
      return updatedPost;
    }, (error) {
      debugPrint('Error updating post: $error');
      throw error;
    });
    return state.value!;
  }
}

// This provider exposes an asynchronous notifier family for fetching a Post by its ID.
// - PostDetailProvider: The notifier class that contains the logic to fetch a single post.
// - Post: The type of data returned (the Post model).
// - int: The parameter type (the post ID).
final postDetailProvider =
    AsyncNotifierProviderFamily<PostDetailProvider, Post, int>(
  PostDetailProvider
      .new, // Factory function to create a new instance of the notifier.
);
