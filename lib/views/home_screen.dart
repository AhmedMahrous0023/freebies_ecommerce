import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/controllers/db/online/diohelper.dart';
import 'package:freebies_ecommerce/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchcontroller = TextEditingController();
  List<CategoryModel> categories = [];

  getcategories() async {
    try {
      var response =
          await DioHelper.dio.get("https://api.escuelajs.co/api/v1/categories");
      if (response.statusCode == 200 && response.data != null) {
        var data = response.data;
        categories.clear();
        for (var element in data) {
          categories.add(CategoryModel.fromJson(element));
        }
        print("$categories");
        return categories;
      }
    } catch (e) {
      Text("Error:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        title: Text(
          "Freebies Mall",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
        ),
        actions: [
          Icon(
            Icons.notifications_none_sharp,
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.shopping_cart_outlined,
            size: 30,
          ),
          SizedBox(
            width: 25,
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 12, right: 20, left: 20),
                child: TextField(
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                      fillColor: Colors.lightBlue[50],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(19),
                          borderSide: BorderSide.none),
                      hintText: "       Search Product Name",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        size: 35,
                      ),
                      suffixIconColor: Colors.blue[200]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  height: 200,
                  width: 400,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Image.asset("assets/images/Group 513 (1).png",
                          width: 300),
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset("assets/images/Group 513.png", width: 300),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  height: 300,
                  width: 450,
                  child: FutureBuilder(
                      future: getcategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text("Error:${snapshot.error}");
                        } else if (!snapshot.hasData) {
                          return Text("No Data Found");
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) => Column(
                                    children: [
                                      Card(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: categories[index].id! > 6
                                                ? Image.asset(
                                                    "assets/images/Placeholder_view_vector.svg.png",
                                                    width: 140,
                                                    height: 130,
                                                  )
                                                : Image.network(
                                                    "${categories[index].image}",
                                                    width: 140,
                                                    height: 130,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child:
                                            Text("${categories[index].name}",style: TextStyle(
                                              fontSize: 17,fontWeight: FontWeight.w500
                                            ),),
                                      )
                                    ],
                                  ));
                        }
                        return Text("try later");
                      }))
            ],
          ),
        ],
      ),
    );
  }
}
