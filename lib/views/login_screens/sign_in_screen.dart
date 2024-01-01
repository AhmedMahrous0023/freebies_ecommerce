import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/controllers/db/online/diohelper.dart';
import 'package:freebies_ecommerce/views/bottom_navigator_screen.dart';
import 'package:freebies_ecommerce/views/components/my_text_field.dart';
import 'package:freebies_ecommerce/views/home_screen.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({super.key});

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
 bool obscuretext = false ;
 GlobalKey<FormState> _formstate = GlobalKey<FormState>();

 

  @override
  void dispose() {
    _emailController.clear();
_emailController.dispose();
_passwordController.clear();
_passwordController.dispose();
    super.dispose();
  }


  Future<void>signin()async{
    var response =await DioHelper.dio.post("https://api.escuelajs.co/api/v1/auth/login",
    data: {
  "email": _emailController.text,
  "password": _passwordController.text
});
if(response.statusCode==201){
  print("${response.data["access_token"]}");
  print("5555555555555555555555");

}else {
        // Handle error
        print('Failed to create user. Status code: ${response.statusCode}');
        print('Error message: ${response.data}');
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BottomNavigatorScreen()));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Form(
        key: _formstate,
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Welcome back to ",
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
              child: Text("Enter your Data to can Enter your Account",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      shadows: [Shadow(color: Colors.black, blurRadius: 1)])),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Text("Email/ Phone",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyTextField(controller: _emailController,
              hinttext: "Enter Your Name /Phone Number",
              obscureText: false,
              maxlength: 500,
              validator:(value){
                if (value == null || value.isEmpty){
                  return "must type your email or phone" ;
                }else if(value.length <10){
                  return "type your email right ";
                }
                 return null ;
              } ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Text("Password",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyTextField(controller: _passwordController,
              hinttext: "Enter Your Password",
              maxlength: 12,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "must type your password";
                }else if(value.length <8){
                  return "must your password not less than 8 ";
                }
                return null ;
              },
              obscureText: obscuretext,
              suffixIcon: IconButton(icon :Icon(Icons.remove_red_eye),onPressed: (){
                setState(() {
                  obscuretext =!obscuretext ;
                });
              },)),
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
                    signin();
                  },
                  child: Text("Sign In",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20,left: 20,top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){}, child: Text("Forgot Password",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),)),
                                TextButton(onPressed: (){}, child: Text("Sign Up",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),))
              
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
