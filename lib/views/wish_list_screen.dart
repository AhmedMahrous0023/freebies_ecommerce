import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/models/product_details_model.dart';
import 'package:freebies_ecommerce/views/wish_list.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    print("${WishList.wishsList.length}");
    print("000000000000000000000012222222222222222222222222");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MaterialButton(
              onPressed: ()  {
                
              },
              child: Text("view"),
            ),
            ListView.builder(
                itemCount: WishList.wishsList.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                        leading: WishList.wishsList[index].images![0] != null
                            ? Image.network(
                                "${WishList.wishsList[index].images![0]}")
                            : Image.asset(
                                "assets/images/Placeholder_view_vector.svg.png"),
                                title: Text("${WishList.wishsList[index].title}"),
                                subtitle: Text("${WishList.wishsList[index].description}"),
                                trailing: Text("${WishList.wishsList[index].price} \$"),
                      ),
                    ))
          ],
        ),

        // child: WishList.wishsList.isEmpty?Center(child: Text("No Wish List")): ListView.builder(
        //   itemCount: WishList.wishsList.length,
        //   itemBuilder: (context,index)=>
        //     Card(
        //       child: ListTile(
        //         leading: Image.network("${WishList.wishsList[index].images![0]}"),
        //         title: Text("${WishList.wishsList[index].title}"),
        //         subtitle: Text("${WishList.wishsList[index].price}"),
        //       ),
        //     ),

        // ),
      ),
    );
  }
}
