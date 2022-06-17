// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:graffitiapp/screens/profile_screen.dart';
// import 'package:graffitiapp/utils/colors.dart';
// import 'package:graffitiapp/utils/global_variables.dart';



// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController searchController = TextEditingController();
//   bool isShowUsers = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: mobileBackgroundColor,
//         title: Form(
//           child: TextFormField(
//             controller: searchController,
//             decoration:
//                 const InputDecoration(labelText: 'Search for a user...'),
//             onFieldSubmitted: (String _) {
//               setState(() {
//                 isShowUsers = true;
//               });
              
//             },
//           ),
//         ),
//       ),

//       body: isShowUsers
//           ? FutureBuilder(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .where(
//                     'username',
//                     isGreaterThanOrEqualTo: searchController.text,
//                   )
//                   .get(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 return ListView.builder(
//                   itemCount: (snapshot.data! as dynamic).docs.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => ProfileScreen(
//                             uid: (snapshot.data! as dynamic).docs[index]['uid'],
//                           ),
//                         ),
//                       ),
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(
//                             (snapshot.data! as dynamic).docs[index]['photoUrl'],
//                           ),
//                           radius: 16,
//                         ),
//                         title: Text(
//                           (snapshot.data! as dynamic).docs[index]['username'],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             )
//            :
//             FutureBuilder(
          
          
//               future: FirebaseFirestore.instance
//                   .collection('posts')
//                   .orderBy('datePublished')
//                   .get(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(), //AIXÒ HO RETORNA PER SI snapshot NO HI HA DATA
//                   );
//                 }
              
//               return StaggeredGridView.countBuilder(
//                //return ListView(
//                   crossAxisCount: 3,
//                   itemCount: (snapshot.data! as dynamic).docs.length,
//                   itemBuilder: (context, index) => Image.network(
//                     (snapshot.data! as dynamic).docs[index]['postUrl'],
//                     fit: BoxFit.cover,
//                   ),
//                   staggeredTileBuilder: (index) => MediaQuery.of(context)
//                               .size
//                               .width >
//                           webScreenSize
//                       ? StaggeredTile.count(
//                           (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
//                       : StaggeredTile.count(
//                           (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
//                   mainAxisSpacing: 8.0,
//                   crossAxisSpacing: 8.0,
//               );
//               },
//              ),
//     );
//   }
// }
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