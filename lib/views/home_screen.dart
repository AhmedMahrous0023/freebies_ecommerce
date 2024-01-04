import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/controllers/db/online/diohelper.dart';
import 'package:freebies_ecommerce/models/category_model.dart';
import 'package:freebies_ecommerce/models/product_model_filterbycategory.dart';
import 'package:freebies_ecommerce/views/categoriesview.dart';
import 'package:freebies_ecommerce/views/components/product_view_item.dart';
import 'package:freebies_ecommerce/views/view_product_details.dart';
import 'package:freebies_ecommerce/views/view_product_one_screen.dart';
import 'package:freebies_ecommerce/views/view_products_two_screen.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? url;

  Map<String, dynamic>? newNews;

  Future<void> getData() async {
    var data = await FirebaseFirestore.instance
        .collection('news')
        .doc('VTMjodvUXNCPzcj2WtHy')
        .get();
    newNews = data.data();
    var newlist = newNews!.values.toList();
    print(newNews);
  }

  TextEditingController _searchcontroller = TextEditingController();
  List<CategoryModel> categories = [];
  CategoryModel? categoriesSingle;
  CategoryModel? categoriesSecond;

  List<ProductModelFilteredByCatag> sectionOne = [];
  int? productId;

  getcategories() async {
    try {
      var response =
          await DioHelper.dio.get("https://api.escuelajs.co/api/v1/categories");
      if (response.statusCode == 200 && response.data != null) {
        var data = response.data;
        for (var element in data) {
          categories.add(CategoryModel.fromJson(element));
        }
        print("$categories");
        return categories;
      }
    } catch (e) {
      Text("Error:$e");
      return [];
    }
  }

  getOneCategory() async {
    try {
      var response = await DioHelper.dio
          .get("https://api.escuelajs.co/api/v1/categories/1");
      if (response.statusCode == 200 && response.data != null) {
        var data = response.data;
        categoriesSingle = CategoryModel.fromJson(data);
        return categoriesSingle;
      }
    } catch (e) {
      Text("Error:$e");
      return [];
    }
  }

  getSecondCategory() async {
    try {
      var response = await DioHelper.dio
          .get("https://api.escuelajs.co/api/v1/categories/2");
      if (response.statusCode == 200 && response.data != null) {
        var data = response.data;

        categoriesSecond = CategoryModel.fromJson(data);
        print("$categoriesSecond");
        return categoriesSecond;
      }
    } catch (e) {
      Text("Error:$e");
      return [];
    }
  }

  getProductFilteredCatag() async {
    try {
      var response = await DioHelper.dio
          .get("https://api.escuelajs.co/api/v1/products/?categoryId=1");
      if (response.statusCode == 200 && response.data != null) {
        var data = response.data;
        for (var element in data) {
          sectionOne.add(ProductModelFilteredByCatag.fromJson(element));
        }

        return sectionOne;
      }
    } catch (e) {
      Text("Error:$e");
      return [];
    }
  }

  Future<String> getImageUrl(String fileName) async {
  try {
    Reference storageReference = FirebaseStorage.instance.ref().child('images/$fileName');
    String downloadURL = await storageReference.getDownloadURL();
     print(downloadURL);
    print("marihaaaaaaaaaaaaaaaaaaaaaaaaaaaaannnnnnnnnn");
    url =downloadURL ;
    return url!;
   
  } catch (e) {
    print('Error getting image URL: $e');
    return 'null';
  }
}


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getcategories();
    await getProductFilteredCatag();
    await getOneCategory();
    await getSecondCategory();
    await getData();
    await getImageUrl('24701-nature-natural-beauty.jpg');
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    Image.asset("assets/images/Group 513 (1).png", width: 300),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoriesView()));
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: 160,
                width: 450,
                child: FutureBuilder(
                    future: getcategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer(
                          duration: Duration(
                              seconds: 1), // Adjust the duration as needed
                          color: Colors.grey,
                          enabled: true, // Enable shimmer effect
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: 50,
                                  height: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error:${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        return Text("No Data Found");
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          child: categories[index].id! > 6
                                              ? Image.asset(
                                                  "assets/images/Placeholder_view_vector.svg.png",
                                                  width: 140,
                                                  height: 130,
                                                )
                                              : Image.network(
                                                  "${categories[index].image}",
                                                  fit: BoxFit.cover,
                                                  width: 130,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "${categories[index].name}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ));
                      }
                      return Text("try later");
                    })),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    child: FutureBuilder(
                      future: getOneCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (!snapshot.hasData) {
                          return Text("No Data found");
                        } else if (snapshot.hasError) {
                          return Text("Error :${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return Text(
                            "${categoriesSingle!.name}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          );
                        } else {
                          return Text("null");
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewProductsOne(
                                  name: "${categoriesSingle!.name}",
                                )));
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 400,
              child: FutureBuilder(
                  future: getProductFilteredCatag(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error:${snapshot.error}");
                    } else if (!snapshot.hasData) {
                      return Text("No Data Found");
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewProductDetails(
                                            productId: sectionOne[index].id,
                                          )));
                                },
                                child: ProductViewItem(
                                    imagenetworkproduct: sectionOne
                                            .first.images!.isNotEmpty
                                        ? "${sectionOne[index].images![0]}"
                                        : "https://cityofmebanenc.gov/parks-facilities-trails/placeholder-image/",
                                    producttitle: "${sectionOne[index].title}",
                                    productPrice:
                                        "Price :${sectionOne[index].price} \$",
                                    reviewsProduct: "    79 Reviews "),
                              ));
                    }
                    return Text("No Data Try Later");
                  }),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 19.0, right: 19.0, top: 17, bottom: 19),
                child: Image.asset(
                  "assets/images/Banner default.png",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    child: FutureBuilder(
                        future: getSecondCategory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (!snapshot.hasData) {
                            return Text("No Data found");
                          } else if (snapshot.hasError) {
                            return Text("Error :${snapshot.error}");
                          } else if (snapshot.hasData) {
                            return Text(
                              "${categoriesSecond!.name}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            );
                          } else {
                            return Text("try later");
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewProductsTwo(
                                  name: "${categoriesSecond!.name}",
                                )));
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
          SizedBox(
            height: 400,
            child: FutureBuilder(
                future: getProductFilteredCatag(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error:${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return Text("No Data Found");
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewProductDetails(
                                  productId: sectionOne[index].id)));
                        },
                        child: ProductViewItem(
                            imagenetworkproduct:
                                "${sectionOne[index].images![0]}" ??
                                    "https://cityofmebanenc.gov/parks-facilities-trails/placeholder-image/",
                            producttitle: "${sectionOne[index].title}",
                            productPrice:
                                "Price :${sectionOne[index].price} \$",
                            reviewsProduct: "  79 Reviews"),
                      ),
                    );
                  }
                  return Text("No Data Try Later");
                }),
          ),
         Padding(
           padding: const EdgeInsets.all(15.0),
           child: Text("Latest News",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
         ),
          newNews != null
              ? Card(
                child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("${newNews!['title']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    ),
                    subtitle: Column(
                      children: [
                        Padding(
                      padding: const EdgeInsets.only(top: 20,right: 130),
                          child: Text("${newNews!['subtitle']}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        ),
                                                  Padding(
                      padding: const EdgeInsets.only(top: 10,right: 130),
                                                    child: Text("${newNews!['date']}",style: TextStyle(fontSize: 14,color: Colors.grey, fontWeight: FontWeight.w400),),
                                                  ),
                                                 
                    
                    
                      ],
                    ),
                    trailing:  Image.network("$url"),
                  ),
              )
              : Text("nothing")
        ],
      ),
    );
  }
}
