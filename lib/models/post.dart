import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String title;
  final String tagging;
  final GeoPoint location;
  final String uid;
  final String username;
  //final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.title,
      required this.tagging,
      required this.location,
      //required this.likes,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      //likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      tagging: snapshot['tagging'],
      location: snapshot['location'],
      title: snapshot['title']


    );
  }

   Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        //"likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        "tagging": tagging,
        "location": location,
        "title": title


      };
}