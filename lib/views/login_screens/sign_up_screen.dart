import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/controllers/db/online/diohelper.dart';
import 'package:freebies_ecommerce/views/components/my_text_field.dart';
import 'package:freebies_ecommerce/views/login_screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _verifyPasswordController = TextEditingController();
  GlobalKey<FormState>_formkey =GlobalKey();

  bool obscuretext = false;

  @override
  void dispose() {
    _namecontroller.dispose();
    _namecontroller.clear();
    _emailController.clear();
    _emailController.dispose();
    _passwordController.clear();
    _passwordController.dispose();
    _verifyPasswordController.dispose();
    _verifyPasswordController.clear();
    super.dispose();
  }

  Future<void> createUser() async {
    print("///////////////////////////////////////");
    try {
      var response = await DioHelper.dio.post(
          "https://api.escuelajs.co/api/v1/users/",
          data: {
  "name": _namecontroller.text,
  "email": _emailController.text,
  "password": _passwordController.text,
  "avatar": "https://picsum.photos/800"
});
      if (response.statusCode == 201) {
        print('User created successfully');
        print('Response: ${response.data}');
      } else {
        // Handle error
        print('Failed to create user. Status code: ${response.statusCode}');
        print('Error message: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Form(
        key: _formkey,
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Register Account ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Free",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.indigo),
                  ),
                  Text(
                    "bies  Ecomm",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.amber,
                        shadows: [
                          Shadow(
                              color: Colors.blue,
                              blurRadius: 1,
                              offset: Offset(0.5, 0.5))
                        ]),
                  ),
                  Text("erce",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.purple,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Text("Enter your Data to can Create your Account",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      shadows: [Shadow(color: Colors.black, blurRadius: 1)])),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Text("Full Name",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyTextField(
                controller: _namecontroller,
                hinttext: "Enter Your Full Name ",
                obscureText: false,
                maxlength: 300,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "must type your full name ";
                  } else if (value.length < 6) {
                    return "type your name right ";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 0),
              child: Text("Email/ Phone",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyTextField(
                controller: _emailController,
                hinttext: "Enter Your Name /Phone Number",
                obscureText: false,
                maxlength: 500,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "must type your email or phone";
                  } else if (value.length < 10) {
                    return "type your email right ";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 0),
              child: Text("Password",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyTextField(
                  controller: _passwordController,
                  hinttext: "Enter Your Password",
                  maxlength: 12,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "must type your password";
                    } else if (value.length < 8) {
                      return "must your password not less than 8 ";
                    }
                    return null;
                  },
                  obscureText: obscuretext,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        obscuretext = !obscuretext;
                      });
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 0),
              child: Text("Password Confirmation",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyTextField(
                  controller: _verifyPasswordController,
                  hinttext: "Confirm Your Password",
                  maxlength: 12,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "must type your password confirmation";
                    } else if (value.length !=
                        _passwordController.text.length) {
                      return "your confirmation password not the same of your password ";
                    }
                    return null;
                  },
                  obscureText: obscuretext,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        obscuretext = !obscuretext;
                      });
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: Colors.white,
                      shape: LinearBorder(),
                      fixedSize: Size(200, 50)),
                  onPressed: () {
                     createUser();
                  },
                  child: Text("Sign Up",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      )),
                  OutlinedButton(
                      onPressed: () {
                       
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
