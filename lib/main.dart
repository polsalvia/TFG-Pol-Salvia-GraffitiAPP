import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graffitiapp/provider/user_provider.dart';
import 'package:graffitiapp/responsive/mobile_screen_layout.dart';
import 'package:graffitiapp/responsive/responsive_layout_screen.dart';
import 'package:graffitiapp/responsive/web_screen_layout.dart';
import 'package:graffitiapp/screens/login_screen.dart';
import 'package:graffitiapp/screens/signup_screen.dart';
import 'package:graffitiapp/utils/colors.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //en assegurem que els widgets
  //inicialitzem Firebase, que l'inicialtitzem diferent per web que per mobile i per això el if
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAgHHlBnNjeIFEDYDFxP0H17XOf_Kwnp7g',
        appId: '1:350029108553:web:c1de9fd513a5f5613ef698',
        messagingSenderId: '350029108553',
        projectId: 'grafittiapp',
        
        storageBucket: "grafittiapp.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
 @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grafitti App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
            // return MaterialApp(
            //   home: PostScreen(),
            // );
         },
        ),
      ),
   );
  }
}