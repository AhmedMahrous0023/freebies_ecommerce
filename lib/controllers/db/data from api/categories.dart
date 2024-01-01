// import 'package:flutter/material.dart';
// import 'package:freebies_ecommerce/controllers/db/online/diohelper.dart';
// import 'package:freebies_ecommerce/models/category_model.dart';

// class Catagories{
//     List<CategoryModel> categories = [];

//    Future getcategories() async {
//     try {
//       var response =
//           await DioHelper.dio.get("https://api.escuelajs.co/api/v1/categories");
//       if (response.statusCode == 200 && response.data != null) {
//         var data = response.data;
//         categories.clear();
//         for (var element in data) {
//           categories.add(CategoryModel.fromJson(element));
//         }
//         print("$categories");
//         return categories;
//       }
//     } catch (e) {
//       Text("Error:$e");
//     }

//   }

//   Catagories({required this.categories,})
// }