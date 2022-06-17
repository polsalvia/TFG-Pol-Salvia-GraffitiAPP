import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graffitiapp/provider/user_provider.dart';
import 'package:graffitiapp/resources/firestore_methods.dart';
import 'package:graffitiapp/utils/colors.dart';
import 'package:graffitiapp/utils/global_variables.dart';
import 'package:graffitiapp/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:graffitiapp/models/user.dart' as model;

class PostCard extends StatefulWidget {
  final String? description;
  final String? tagging;
  final String? username;
  final String? title;
  //final DateTime? datePublished;
  final String? postUrl;
  
  PostCard({
    //Key? key,
      required this.postUrl,
      //required this.datePublished,
      required this.username,
      required this.description,
      required this.tagging,
      required this.title
  }) ;
  //: super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    super.initState();

  }

   deletePost(String postId) async {
     try {
       await FireStoreMethods().deletePost(postId);
     } catch (err) {
       showSnackBar(
         context,
         err.toString(),
       );
     }
   }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return Container(
     // boundary needed for web
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
        ),
        color: mobileBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),

      child: Column(
        children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    widget.postUrl!,
                    fit: BoxFit.cover,
                  ),
                ),


          Container(
              
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: 
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TextSpan(
                        //   text: ' ${widget.snap['description']}',
                      //  ),
                      ],
                    ),
                  ),
                ),

                
                 Container(
                  child: 
                   Text(
                          'By: '+widget.username!+"\n" ,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                  
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
                Container(
                  child: 
                   Text(
                          'Description: '+widget.description! +"\n" +'Tagging: ' + widget.tagging!,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                  
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ],
            ),
          )
        ],
        ),
      
       
      );
  }
}