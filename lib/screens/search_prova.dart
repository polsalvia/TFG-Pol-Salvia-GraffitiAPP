// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:graffitiapp/utils/colors.dart';
// import 'package:graffitiapp/utils/global_variables.dart';
// import 'package:graffitiapp/widgets%20/post_card.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController searchController = TextEditingController();
//   List _resultsList = [];
//   var searchlist = FirebaseFirestore.instance;
//   String name = "";

//   @override
//   Widget build(BuildContext context) {
  
//   final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor:
//           width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
//           appBar: AppBar(
//         backgroundColor: mobileBackgroundColor,
//         title: Form(
//           child: TextFormField(
//             controller: searchController,
//             decoration:
//                 const InputDecoration(labelText: 'Search ...'),
//                  onChanged: (val) {
//               setState(() {
//                 print(name);
//                 name = val;
//               });}

//           ),
//         ),
//       ),
//       body:   
//        StreamBuilder<QuerySnapshot>(stream: (name != "" && name != null)        

//              ? FirebaseFirestore.instance
//                 .collection('posts')
//                 .where("description", isGreaterThanOrEqualTo: name )
//                 //.where("tagging", isGreaterThanOrEqualTo: name )
//                 .snapshots()
//             : FirebaseFirestore.instance.collection("posts").snapshots(),
//      builder: (context, snapshot) {

//           return
//            (snapshot.connectionState == ConnectionState.waiting)
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     print(index);
//                     DocumentSnapshot data = snapshot.data!.docs[index];
                   
           
//                     return 
//             //         ListView.builder(
//             // itemCount: snapshot.data!.docs.length,
//             // itemBuilder: (ctx, index) => Container(
//             //   margin: EdgeInsets.symmetric(
//             //     horizontal: width > webScreenSize ? width * 0.3 : 0,
//             //     vertical: width > webScreenSize ? 15 : 0,
//             //   ),
//             //   child: Text('holi')
//               // PostCard(
//               //   snap: snapshot.data!.docs[index].data(),
//               // ),
//            // )
//              //       );
//                     Container(
//                       padding: EdgeInsets.only(top: 16),
//                       child: Column(
//                         children: [
//                           //Text(data['description'])
//                           PostCard(
//                  snap: snapshot.data!.docs[index].data(),
//                ),
//                           ],
//                       ),
//                     );
     
     
       

                      
//                   }
//                   );
//         }
//       )

//       );
//   }
// }