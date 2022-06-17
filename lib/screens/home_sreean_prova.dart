// import 'package:flutter/material.dart';
// import 'package:graffitiapp/widgets%20/post_card_de_prova.dart';
// //import 'details_page.dart';



// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlueAccent,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             SizedBox(
//               height: 40,
//             ),
//             Text(
//               'Gallery',
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: 40,
//             ),





//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 30,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemBuilder: (context, index) {
//                    return RawMaterialButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailsPage(
//                               imagePath: _images[index].imagePath,
//                               title: _images[index].title,
//                               photographer: _images[index].photographer,
//                               price: _images[index].price,
//                               details: _images[index].details,
//                               index: index,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Hero(
//                         tag: 'logo$index',
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             image: DecorationImage(
//                               image: AssetImage(_images[index].imagePath),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   //itemCount: _images.length,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ImageDetails {
//   final String imagePath;
//   final String price;
//   final String photographer;
//   final String title;
//   final String details;
//   ImageDetails({
//     required this.imagePath,
//     required this.price,
//     required this.photographer,
//     required this.title,
//     required this.details,
//   });
// }