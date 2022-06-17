import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graffitiapp/provider/user_provider.dart';
import 'package:graffitiapp/utils/colors.dart';
import 'package:graffitiapp/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:graffitiapp/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView( //aquí indiquem en quina pagina volem veure en tot moment 
        children: homeScreenItems, //aquí estan les diverses pagines
        physics: const NeverScrollableScrollPhysics(), //no es pugui canvar de paguines amb scroll
        controller: pageController,
        onPageChanged: onPageChanged,
      ),


      //aquí es la barra de baix tasques
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          //HOME
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,                                           
              color: (_page == 0) ? primaryColor : secondaryColor, //el conlor quan seleccionem el item
            ),
            label: '',
            backgroundColor: primaryColor,
          ),

          //BUSCADOR
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),



          //MAP
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
              color: (_page == 2) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),

          //AFEGIR POST    
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: (_page == 3) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),

          //USER PROFILE
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 4) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
      
    );
  }
}