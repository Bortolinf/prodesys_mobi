import 'package:flutter/material.dart';
import 'package:prodesys_mobi/src/domain/singleton.dart';
import 'package:prodesys_mobi/src/models/user_repository.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {

  final BuildContext context;
  CustomDrawer(this.context);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Icon(Icons.person, size: 80,),
            accountName: Text(appData.wtlUsrName),
            accountEmail: Text(appData.wtlUser.email),
                 
          ),
          ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Fazer LogOff"),
                onTap: () {
                //  pushReplacement(context, LoginPage());
                Navigator.of(context).pop();
                user.signOut();
                },
              ),
        ],
      ),
    );
  }
}
