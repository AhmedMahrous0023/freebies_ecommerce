import 'package:freebies_ecommerce/controllers/db/offline/hive_helper.dart';
import 'package:freebies_ecommerce/models/product_details_model.dart';
import 'package:hive/hive.dart';


class ListCartSavedItems {
 static List <ProductDetailsModel>myCartList =[];

static showList(){
  print(myCartList);
  
 }

 test(){
  Hive.box('cart').add(myCartList);
 }

}