import 'package:flutter/material.dart';
import 'package:prodesys_mobi/src/models/user_repository.dart';
import 'package:provider/provider.dart';





class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cnpjController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // salva campo c/estado do Scaffold p/usar nas fnções lá de baixo
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: (){
                user.signOut();
              },),
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    textCapitalization: TextCapitalization.words,
                    validator: (text) {
                      if (text.isEmpty) return "Nome Inválido"; else return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail Inválido"; else return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha Inválida"; else return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _cnpjController,
                    decoration: InputDecoration(hintText: "CNPJ da Empresa"),
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text.isEmpty) return "CNPJ Inválido"; else return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  // o sized box serviu aqui para deixar o botão mais alto
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                       shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(180.0)),
                      child: Text(
                        "Criar Conta",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                  onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              Map<String, dynamic> userDatal = {
                                "name": _nameController.text.toString().trim(),
                                "email": _emailController.text.toString().trim(),
                                "cnpjEmp": _cnpjController.text.toString().trim(),
                              };
                              if (!await user.signUp(
                                  userDatal, _passController.text))
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Ops! Algo saiu errado"),
                                ));
                            }
                          },

                    ),
                  )
                ],
              ),
            ),
         
        );
  }




} // fim da bagaça toda
