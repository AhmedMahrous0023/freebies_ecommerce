import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/models/product_details_model.dart';
import 'package:freebies_ecommerce/views/list_cart_saved_items.dart';
import 'package:freebies_ecommerce/views/view_product_details.dart';

class AddToCart extends StatefulWidget {
  final   int  price;
  final int? productId;
  final ProductDetailsModel? productDetails;

   AddToCart({super.key, required this.price, this.productId, this.productDetails, });

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool isAddedCart = false ;
   int?  price;
  int number = 1;
  bool confirmAddCart = false ;
  bool choosedBlack = false ;
    bool choosedWhite = false ;
  bool choosedBlue = false ;

    ProductDetailsModel? productDetails;


   decreaseQuantity(){
    if (number>1) {
setState(() {
   number-- ;
});
                                                                  }
  }


  increaseQuantity(){
   
 setState(() {
   number++ ;
});
    
   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
 padding: const EdgeInsets.all(25.0),
        child: SizedBox(
                                                height: 600,
                                                width: 400,
                                                child: Card(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20,
                                                                    top: 10),
                                                            child: Text(
                                                              "Add to Cart",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 20),
                                                            child:
                                                            IconButton(onPressed: (){
                                                             Navigator.of(context).pop();
                                                            }, icon:  Icon(Icons.clear),),
                                                               
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                          thickness: 0.25,
                                                          color: Colors.grey),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 20, top: 10,right: 15),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Quantity",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                              width: 120,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  IconButton(onPressed: 
                                                                    decreaseQuantity
        
                                                                  , icon:  Icon(
                                                                      Icons.remove),),
                                                                  Text(
                                                                    "$number",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  IconButton(onPressed: increaseQuantity, icon: Icon(
                                                                    Icons.add,
                                                                    color:
                                                                        Colors.blue,
                                                                  )),
                                                                  
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                          thickness: 0.25,
                                                          color: Colors.grey),
                                                      Padding(
           padding:
                                                            const EdgeInsets.only(
                                                                left: 20, top: 10),                                                    child: Text("Variant",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              onTap: (){setState(() {
                                                                
                                                              });
choosedBlack =!choosedBlack ;
                                                              },
                                                              child: Container(
                                                                width: 80,
                                                                child: Card(
                                                               color: choosedBlack?Colors.black:Colors.grey,
                                                               
                                                                  shape: BeveledRectangleBorder(),
                                                                  child: Center(child: Text("Black",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.w600,shadows: [Shadow(color: Colors.brown,blurRadius: 2)]),)),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap:(){
setState(() {
  choosedWhite=!choosedWhite;
});
                                                              },
                                                              child: Container(
                                                                width: 80,
                                                                child: Card(
                                                                  color: choosedWhite?Colors.white:Colors.grey,
                                                                  shape: BeveledRectangleBorder(),
                                                                  child: Center(child: Text("White",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.w600,shadows: [Shadow(color: Colors.brown,blurRadius: 2)]))),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: (){setState(() {
                                                                
                                                              });
choosedBlue =!choosedBlue ;
                                                              },
                                                              child: Container(width: 80,
                                                                child: Card(
                                                                                                                                    color: choosedBlue?Colors.blue:Colors.grey,

                                                                  shape: BeveledRectangleBorder(),
                                                                  child: Center(child: Text("Blue",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.w600,shadows: [Shadow(color: Colors.brown,blurRadius: 2)]))),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                          thickness: 0.25,
                                                          color: Colors.grey),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                                                        child: Text("Total Belanja",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,color: Colors.blueGrey[300],
                                                                    fontSize: 15),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                                                        child: Text("Price \$ ${widget.price*number}",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.red),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20,top: 15,bottom: 15),
                                                        child: Center(
                                                          child: ElevatedButton.icon(
                                                              onPressed: () {
                                                                setState(() {
                                                                  isAddedCart =!isAddedCart;
                                                                });
                                                                if (isAddedCart==true&&widget.productDetails!=null){
                                                                  ListCartSavedItems.myCartList.add(widget.productDetails!);
                                                                  ListCartSavedItems.showList();
                                                                }
                                                               
                                                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ViewProductDetails(isAddedCart: isAddedCart,productId: widget.productId??0)));                                                          
                                                                                                                             
          
                                                               
                                                                 print("///////////////////////////////$confirmAddCart");
                                                              },
                                                              label:
                                                              
                                                                  Text(isAddedCart?"Added":"Add To Cart"),
                                                              icon: Icon(confirmAddCart?Icons.add_shopping_cart:Icons
                                                                  .shopping_cart_outlined),
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor:isAddedCart?Colors.green:
                                                                      Colors
                                                                          .blue[400],
                                                                  foregroundColor:
                                                                      Colors.white,
                                                                  fixedSize:
                                                                      Size(160, 50),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  15)))),
                                                        ),
                                                      ),
                                                     
                                                    ],
                                                  ),
                                                ),
                                              ),
      ),
    );
  }
}