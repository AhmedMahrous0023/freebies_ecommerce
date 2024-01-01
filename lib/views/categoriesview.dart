import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/controllers/db/online/diohelper.dart';
import 'package:freebies_ecommerce/models/category_model.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
    List<CategoryModel> categories = [];

   getcategories() async {
    try {
      var response =
          await DioHelper.dio.get("https://api.escuelajs.co/api/v1/categories");
      if (response.statusCode == 200 && response.data != null) {
        var data = response.data;
        categories.clear();
        for (var element in data) {
          categories.add(CategoryModel.fromJson(element));
        }
        print("$categories");
        return categories;
      }
    } catch (e) {
      Text("Error:$e");
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,),
                child: Text("All Categories",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5),
              ),
              Container(
                height: 900,
                width: 400,
                child:
FutureBuilder(
  future: getcategories(),
   builder: (context,snapshot){
    if (snapshot.connectionState==ConnectionState.waiting){
      return Center(child: CircularProgressIndicator(),);
    }else if (!snapshot.hasData || snapshot.data== null){
      return Text("No Data");
    } else if (snapshot.hasError){
      return Text("Error: ${snapshot.error}");
    }else if ( snapshot.hasData){
      return GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 0,mainAxisSpacing: 0,
                    crossAxisCount: 2),
                   itemBuilder: (context,index)=>
                     
                       Container(
                        
                        height: 180,
                        width: 180,
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Card(
                               child: Image.network("${categories[index].image}",width: 100,fit: BoxFit.cover,),
                             ),
                             Center(child: Text("${categories[index].name}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),))
                           ],
                         ),
                         
                       ));
    }else {
      return Text("try later");
    }
   })

                 
              )]
          ),
        ),
      ),
    );
  }
}                 