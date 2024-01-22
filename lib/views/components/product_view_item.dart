import 'package:flutter/material.dart';

class ProductViewItem extends StatelessWidget {
  final String? imagenetworkproduct;
  final String producttitle;
  final String productPrice;
  final String reviewsProduct;
  const ProductViewItem(
      {super.key,
       this.imagenetworkproduct,
      required this.producttitle,
      required this.productPrice,
      required this.reviewsProduct});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 200,
        height: 200,
        child: Expanded(
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                      child:imagenetworkproduct!=null ||imagenetworkproduct!.isNotEmpty ? Image.network(
                    imagenetworkproduct!):Image.asset('assets/images/Placeholder_view_vector.svg.png'),
                  )),
                
                Expanded(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 140,
                              height: 70,
                              child: Text(
                                producttitle,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              productPrice,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                            ),
                            Text(" 4.6"),
                            Text(reviewsProduct,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                            Expanded(
                              child: PopupMenuButton(
                                onSelected: (value){
                                  
                                },
                                  icon: Icon(
                                    Icons.more_vert,
                                  ),
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Text("order"),
                                          value: "true",
                                        )
                                      ]),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
