import 'package:flutter/material.dart';
import 'package:prodesys_mobi/src/blocs/ConnectionStatusBloc.dart';
import 'package:prodesys_mobi/src/models/user_repository.dart';
import 'package:prodesys_mobi/src/pages/home/home_page.dart';
import 'package:prodesys_mobi/src/pages/login/login_page.dart';
import 'package:prodesys_mobi/src/pages/login/signup_page.dart';
import 'package:provider/provider.dart' as providerU;
import 'package:bloc_pattern/bloc_pattern.dart';

void main() { 
  
  runApp(MyApp());

}



class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            key: Key('materialapp'),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.blue[800],
              accentColor: Colors.blueGrey[300],
            ),
      home: HomeScreen(),
    );
  }
}



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      blocs: [
        Bloc((i) => ConnectionStatusBloc()),
      ],
      child: 
     providerU.ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: providerU.Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return HomePage();
            case Status.NewUser:
            case Status.Registering:
            case Status.Unregistred:
              return SignUpPage();
          }
          return null; // para nao dar erro
        },
      ),
    ),
    );
    
  }
}



class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Aguarde ..."),
      ),
    );
  }
}





