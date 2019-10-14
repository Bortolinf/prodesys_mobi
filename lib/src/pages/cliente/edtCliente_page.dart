import 'package:flutter/material.dart';
import 'package:prodesys_mobi/src/db/my_database.dart';
import 'package:prodesys_mobi/src/domain/singleton.dart';

class AddClientePage extends StatefulWidget {
  @override
  _AddClientePageState createState() => _AddClientePageState();
}

class _AddClientePageState extends State<AddClientePage> {
  String nome;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _nome;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _nome = TextEditingController(text: "");
    if (appData.wtlopc == "A") {
      _nome = TextEditingController(text: appData.wtlCliNom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(title: Text(
        appData.wtlopc == "I" ? "Incluir Cliente" : "Editar Cliente",
        ),),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
             Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _nome,
                  validator: (value) => (value.isEmpty || value.length < 3)
                      ? "Informe um Nome Válido"
                      : null,
                  style: style,
                  decoration: InputDecoration(
                     // prefixIcon: Icon(Icons.),
                      labelText: "Nome",
                      border: OutlineInputBorder()),
                ),
              ),

               Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          child: Text(
                            "Salvar Cliente",
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: (){
                              if (_formKey.currentState.validate()) {
                                if(appData.wtlopc == "I") {
                                  MyDatabase.instance.clienteDAO.addCliente(Cliente(
                                    nome: _nome.text, 
                                    subirCloud: true, 
                                    dtaHorAtz: DateTime.now(),
                                    idHas: 0,
                                    idProde: 0,
                                     ),);
                                } else {
                                  MyDatabase.instance.clienteDAO.updateCliente(
                                    Cliente(
                                      id: appData.wtlCliId,
                                      idHas: appData.wtlCliIdHas,
                                      idProde: appData.wtlCliIdProde, 
                                      nome: _nome.text, 
                                      subirCloud: true,
                                      dtaHorAtz: DateTime.now()
                                      ));
                                }
                                Navigator.of(context).pop();
                             }
                          }
                        ),
                      ),
                    ),


          ],
        ),
      )
      
    );
  }
}
