import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/controllers/db/online/diohelper.dart';
import 'package:freebies_ecommerce/models/product_details_model.dart';
import 'package:freebies_ecommerce/models/product_model_filterbycategory.dart';
import 'package:freebies_ecommerce/views/wish_list.dart';
import 'package:hive/hive.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ViewProductDetails extends StatefulWidget {
  final int? productId;
  ViewProductDetails({
    super.key,
    this.productId,
  });

  @override
  State<ViewProductDetails> createState() => _ViewProductDetailsState();
}

class _ViewProductDetailsState extends State<ViewProductDetails> {
    bool isAdedd =false ;

  ProductDetailsModel? productDetails;
  getproductDetails() async {
    try {
      var response = await DioHelper.dio
          .get("https://api.escuelajs.co/api/v1/products/${widget.productId}");
      if (response.statusCode == 200 && response.data != null) {
        productDetails = ProductDetailsModel.fromJson(response.data);
        return productDetails;
      }
    } catch (e) {
      Text("Error:$e");
      return null;
    }
  }

 Future<void> addToWishlist(ProductDetailsModel productDetails) async {
  WishList.wishsList.add(productDetails);

  
}




  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getproductDetails();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.productId}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Product",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 2.3,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 300,
                    child: FutureBuilder(
                        future: getproductDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                            return SizedBox(
                              child: PageView(reverse: true, children: [
                                Card(
                                    child: productDetails == null
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${productDetails!.images![0]}"))),
                                            child: Text(
                                              "1/3 Photos",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  shadows: [
                                                    Shadow(
                                                        color: Colors.blue,
                                                        blurRadius: 2,
                                                        offset:
                                                            Offset(0.25, 0.25))
                                                  ]),
                                            ),
                                          )),
                                Card(
                                    child: productDetails == null 
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Image.network(
                                            "${productDetails!.images![1]}")),
                                Card(
                                    child: productDetails == null
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Image.network(
                                            "${productDetails!.images![2]}")),
                              ]),
                            );
                          }
                          return Text("no data");
                        })),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                top: 300,
                child: Card(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: FutureBuilder(
                          future: getproductDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Shimmer(
                                duration: Duration(
                                    seconds:
                                        1), // Adjust the duration as needed
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
                              return Text("Error: ${snapshot.error}");
                            } else if (!snapshot.hasData) {
                              return Text("No Data");
                            } else if (snapshot.hasData) {
                              return ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  ListTile(
                                    title: productDetails == null
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Text(
                                            "${productDetails!.title}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.orange,
                                                      blurRadius: 1,
                                                      offset: Offset(0.5, 0.5))
                                                ]),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, right: 280),
                                    child: productDetails == null
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              "Price \$ ${productDetails!.price}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                  color: Colors.red,
                                                  shadows: [
                                                    Shadow(
                                                        color: Colors.pink,
                                                        blurRadius: 1)
                                                  ]),
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[700],
                                            ),
                                            Text(" 4.6"),
                                            Text(
                                              "  79 Reviews",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Card(
                                          color: Colors.green[50],
                                          child: Text(
                                            "Tersedia : 250",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.green[300],
                                                fontWeight: FontWeight.w900),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Card(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.zero)),
                                          height: 100,
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              radius: 28,
                                              child: Image.asset(
                                                  "assets/images/istockphoto-515443264-612x612.jpg"),
                                            ),
                                            title:
                                                Text("Shop Larson Electronic"),
                                            subtitle: Row(
                                              children: [
                                                Text("Official Store"),
                                                Icon(
                                                  Icons.verified,
                                                  color: Colors.blue,
                                                )
                                              ],
                                            ),
                                            trailing: Icon(Icons
                                                .arrow_forward_ios_outlined),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 199,
                                        top: 20,
                                        bottom: 20,
                                        left: 15),
                                    child: Text(
                                      "Describtion Product",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  productDetails == null
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            "${productDetails!.description}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                                color: Colors.black87,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.pink,
                                                      blurRadius: 1)
                                                ]),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25,
                                        bottom: 25,
                                        right: 15,
                                        left: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Review (86)",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                Text(
                                                  "4.6",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color: Colors.black87,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Card(
                                          child: ListTile(
                                            leading: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/woman.jpg")),
                                                  shape: BoxShape.circle),
                                            ),
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Yelena Belova",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        "2 Minggu yang lalu",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .blueGrey[200],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            subtitle: Text(
                                              "Lorem ipsum dolor sit amet,consecteteur\nadipiscing elit ,sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqua.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Card(
                                          child: ListTile(
                                            leading: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/man.jpg")),
                                                  shape: BoxShape.circle),
                                            ),
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Stephen Strange",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        "1 Bulan yang lalu",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .blueGrey[200],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            subtitle: Text(
                                              "Lorem ipsum dolor sit amet,consecteteur\nadipiscing elit ,sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqua.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Card(
                                          child: ListTile(
                                            leading: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/man.jpg")),
                                                  shape: BoxShape.circle),
                                            ),
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Peter Parker",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                              "2 Bulan yang lalu",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .blueGrey[200],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            subtitle: Text(
                                              "Lorem ipsum dolor sit amet,consecteteur\nadipiscing elit ,sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqua.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            fixedSize: Size(170, 60)),
                                        onPressed: () {},
                                        child: Text("See All Review")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton.icon(
                                            onPressed: () {
                                              addToWishlist(productDetails!);
                                              setState(() {
                                                isAdedd=!isAdedd;
                                              });
                                            },
                                            label:isAdedd?Text("Added Done"): Text("Added"),
                                            icon:isAdedd? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: isAdedd?Colors.green: Colors.red,
                                                foregroundColor: Colors.white,
                                                fixedSize: Size(160, 50),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)))),
                                        ElevatedButton.icon(
                                            onPressed: () {},
                                            label: Text("Add To Cart"),
                                            icon: Icon(
                                                Icons.shopping_cart_outlined),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue[400],
                                                foregroundColor: Colors.white,
                                                fixedSize: Size(160, 50),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)))),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Text("try later");
                            }
                          })),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
