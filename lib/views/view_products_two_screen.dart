import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/controllers/db/online/diohelper.dart';
import 'package:freebies_ecommerce/models/product_model_filterbycategory.dart';
import 'package:freebies_ecommerce/views/components/product_view_item.dart';
import 'package:freebies_ecommerce/views/view_product_details.dart';

class ViewProductsTwo extends StatefulWidget {
  final String? name;
  const ViewProductsTwo({super.key,required this.name});

  @override
  State<ViewProductsTwo> createState() => _ViewProductsTwoState();
}

class _ViewProductsTwoState extends State<ViewProductsTwo> {
    List<ProductModelFilteredByCatag> sectionOne = [];
    



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

   @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getProductFilteredCatag();
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
        Text("${widget.name}"),
      ),
      body: ListView(
        children: [
           SizedBox(
            height: MediaQuery.of(context).size.height*1,
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
                      itemCount: sectionOne.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewProductDetails(
                                  productId: sectionOne[index].id)));
                        },
                        child: Flex(direction: Axis.vertical,
                          children: [Container(height: 400,
                            child: Expanded(flex: 1,
                              child: ProductViewItem(
                                  imagenetworkproduct:sectionOne[index].images![0].isEmpty||sectionOne[index].images![0]==null ?"https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg"
                                     : "${sectionOne[index].images![0]}",
                                  producttitle: "${sectionOne[index].title}",
                                  productPrice:
                                      "Price :${sectionOne[index].price} \$",
                                  reviewsProduct: "  79 Reviews"),
                            ),
                          ),],
                       
                        ),
                      ),
                    );
                  }
                  return Text("No Data Try Later");
                }),
          ),
        ],
      ),
    );
  }
}