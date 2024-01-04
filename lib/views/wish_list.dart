import 'package:freebies_ecommerce/models/product_details_model.dart';
import 'package:hive/hive.dart';

class WishList {
  static List<ProductDetailsModel> wishsList = [];
  static ProductDetailsModel? newproduct;

  static Future<List<ProductDetailsModel>> getWishes() async {
    var box = await Hive.openBox('wishesBox');
   var productjson = box.get('product');
   print('${productjson}');
   print("////////////////////////////////////");
    for (var element in productjson) {

    var product = ProductDetailsModel.fromJson(element);
    newproduct =product ;
   }

    if (newproduct != null) {
      wishsList.add(newproduct!);
    }

    return wishsList;
  }
}

