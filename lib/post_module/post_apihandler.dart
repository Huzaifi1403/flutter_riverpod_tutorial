import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod_tutorial/post_module/model/comment_model.dart';
import 'package:flutter_riverpod_tutorial/post_module/model/post_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class PostApihandler {
  final String baseURL = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts() async {
    debugPrint('Fetching posts List from $baseURL/posts');
    final response = await http.get(Uri.parse('$baseURL/posts'), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> getPostById(int postId) async {
    final response = await http.get(Uri.parse('$baseURL/posts/$postId'));
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<Comment>> getCommentsByPostId(int postId) async {
    final response =
        await http.get(Uri.parse('$baseURL/posts/$postId/comments'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Post> createPost(Post post) async {
    // Logic to create a new post via the API
    final response = await http.post(
      Uri.parse('$baseURL/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201) {
      return Post.fromJson(json.decode(response.body));
    } else {
      Fluttertoast.showToast(
        msg: "Failed to create post",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      throw Exception('Failed to create post');
    }
  }

  Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$baseURL/posts/${post.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int postId) async {
    final response = await http.delete(
      Uri.parse('$baseURL/posts/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
