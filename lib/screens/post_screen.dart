import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:graffitiapp/utils/colors.dart';

class post_screen extends StatelessWidget {
  final  String imagePath;
  final String data;
  final String username;
  final String description;
  final String title;
  final String tagging;
  final GeoPoint location;
  final int index;
   
  post_screen(
      {
      required this.imagePath,
      required this.data,
      required this.username,
      required this.description,
      required this.index,
      required this.tagging,
      required this.location,
      required this.title
      });
  @override

 
  Widget build(BuildContext context) {

//     Future<List<Placemark>> placemarkFromCoordinates(
//   double latitude,
//   double longitude, {
//   String? localeIdentifier,
// }) =>
//     GeocodingPlatform.instance.placemarkFromCoordinates(
//       latitude,
//       longitude,
//       localeIdentifier: localeIdentifier,
//     );
//     print(placemarkFromCoordinates(location.latitude, location.longitude));

//List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);



    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Hero(
              tag: 'logo$index',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                     image: DecorationImage(
                       image: NetworkImage(imagePath),
                       fit: BoxFit.fitHeight,
                     ),
                  ),
                ),
              ),
            ),
            Container(
              height: 260,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    //child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  <Widget>[
                        Text(
                          title,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Text(
                          'by: $username',
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text (
                          '$data',
                          style: const  TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      
                       Text('Lat: ${location.latitude} Longitude: ${location.longitude}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 111, 172, 252),
                            fontSize: 10,
                          ),),

                        const SizedBox(
                         height: 24,
                        ),
                        Text(
                          'Description: $description',
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                         height: 24,
                        ),
                        Text(
                          'Tagging: $tagging',                       
                          style: const TextStyle(
                            color: Color.fromARGB(255, 119, 119, 119),
                            fontSize: 14,
                          ),
                        ),

                      ],
                    ),
                    //)
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          color: const  Color.fromARGB(255, 152, 154, 155),
                          child: const Text(
                            'Back',
                            style:  TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      
                      
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}