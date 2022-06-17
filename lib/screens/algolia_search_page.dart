import 'dart:async';
import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graffitiapp/Algolia/algoliaapplication.dart';
import 'package:graffitiapp/utils/colors.dart';
import 'package:graffitiapp/utils/global_variables.dart';
import 'package:graffitiapp/widgets%20/post_card.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final Algolia _algoliaApp = AlgoliaApplication.algolia;
  //late String _searchTerm;
  String _searchTerm = "";

  Future<List<AlgoliaObjectSnapshot>> _operation(String input) async {
    AlgoliaQuery query = _algoliaApp.instance.index("posts").search(input);
    AlgoliaQuerySnapshot querySnap = await query.getObjects();
    List<AlgoliaObjectSnapshot> results = querySnap.hits;
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
          // appBar: AppBar(
          //   shadowColor: Color.fromARGB(255, 0, 0, 0),
          //   title: 
          //   ),
        body: SingleChildScrollView(
          
          
          child: Column(children: <Widget>[
            TextField(
                onChanged: (val) {
                  setState(() {
                    _searchTerm = val;
                    
                  }
                  );
                },
                style: new TextStyle(
                  //backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    color: Color.fromARGB(255, 253, 253, 253), fontSize: 20),
                decoration: new InputDecoration(
                    //border: InputBorder.none,
                    hintText: 'Search by text...',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    prefixIcon: const Icon(Icons.search,
                        color: Color.fromARGB(255, 255, 255, 255)))),
            
            StreamBuilder<List<AlgoliaObjectSnapshot>>(
              stream: Stream.fromFuture(_operation(_searchTerm)),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Text(
                    "Start Typing",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  );
                else {
                  List<AlgoliaObjectSnapshot>? currSearchStuff = snapshot.data;
                  

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container();
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return CustomScrollView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          slivers: <Widget>[
                          SliverList(
                          delegate: SliverChildBuilderDelegate(
                            ( context,  index) {
                                  return _searchTerm.length > 0
                                      ? 
                                      DisplaySearchResult(
                                          description: currSearchStuff?[index]
                                              .data["description"],
                                          tagging: currSearchStuff?[index]
                                              .data["tagging"],
                                          username: currSearchStuff?[index]
                                               .data["username"],
                                          title: currSearchStuff?[index]
                                               .data["title"],
                                           postUrl: currSearchStuff?[index]
                                                .data["postUrl"],
                                          //  location: currSearchStuff?[index]
                                          //       .data["location"],
                                         )
                                      : Container();
                                },
                                childCount: currSearchStuff?.length ?? 0,
                              ),
                            ),
                          ],
                        );
                  }
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class DisplaySearchResult extends StatelessWidget {
  final String? description;
  final String? tagging;
  final String? username;
  final String? title;
  //final DateTime? datePublished;
  final String? postUrl;
  final GeoPoint? location;
  DisplaySearchResult({Key? key, this.description, this.tagging, this.username, this.title, this.postUrl, this.location })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    
        SingleChildScrollView(
    
    child: Column(children: <Widget>[
      
       PostCard(description: description ?? "",postUrl: postUrl?? "",title: title?? "",tagging: tagging?? "", username: username?? "",),
      //            snap: snapshot.data!.docs[index].data(),
      //          ),
      //Text('Holaaaaa'),
      // Text(
      //   description ?? "",
      //   style: TextStyle(color: Color.fromARGB(255, 248, 247, 247)),
      // ),
      // Text(
      //   tagging ?? "",
      //   style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),
      // ),
      // Text(
      //   username ?? "",
      //   style: TextStyle(color: Color.fromARGB(255, 248, 248, 248)),
      // ),
      // SizedBox(height: 20)
    ]
    )
    );
  }
}
