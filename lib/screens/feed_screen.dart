import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graffitiapp/models/post.dart';
import 'package:graffitiapp/screens/signup_screen.dart';
import 'package:graffitiapp/utils/colors.dart';
import 'package:graffitiapp/utils/global_variables.dart';
import 'package:graffitiapp/widgets%20/post_card.dart';
import 'package:graffitiapp/screens/post_screen.dart';
import 'package:intl/intl.dart';


class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              'Gallery',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
             Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(                    //Color gris on es veuen les imatges
                  color: Color.fromARGB(255, 223, 221, 221),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), //bordes redons
                    topRight: Radius.circular(30),
                  ),
                ),
                
                
                child: 
                
                  
                  FutureBuilder(
                  
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .get(),
                      
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                        return 
                        GestureDetector(   //aquí es on si presionem a cualsevol imatge nem a la pantalla de post_screen on en mostrarà el contingut en més detall de la imatge
                            onTap: () { 
                               Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => post_screen(
                              imagePath: (snap['postUrl']).toString(),
                              
                              data:  DateFormat.yMMMd().format(snap['datePublished'].toDate()).toString(),
                              username: (snap['username']).toString(),
                              description: (snap['description']),
                              index: index,
                              title: snap['title'] ,
                              location: snap['location'],
                              tagging: snap['tagging'],
                            ),
                          ),
                        );                            },
                            child: Container(                 
                                child: Image(
                                  image: NetworkImage(snap['postUrl']),
                                  fit: BoxFit.cover,
                                ),
                                                  

                        ),
                        );
                      },
                    );
                  },
                )                  
              )
             )
            ],
             
      )
      )
      
    );
  }
}