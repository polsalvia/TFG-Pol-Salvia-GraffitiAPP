import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graffitiapp/screens/add_post_screen.dart';
import 'package:graffitiapp/screens/algolia_search_page.dart';
import 'package:graffitiapp/screens/feed_screen.dart';
import 'package:graffitiapp/screens/map_screen.dart';
import 'package:graffitiapp/screens/profile_screen.dart';
import 'package:graffitiapp/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  //const FeedScreen(),
  //const SearchScreen(),
  
  const FeedScreen(),
  const SearchBar(),
  const MapsScreen(),
  const AddPostScreen(),
  
  ProfileScreen(
    
    uid: FirebaseAuth.instance.currentUser!.uid,
  
  ),
];
 