import 'package:app_test/provider/blog_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() async {
    Provider.of<BlogListProvider>(context).getBlogListData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var blogList = Provider.of<BlogListProvider>(context).blogList;

    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome to Smart Solution"),
          centerTitle: true,
          backgroundColor: Colors.black12,
        ),
        backgroundColor: Colors.red,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: blogList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(color: Colors.blueGrey),
                );
              }),
        ));
  }
}
