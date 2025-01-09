// Provider for fetching blog data from the API
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../models/blogs/blogs_model.dart';
import 'package:http/http.dart' as http;

import '../../res/api_url/api_url.dart';
class BlogProvider with ChangeNotifier {
  List<Blog> blogs = [];

  Future<void> fetchBlogs() async {
    final url = Uri.parse('https://apicore.vcqru.com/api/Blogs');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "Comp_ID": AppUrl.Comp_ID
      }),
    );

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      final List<dynamic> data = extractedData['data'];

      blogs = data.map((blogData) => Blog.fromJson(blogData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}