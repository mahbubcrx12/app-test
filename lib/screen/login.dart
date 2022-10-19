import 'dart:convert';
import 'package:app_test/api_service/http_request.dart';
import 'package:app_test/const/custom_text_field.dart';
import 'package:app_test/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    isLogin();
    super.initState();
  }

  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

  getLogin() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });
      final result = await HttpRequest.login(
          emailController.text, passwordController.text);
      setState(() {
        isLoading = false;
      });
      final data = jsonDecode(result);
      print(data);
      print("hhhhhhhhhhhhhhhh ${data["data"]["token"]}");
      if (data["data"]["token"] != null) {
        setState(() {
          sharedPreferences.setString("token", data["data"]["token"]);

          sharedPreferences.setString("email", emailController.text);
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      }
      print("tttttttttttttt$data");
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Smart Solution"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login Here",
              style: TextStyle(
                  color: Colors.white, backgroundColor: Colors.blueGrey),
            ),
            CustomTextField(
              controller: emailController,
              hintText: "Email",
              lebelText: "Enter Email",
            ),
            CustomTextField(
              controller: passwordController,
              hintText: "Password",
              lebelText: "Enter Password",
            ),
            InkWell(
              onTap: () {
                getLogin();
              },
              child: Container(
                  height: 60,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Text("submit"))),
            )
          ],
        ),
      ),
    );
  }
}
