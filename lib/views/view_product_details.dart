import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/controllers/db/online/diohelper.dart';
import 'package:freebies_ecommerce/models/product_details_model.dart';
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
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 1,
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
                            height: 200,
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
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData) {
                            return Text("No Data");
                          } else if (snapshot.hasData) {
                            return Column(
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
                                  subtitle: productDetails == null
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : Text(
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
                                      top: 15, right: 280),
                                  child: productDetails == null
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : Text(
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(70.0),
                                  child: ElevatedButton.icon(
                                      onPressed: () {},
                                      label: Text("Add To Cart"),
                                      icon: Icon(Icons.shopping_cart_outlined),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue[400],
                                          foregroundColor: Colors.white,
                                          fixedSize: Size(250, 50),
                                          shape: LinearBorder())),
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
    );
  }
}
