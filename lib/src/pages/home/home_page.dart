import 'package:flutter/material.dart';
import 'package:prodesys_mobi/src/domain/singleton.dart';
import 'package:prodesys_mobi/src/pages/cliente/clientes_page.dart';
import 'package:prodesys_mobi/src/pages/sincro/sincro_page.dart';
import 'package:prodesys_mobi/src/utils/nav.dart';
//import 'package:prodesys_mobi/pages/clientes_page.dart';
//import 'package:prodesys_mobi/pages/produtos_page.dart';
//import 'package:prodesys_mobi/pages/programacao_page.dart';
//import 'package:prodesys_mobi/pages/relatorios_page.dart';
import 'package:prodesys_mobi/src/widgets/custom_drawer.dart';
import 'package:prodesys_mobi/src/widgets/menu_button.dart';



const Color _kFlutterBlue = Color(0xFF003D75);

class ItemMenu {
  String texto;
  Icon icone;
  Function functionName;
  ItemMenu(this.texto, this.icone, this.functionName);
}



// ----------------------------------------------------


class HomePage extends StatelessWidget {

  final String uid = appData.uid;


  @override
  Widget build(BuildContext context) {
 
    
    return
    Scaffold(
      appBar: AppBar(
        title: Text("Prodesys Mobi"),
      ),
      drawer: CustomDrawer(context),
      body: _body2(context),
    );
  }



  _body2(context) {
    List<ItemMenu> menuItens = [
      ItemMenu("Meus Clientes", Icon(Icons.people, size: 50.0, color: _kFlutterBlue,), onClickClientes),
      ItemMenu("Produtos", Icon(Icons.shopping_basket, size: 50.0, color: _kFlutterBlue,), onClickProdutos),
      ItemMenu("Sincronizar", Icon(Icons.swap_vert, size: 50.0, color: _kFlutterBlue,), onClickSincro),
    //  ItemMenu("Finanças", Icon(Icons.monetization_on, size: 50.0, color: _kFlutterBlue,) ,onClickFinancas),
    //  ItemMenu("Relatórios", Icon(Icons.receipt, size: 50.0, color: _kFlutterBlue,) ,onClickRelatorios),
    ];

    return 
    Container(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
        color: Colors.teal[50],
        child:
        
         GridView.builder(
    padding: EdgeInsets.all(2.0),
    
    gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount: menuItens.length,
    itemBuilder: (context, index) {
      return _itemView(context, menuItens, index);
    },
        ),
      );
  }

_itemView(context, List<ItemMenu> menuItens, int index) {
  ItemMenu menu = menuItens[index];
  return SizedBox(
          child: MenuButton(menu.texto, menu.icone, onPressed: () => menu.functionName(context),),
        //      Icon(Icons.contacts, size: 50.0, color: _kFlutterBlue),
        //      onPressed: () => onClickClientes(context)),
        );
}



  void onClickProdutos(BuildContext context) async {
   // String s = await push(context, ProdutosPage());
   // print(">> $s");
   print("PRODUTOS");
   print("CNPJ emp: ${appData.cnpjEmp}");
   print("uid: ${appData.uid}");
   print(appData.wtlUser.email);
  }


  void onClickClientes(BuildContext context) async {
    String s = await push(context, ClientesPage());
    print(">> $s");
  }


  void onClickSincro(BuildContext context) async {
    String s = await push(context, SincroPage());
    print(">> $s");
  }


} // fim de tudo
