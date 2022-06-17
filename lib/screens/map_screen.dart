import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graffitiapp/screens/post_screen.dart';
import 'package:graffitiapp/utils/global_variables.dart';
import 'package:intl/intl.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController myController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.785834 ,-12.40641), zoom: 14.0);


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

  void initMarker(specify, specifyId)async {
    final  MarkerId markerID = MarkerId(specifyId);
   
    final Marker marker = Marker(markerId: markerID , position: LatLng(specify['location'].latitude,specify['location'].longitude ),
    
    infoWindow: InfoWindow(title: specify['title'], snippet: 'by: '+specify['username'],  

    // si es clica al marcador et carrga la pagina de post screen
     onTap: () { Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => post_screen(
                              imagePath: (specify['postUrl']).toString(),
                              
                              data:  DateFormat.yMMMd().format(specify['datePublished'].toDate()).toString(),
                              username: (specify['username']).toString(),
                              description: (specify['description']),
                              index: 1,
                              title: specify['title'] ,
                              location: specify['location'],
                              tagging: specify['tagging'],
                            ),
                          ),
                        );                            },
    ),

    );
    
    setState(() {
      markers[markerID] = marker;
      

    });
  }




  getmarkerdata() async{
    
    FirebaseFirestore.instance.collection('posts').get().then((docs){
      if(docs.docs.isNotEmpty){
        
        for(int i = 0; i < docs.docs.length; i++ ){
          
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
  }
  @override
  void initState(){
    getmarkerdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        
      ),

      body: Stack(
        children: [
        GoogleMap(
              markers: Set<Marker>.of(markers.values),
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomGesturesEnabled: true,

              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                myController = controller;
              },
              initialCameraPosition: initialCameraPosition

                 
            ),
        Row(
            children: <Widget>[
            
           ElevatedButton(
             
            onPressed: () async {
                      Position position = await _determinePosition();
                       
            
                
        setState(() {     
        
        //_locationController = GeoPoint(position.latitude, position.longitude); 
        myController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(position.latitude, position.longitude), 13.0));
      
   });
            },
                child: const Text("Center map on current location")),
            ])
        
        
        ]
        )        
    );
  }
}
