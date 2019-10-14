import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prodesys_mobi/src/db/my_database.dart';
import 'package:prodesys_mobi/src/domain/singleton.dart';

import 'edtCliente_page.dart';

class ClientesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // temporario para testar registros
   //MyDatabase.instance.clienteDAO.addCliente(Cliente(nome: "joaozinho de Deus Sobe", subirCloud: true));
   //MyDatabase.instance.clienteDAO.addCliente(Cliente(nome: "Maria Bonita Não Sobe", subirCloud: false));


    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes") ,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){
            appData.wtlopc = "I";
            Navigator.push(context, CupertinoPageRoute(builder: (context){
              return AddClientePage();
            }));
            // teste de update
            //MyDatabase.instance.clienteDAO.updateCliente((Cliente(id: 1, nome: "joaozinho Troca Nome")));
          },)
        ],
        ),
        body: _body(context),
    );
  }

_body(context) {
  return StreamBuilder<List<Cliente>>(
    initialData: [],
    stream: MyDatabase.instance.clienteDAO.listAll(),
    builder: (context, snapshot) {
      if(!snapshot.hasData)
      return Center(
        child: CircularProgressIndicator(),
      );
      else if(snapshot.data.length == 0)
      return Center(
        child: Text("Nenhum cliente Cadastrado"),
         );
      else   
       return
       ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index){
          Cliente cli = snapshot.data[index];
          return ListTile(
            title: Text(cli.nome),
            subtitle: Text(cli.id.toString()),
            leading: IconButton(icon: Icon(Icons.delete),onPressed: (){
              MyDatabase.instance.clienteDAO.removeCliente(cli.id);
            },),
            onTap: (){
              appData.wtlopc = "A";
              appData.wtlCliNom = cli.nome;
              appData.wtlCliId = cli.id;
              appData.wtlCliIdHas = cli.idHas;
              appData.wtlCliIdProde = cli.idProde;
               Navigator.push(context, CupertinoPageRoute(builder: (context){
              return AddClientePage();
                 }));
            },
            trailing: 
             cli.subirCloud ? Icon(Icons.cloud_off) : Icon(Icons.cloud_done),
          );
        },
      );
    }
  ,);
}

} // fim de tudo


