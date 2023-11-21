import 'dart:convert';

import 'package:codeware_company_task/widgets/custom_textform_filed_widget.dart';
import 'package:flutter/material.dart';

import '../models/android_version_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  late List<dynamic> input1;
  late List<dynamic> input2;
  late List<AndroidVersion> androidVersions;
  bool isInput = true;
  int? searchResultId;
  String? searchResultTitle;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the input data
    input1 = jsonDecode(
        '[{"0":{"id":1,"title":"Gingerbread"},"1":{"id":2,"title":"Jellybean"},"3":{"id":3,"title":"KitKat"}},[{"id":4,"title":"Lollipop"},{"id":5,"title":"Pie"},{"id":6,"title":"Oreo"},{"id":7,"title":"Nougat"}]]');
    input2 = jsonDecode('[{"0":{"id":1,"title":"Gingerbread"},"1":{"id":2,"title":"Jellybean"},"3":{"id":3,"title":"KitKat"}},{"0":{"id":8,"title":"Froyo"},"2":{"id":9,"title":"Éclair"},"3":{"id":10,"title":"Donut"}},[{"id":4,"title":"Lollipop"},{"id":5,"title":"Pie"},{"id":6,"title":"Oreo"},{"id":7,"title":"Nougat"}]]');

    // Parse the input data into a list of AndroidVersion objects
    androidVersions = _parseAndroidVersions(input1);
    androidVersions = _parseAndroidVersions(input2);
  }



  //.............dispose search controller.....................
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }





  List<AndroidVersion> _parseAndroidVersions(List<dynamic> input) {
    final versions = <AndroidVersion>[];
    for (final obj in input) {
      if (obj is Map<String, dynamic>) {
        for (final version in obj.values) {
          versions.add(AndroidVersion(id: version['id'], title: version['title']));
        }
      } else if (obj is List<dynamic>) {
        for (final version in obj) {
          versions.add(AndroidVersion(id: version['id'], title: version['title']));
        }
      }
    }
    return versions;
  }

  AndroidVersion? findAndroidVersionById(int id) {
    for (final version in androidVersions) {
      if (version.id == id) {
        return version;
      }
    }
    return null;
  }


  String? searchAndroidVersionById(int id) {
    AndroidVersion? version = findAndroidVersionById(id);
    return version != null ? version.title : null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Android Versions'), centerTitle: true,),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),

        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


            //...............search textformfiled.................................

            // CustomTextFormFiledWidget(
            //       controller: searchController,
            //       hintText: 'Search android version by id',
            //       suffixIcon: GestureDetector(
            //         onTap: () {
            //           int idToSearch = int.tryParse(searchController.text) ?? 0;
            //           String? title = searchAndroidVersionById(idToSearch);
            //           setState(() {
            //             searchResultId = idToSearch;
            //             searchResultTitle = title;
            //           });
            //         },
            //         child: Icon(Icons.search),
            //       ),
            //     ),
            //
            // SizedBox(height: 25,),
            //
            // searchResultId != null && searchResultTitle != null ? Container(
            // height: 100,
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black),),
            //
            //       child: Padding(
            //         padding:  EdgeInsets.only(top: 8.0),
            //         child: Column(
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 GestureDetector(
            //                   onTap: () {
            //                     setState(() {
            //                       searchResultId = null;
            //                       searchResultTitle = null;
            //                       searchController.clear();
            //                     });
            //                   },
            //                   child: CircleAvatar(child: Icon(Icons.close, color: Colors.red)),
            //                 ),
            //               ],
            //             ),
            //
            //             Text("Search Id: $searchResultId", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            //             Divider(height: 3, color: Colors.red),
            //             SizedBox(height: 5),
            //             Text('Title: $searchResultTitle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            //           ],
            //         ),
            //       ),
            //     ) :
            // SizedBox.shrink(),
           CustomTextFormFiledWidget(
                  controller: searchController,
                  hintText: 'Search android version by id',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      int idToSearch = int.tryParse(searchController.text) ?? 0;
                      String? title = searchAndroidVersionById(idToSearch);
                      setState(() {
                        searchResultId = idToSearch;
                        searchResultTitle = title;
                      });
                    },
                    child: Icon(Icons.search),
                  ),
                ),

           SizedBox(height: 25,),

           (searchResultId != null && searchResultTitle != null) ? Container(
                  //height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                searchResultId = null;
                                searchResultTitle = null;
                                searchController.clear();
                              });
                            },
                            child: Padding(
                              padding:  EdgeInsets.only(right: 10.0,top: 10),
                              child: CircleAvatar(
                                  backgroundColor: Colors.pinkAccent,
                                  child: Icon(Icons.close, color: Colors.white,size: 23,)),
                            ),
                          ),
                        ],
                      ),
                      Text("Search Id: $searchResultId", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      SizedBox(height: 5),
                      Text('Title: $searchResultTitle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,)
                    ],
                  ),
                ) : (searchResultId != null) ?
           Container(
             height: 100,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               border: Border.all(color: Colors.black),
             ),

           child: Padding(padding: EdgeInsets.all(16.0),
             child: Column(
               children: [
                 GestureDetector(
                          onTap: () {
                            setState(() {
                              searchResultId = null;
                              searchResultTitle = null;
                              searchController.clear();
                            });
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.pinkAccent,
                              child: Icon(Icons.close, color: Colors.white)),
                        ),
                 Text('ID not found', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red),),
               ],
             ),
           ),) : SizedBox.shrink(),


            ElevatedButton(
              onPressed: () {
                setState(() {
                  isInput = true;
                });
              },
              child: const Text('Parse Input 1'),
            ),
            SizedBox(height: 10,),

            // >>>>>>>>>>>>>>>>>>>>>>>>>>>>..input 2<<<<<<<<<<<<<<<<<<<<<<........
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isInput = false;
                });
              },
              child: const Text('Parse Input 2'),
            ),
            const SizedBox(height: 16),

            const Text('Android Versions:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            const SizedBox(height: 16),

            Container(
              child: Column(
                children: [
                  isInput == true ? Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),

                    child: Column(
                      children: [
                        Text(
                          "Output - 01",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${androidVersions[0].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${androidVersions[1].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text("                     "),
                            Text(
                              "${androidVersions[2].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${androidVersions[3].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${androidVersions[4].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${androidVersions[5].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${androidVersions[6].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                      : isInput == false
                      ? Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),

                    child: Column(
                      children: [

                        Text("Output - 02", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${androidVersions[0].title}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),

                            Text("${androidVersions[1].title}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),

                            Text("                     "),
                            Text("${androidVersions[2].title}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                          ],
                        ),
                        SizedBox(height: 15),


                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${androidVersions[3].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text("          "),
                            Text(
                              "${androidVersions[4].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${androidVersions[5].title}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${androidVersions[6].title}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                            Text("${androidVersions[7].title}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                            Text("${androidVersions[8].title}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                            Text("${androidVersions[9].title}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ],
                    ),
                  )
                      : SizedBox.shrink(),
                ],
              ),
            ),


            SizedBox(height: 16),





          ]),
        ),
      ),
    );
  }
}











