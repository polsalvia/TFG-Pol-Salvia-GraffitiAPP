// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:graffitiapp/utils/colors.dart';
// import 'package:graffitiapp/utils/global_variables.dart';
// import 'package:graffitiapp/widgets%20/post_card.dart';


// class PostScreen extends StatefulWidget {
//   const PostScreen({Key? key}) : super(key: key);
//   //final  String imagePath;

//   @override
//   State<PostScreen> createState() => _PostScreenState();
    
//   // //final String title;
//   // //final String photographer;
//   // //final String price;
//   // //final String details;
//   // final int index;
//   // PostScreen(
//   //     {required this.imagePath,
//   //     //required this.title,
//   //     //required this.photographer,
//   //     //required this.price,
//   //     //required this.details,
//   //     required this.index});
   
// }

// class _PostScreenState extends State<PostScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor:
//           width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
//       appBar: width > webScreenSize
//           ? null
//           : AppBar(
//               backgroundColor: mobileBackgroundColor,
//               centerTitle: false,
//               title: SvgPicture.asset(
//                 'assets/GraffitiAPP_logo.svg',
//                 color: primaryColor,
//                 height: 32,
//               ),
//             ),
//         body: StreamBuilder(          //guardem la informació de tot el tema dels posts a firestore
//           stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//           builder: (context,
//               AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//            if (snapshot.connectionState == ConnectionState.waiting) {
//              return const Center(
//                child: CircularProgressIndicator(),
//              );
//            }
//            return ListView.builder(
//              itemCount: snapshot.data!.docs.length,
//              itemBuilder: (ctx, index) => Container(
//                margin: EdgeInsets.symmetric(
//                  horizontal: width > webScreenSize ? width * 0.3 : 0,
//                  vertical: width > webScreenSize ? 15 : 0,
//              ),
//                child: PostCard(                              //Data
//                 snap: snapshot.data!.docs[index].data(),
//               ),
//             ),
//           );
//          },
//        ),
//      );
//   }
// }