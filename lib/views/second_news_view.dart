import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SecondNewsView extends StatefulWidget {
  const SecondNewsView({super.key});

  @override
  State<SecondNewsView> createState() => _SecondNewsViewState();
}

class _SecondNewsViewState extends State<SecondNewsView> {
  String? urlTwo;
  String? urlOne;
  String? urlThree;
  Map<String, dynamic>? newNewsThird;
  Map<String, dynamic>? newNewsFirst;
  Map<String, dynamic>? newNewsSecond;

  Future<String> getImageUrl(String fileName) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      String downloadURL = await storageReference.getDownloadURL();
      print(downloadURL);
      urlOne = downloadURL;
      return urlOne!;
    } catch (e) {
      print('Error getting image URL: $e');
      return 'null';
    }
  }

  Future<String> getImageUrlTwo(String fileName) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      String downloadURL = await storageReference.getDownloadURL();
      print(downloadURL);
      urlTwo = downloadURL;
      return urlTwo!;
    } catch (e) {
      print('Error getting image URL: $e');
      return 'null';
    }
  }

  Future<String> getImageUrlThird(String fileName) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      String downloadURL = await storageReference.getDownloadURL();
      print(downloadURL);
      urlThree = downloadURL;
      return urlThree!;
    } catch (e) {
      print('Error getting image URL: $e');
      return 'null';
    }
  }

  Future getDataThirdDoc() async {
    var data = await FirebaseFirestore.instance
        .collection('news')
        .doc('qIUNyotza9KB0nLcxtn7')
        .get();
    newNewsThird = data.data();
    return newNewsThird;
  }

  Future getDataFirstDoc() async {
    var data = await FirebaseFirestore.instance
        .collection('news')
        .doc('VTMjodvUXNCPzcj2WtHy')
        .get();
    newNewsFirst = data.data();
    return newNewsFirst;
  }

  Future getDataSecondDoc() async {
    var data = await FirebaseFirestore.instance
        .collection('news')
        .doc('Z6YUPPPAk2FLIDAeN2kE')
        .get();
    newNewsSecond = data.data();
    return newNewsSecond;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getImageUrl('aswan.jpg');
    await getImageUrlTwo('image3.jpg');
    await getImageUrlThird('24701-nature-natural-beauty.jpg');

    await getDataThirdDoc();
    await getDataFirstDoc();
    await getDataSecondDoc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Detail News",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 200,
                  child: FutureBuilder(
                      future: getImageUrlTwo('image3.jpg'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text("Error:${snapshot.error}");
                        } else if (!snapshot.hasData || urlThree == null) {
                          return Center(
                            child: Image.asset(
                                "assets/images/Placeholder_view_vector.svg.png"),
                          );
                        } else {
                          return Center(
                            child: Card(
                                child: Image.network(
                              "$urlTwo",
                              fit: BoxFit.cover,
                            )),
                          );
                        }
                      })),
              FutureBuilder(
                  future: getDataThirdDoc(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error:${snapshot.error}");
                    } else if (!snapshot.hasData || newNewsThird == null) {
                      return Text("No Data found");
                    } else {
                      return ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${newNewsSecond!['title']}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "${newNewsSecond!['date']}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Text(
                                "${newNewsSecond!['describtion']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              )),
                        ),
                      );
                    }
                  }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 32, top: 25, bottom: 15),
                    child: Text("Other News",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                  Container(
                    height: 300,
                    child: FutureBuilder(
                        future: getDataFirstDoc(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("Error:${snapshot.error}");
                          } else if (!snapshot.hasData ||
                              newNewsFirst == null) {
                            return Text("No Data found");
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: Card(
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      "${newNewsFirst!['title']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 130),
                                        child: Text(
                                          "${newNewsFirst!['subtitle']}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 130),
                                        child: Text(
                                          "${newNewsFirst!['date']}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    height: 160,
                                    child: FutureBuilder(
                                        future: getImageUrl('aswan.jpg'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                "Error:${snapshot.error}");
                                          } else if (!snapshot.hasData ||
                                              urlOne == null) {
                                            return Center(
                                              child: Image.asset(
                                                  "assets/images/Placeholder_view_vector.svg.png"),
                                            );
                                          } else {
                                            return SizedBox(
                                              height: 110,
                                              child: Image.network(
                                                "$urlOne",
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                  Container(
                    height: 300,
                    child: FutureBuilder(
                        future: getDataSecondDoc(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("Error:${snapshot.error}");
                          } else if (!snapshot.hasData ||
                              newNewsThird == null) {
                            return Text("No Data found");
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: Card(
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      "${newNewsThird!['title']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 130),
                                        child: Text(
                                          "${newNewsThird!['subtitle']}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 130),
                                        child: Text(
                                          "${newNewsThird!['date']}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    height: 160,
                                    child: FutureBuilder(
                                        future: getImageUrlTwo(
                                            '24701-nature-natural-beauty.jpg'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                "Error:${snapshot.error}");
                                          } else if (!snapshot.hasData ||
                                              urlTwo == null) {
                                            return Center(
                                              child: Image.asset(
                                                  "assets/images/Placeholder_view_vector.svg.png"),
                                            );
                                          } else {
                                            return SizedBox(
                                                height: 110,
                                                child:
                                                    Image.network("$urlTwo"));
                                          }
                                        }),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ],
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    fixedSize: Size(300, 40),
                  ),
                  onPressed: () {},
                  child: Text("See All News"),
                ),
              ))
            ],
          ),
        ));
  }
}
