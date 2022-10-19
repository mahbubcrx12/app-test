import 'package:flutter/material.dart';
import 'package:app_test/model/blog_list_model.dart';
import 'package:app_test/api_service/http_request.dart';

class BlogListProvider with ChangeNotifier {
  List<BlogListModel> blogList = [];

  getBlogListData() async {
    blogList = await HttpRequest().fetchBlogList();
    notifyListeners();
  }
}
