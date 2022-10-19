import 'dart:convert';

import 'package:app_test/model/blog_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequest {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
  };
  static Future<String> login(String email, String password) async {
    try {
      var link = 'https://apitest.hotelsetting.com/api/login';
      var map = Map<String, dynamic>();
      map["email"] = email;
      map["password"] = password;
      final response = await http.post(
        Uri.parse(link),
        body: map,
        headers: defaultHeader,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "something wrong";
      }
    } catch (e) {
      return "Something else";
    }
  }

  Future<Map<String, String>> getHeadersWithToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": "Bearer 964|GJmg7hyWSiRi539G0nR2nAybrIYIItLBZ4gr0bIj"
    };
    return header;
  }

  Future<List<BlogListModel>> fetchBlogList() async {
    List<BlogListModel> blogList = [];

    try {
      var link = "https://apitest.hotelsetting.com/api/admin/blog-news";
      var response = await http.get(Uri.parse(link), headers: <String, String>{
        'Content-Type': 'application/json',
        "Accept": "application/json",
        "Authorization": "Bearer 964|GJmg7hyWSiRi539G0nR2nAybrIYIItLBZ4gr0bIj"
      });

      print(response.statusCode);
      //print(response.body);
      
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
       // print("xxxxxxxxxxxxxxxxxxxxxxxxxx $decodeData");
        var data = decodeData["data"]["blogs"]["data"];
        print("kkkkkkkkkkkkkkk $data");

        BlogListModel blogModel;
        for (var i in data) {
          blogModel = BlogListModel.fromJson(i);
          blogList.add(blogModel);
        }
        print("fffffffffffffffffffffffffff $blogList");
        return blogList;
      } else {
        return blogList;
      }
    } catch (e) {
      print("Errrrrrr $e");
      return blogList;
    }
  }
}
