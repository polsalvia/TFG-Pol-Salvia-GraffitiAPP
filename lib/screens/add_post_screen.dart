
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_geocoder/geocoder.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:flutter_tags/flutter_tags.dart';
import 'package:graffitiapp/provider/user_provider.dart';
import 'package:graffitiapp/resources/firestore_methods.dart';
import 'package:graffitiapp/screens/feed_screen.dart';
import 'package:graffitiapp/screens/search_places_screen.dart';
import 'package:graffitiapp/utils/colors.dart';
import 'package:graffitiapp/utils/utils.dart';
//import 'package:graffitiapp/widgets%20/text_field_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:location/location.dart';
 //import 'package:flutter/services.dart';




class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  LatLng? _locationData;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  late GeoPoint _locationController ;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _taggingController = TextEditingController();

// Only if available 



  _selectImage(BuildContext parentContext) async {     //per selecionar les imatges hi ha les 3 opccions, de Camera, Galery or Cancel 
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Camera'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
  late LatLng currentPostion;
    _selectLocation(BuildContext parentContext) async {     //per selecionar les imatges hi ha les 3 opccions, de Camera, Galery or Cancel 
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select location'),
          children: <Widget>[
            //CURRENT LOCATION
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('GET CURRENT LOCATION'),
                 onPressed: () async {
          Position position = await _determinePosition();
            
                
        setState(() {
          currentPostion = LatLng(position.latitude, position.longitude);
          _locationData=  LatLng(position.latitude, position.longitude);
          _locationController = GeoPoint(position.latitude, position.longitude); 
          //print(currentPostion);
        }
       
        );
        Navigator.pop(context);
                }
                ),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('ADD LOCATION MANUALLY'),
                  onPressed: () {
        _navigateAndDisplaySearchPlacesScreen(context);
      },
                      
                ),
                
                      
                  //Uint8List file = await pickImage(ImageSource.gallery);
                  //setState(() {
                    //_file = file;
                 // });
                //}
                //),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("DONE"),
               onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }





   Future<void> _navigateAndDisplaySearchPlacesScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPlacesScreen()),
    );

    _locationData = result ;
    //print(_locationData);
    setState(() {
         _locationData = result ;
          _locationController = GeoPoint(result.latitude, result.longitude); 
        });
  }
  
  void postImage(String uid, String username, String profImage) async {
  
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
        _taggingController.text,
        _titleController.text,
        _locationController

      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',                      //la foto esta penjada
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
   
    

    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }
  //Function para determinar la localización
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
  
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(
                Icons.upload,              //icona de subir foto
              ),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),       //fletxa d'anar endarrera
                onPressed: clearImage,
              ),
              title: const Text(
                'Post a graffiti',
              ),
              centerTitle: false,
              actions: <Widget>[
                TextButton(
                  onPressed: () => postImage(
                    userProvider.getUser.uid,
                    userProvider.getUser.username,
                    userProvider.getUser.photoUrl,
                  ),

                  child: const Text(
                    "Post",
                    style: TextStyle(
                        color: Color.fromARGB(255, 196, 200, 207), //color de la paraula post
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )
              ],
            ),
            // POST FORM
            body: ListView(
              children: <Widget>[
                isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                const Divider(),
                 Column( /////

                   //mainAxisAlignment: MainAxisAlignment.center,
                   //crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     CircleAvatar(                      //el cercle on es veu la foto de perfil
                       backgroundImage: NetworkImage(
                       userProvider.getUser.photoUrl,
                        
                        
                       ),
                     ),
                    //TITLE 
                      SizedBox(
                      width: MediaQuery.of(context).size.width ,
                      child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: 'Title...',
                            suffixIcon: IconButton(
                              onPressed: _titleController.clear,
                              icon: Icon(Icons.clear),
                            ),
                          ),
                        )
                    ),


                     const SizedBox(
                      height: 10,
                    ),

                    //DESCRIPTION 
                    SizedBox(
                      width: MediaQuery.of(context).size.width ,
                      child: TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Description...',
                            suffixIcon: IconButton(
                              onPressed: _descriptionController.clear,
                              icon: Icon(Icons.clear),
                            ),
                          ),
                        )
                    ),
                     const SizedBox(
                      height: 10,
                    ),

                    //TAGGING
                      SizedBox(
                      width: MediaQuery.of(context).size.width ,
                      child: TextField(
                          controller: _taggingController,
                          decoration: InputDecoration(
                            hintText: '#tagging #...',
                            suffixIcon: IconButton(
                              onPressed: _taggingController.clear,
                              icon: Icon(Icons.clear),
                            ),
                          ),
                        )
                    ),


                    const SizedBox(
                      height: 10,
                    ),
                     //ADD LOCATION
                       Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                            primary: Color.fromARGB(255, 33, 116, 211),
                          ),
                           onPressed: () => _selectLocation(context),

                          child: const Text('ADD LOCATION'),

                          ),    
                         
                          Text(_locationData!=null? 'Long: ${_locationData!.longitude}, Lat: ${_locationData!.latitude}'
                           : '----',), 
                          ],
                          ),  
                    
                     const SizedBox(
                      height: 10,
                    ),
                  
                    
                    
                    //IMAGE
                    SizedBox(                       
                      height: 280.0,
                      width: 370.0,
                      
                      child: 
                      
                      AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(_file!),                            
                          )),                           
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}