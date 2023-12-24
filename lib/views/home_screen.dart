import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchcontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        title: Text("Mega Mall",style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700
        ),),
        actions: [
          Icon(Icons.notifications_none_sharp,size: 30,),
                    SizedBox(width: 20,),
          Icon(Icons.shopping_cart_outlined,size: 30,),
          SizedBox(width: 25,)
        ],
      ),
      body: ListView(
        children: [Column(
          children: [
           Padding(
             padding: const EdgeInsets.only(top: 20,bottom: 12,right: 20,left: 20),
             child: TextField(
              controller: _searchcontroller,
              decoration: InputDecoration(
                fillColor: Colors.lightBlue[50],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                  borderSide: BorderSide.none
                ),
                hintText: "       Search Product Name",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                suffixIcon: Icon(Icons.search,size: 35,),
                suffixIconColor: Colors.blue[200]
              ),
             ),
           ),
           Container(
            height: 200,
            width: 400,
             child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset("assets/images/Group 513 (1).png",width: 300),
                SizedBox(width: 20,),
                                Image.asset("assets/images/Group 513.png",width: 300),
           
              ],
             ),
           )
          ],
          
        ),
        ],
      ),
    );
  }
}