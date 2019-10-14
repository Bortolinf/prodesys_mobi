import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:prodesys_mobi/src/blocs/ConnectionStatusBloc.dart';
import 'package:prodesys_mobi/src/db/my_database.dart';
import 'package:prodesys_mobi/src/domain/singleton.dart';
import 'package:prodesys_mobi/src/utils/alerts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';


ProgressDialog pr;
HasuraConnect hasuraConnect;

class SincroPage extends StatefulWidget {
  @override
  _SincroPageState createState() => _SincroPageState();
}

class _SincroPageState extends State<SincroPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final ConnectionStatusBloc _networkBloc =
      BlocProvider.getBloc<ConnectionStatusBloc>();

  @override
  void initState() {
    super.initState();
    print("initstate");
    _lerLastSincro();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(message: 'Aguarde...');
    String url = 'https://prodesys-mob.herokuapp.com/v1/graphql';
    hasuraConnect = HasuraConnect(url);

    return Scaffold(
      appBar: AppBar(
        title: Text("Sincronizar Dados"),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Testando Conexão com Internet"),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
                stream: _networkBloc.outtemNet,
                initialData: null,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    print("retorno null");
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data == false) {
                    print("retorno = false");
                    return _botaoSemInternet(context);
                  } else {
                    print("retorno true");
                    return _botaoComInternet(context);
                    //return _seqAtualizacoes(context);
                  }
                }),
          ],
        ),
      ),
    );
  }

  _botaoSemInternet(context) {
    print("botao Sem Internet");
    return RaisedButton(
        color: Colors.redAccent[200],
        child: Text(
          "Você está sem Conexão, clique para retornar",
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  _botaoComInternet(context) {
    return SizedBox(
      height: 80,
      child: RaisedButton(
          color: Colors.blue,
          child: Text(
            "Internet OK, clique para Iniciar",
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            _seqAtualizacoes(context);
          }),
    );
  }

  //
  //  chamador da sequencia de atualiacoes
  //
  _seqAtualizacoes(context) async {
    pr.update(message: "Sincronizando ...");
    pr.show();
    await Future.delayed(Duration(seconds: 1)).then((onValue) {});
    bool atzOk = false;
    atzOk = await _sincroProdutos(context);
    if (atzOk) {
      atzOk = await _sincroClientes(context);
    }
    pr.hide();
    // testa o status final da atualizacao
    if (atzOk) {
      _salvarLastSincro();
      alert(context, "Sincronização Concluída",
          "Dados Sicnronizados com o servidor", _retornar(context));
    } else {
      alert(
          context,
          "Sincronização Cancelada",
          "Ocorreram problemas durante a Sincronização, tente novamente",
          _retornar(context));
    }
  }

  _retornar(context) {
    Navigator.of(context).pop();
  }


  Future<bool> _sincroProdutos(context) async {
    print("sincro Produtos");
    pr.update(message: 'Produtos ...');
    await Future.delayed(Duration(seconds: 1)).then((onValue) {
      print("PR status -produtos");
    });
    return true;
  }

  Future<bool> _sincroClientes(context) async {
    pr.update(message: 'Clientes ...');
    await Future.delayed(Duration(milliseconds: 300)).then((onValue) { });
    
    print("subir Clientes");
    await Future.delayed(Duration(seconds: 1)).then((onValue) { });
    pr.update(message: 'Enviando Clientes ...');

    await _subirClientes();

    print("receber Clientes");
    await Future.delayed(Duration(seconds: 1)).then((onValue) { });
    pr.update(message: 'Recebendo Clientes ...');

    await _receberClientes();

    return true;
  }

  //
  //  sobe os clientes que estao com o flag subirCloud = true  
  //
  _subirClientes() async {
    MyDatabase.instance.clienteDAO.listSubirCloud().then((result) {
      for (Cliente cli in result) {
        print(cli.nome);
        if (cli.idHas != null && cli.idHas > 0) {
          _alterarCliHasura(cli);
        } else {
          _incluirCliHasura(cli);
        }
        // Altera o flag subirCloud para false
        MyDatabase.instance.clienteDAO.updateClienteSubiu(cli);

      }
      
    });
  }



_incluirCliHasura(Cliente cli) {
        // Manda o cliente para o Hasura
        var query = """
            sendCliente(\$nome:String!, \$idMobi:Int!, \$idProde:Int!, \$dtaHorAtz:timestamptz!) {
            insert_cliente(objects: {idMobi: \$idMobi, idProde: \$idProde, nome: \$nome, dtaHorAtz: \$dtaHorAtz}) {
              affected_rows
            }
          }
         """;
        hasuraConnect.mutation(query, variables: {
          "idMobi": cli.id,
          "idProde" : 0,
          "nome": cli.nome,
          "dtaHorAtz" : DateTime.now().toIso8601String(),
        });
}


_alterarCliHasura(Cliente cli) {
        // Manda o cliente para o Hasura
        var query = """
            updCliente(\$idHas:Int!, \$nome:String!, \$idMobi:Int!, \$idProde:Int!, \$dtaHorAtz:timestamptz!) {
            update_cliente(where: {idHas: {_eq: \$idHas}}, _set: {idMobi: \$idMobi, nome: \$nome, dtaHorAtz: \$dtaHorAtz}) {
              affected_rows
            }
          }
         """;
        hasuraConnect.mutation(query, variables: {
          "idHas" : cli.idHas,
          "idMobi": cli.id,
          "idProde" : 0,
          "nome": cli.nome,
          "dtaHorAtz" : DateTime.now().toIso8601String(),
        });
        

}




//
// aqui vamos receber os cadastros de clientes vindos do hasura
// 
_receberClientes() async {
    // excluir todos os clientes antes da importacao
    await MyDatabase.instance.clienteDAO.removeAllClientes();
    print("fim removeAllClietnes");

  // stream pelo Hasura
    var query = """
        query {
          cliente {
            dtaHorAtz
            idHas
            idProde
            nome
            }
        }
          """;
      
      await hasuraConnect.query(query).then((jsonList){
        for (dynamic item in jsonList["data"]["cliente"]) {
          print("-----via lis-----");
          print(item);
         // Cliente cli = Cliente.fromJson(item);
              // nao vamos mais precisar desta comparacao pq iremos salvar tudo o que vier
              // if(cli.dtaHorAtz.isAfter(appData.wtlLastSincroDataHor)) {  }
            print("temos que salvar!");
             MyDatabase.instance.clienteDAO.addCliente(Cliente(
               id: item['idHas'],
               idHas: item['idHas'],
               idProde: item['idProde'],
               nome: item['nome'],
               subirCloud: false,
               dtaHorAtz: DateTime.parse(item['dtaHorAtz']),
             )
             );
               
        }
      });
   
  }




_lerLastSincro() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if ((prefs.getString('lastSincroDta') ?? null) != null) {
     appData.wtlLastSincroDataHor = DateTime.parse(prefs.getString('lastSincroDta'));
  }
        print("entrou no readconfiguration");
        print(appData.wtlLastSincroDataHor);
}

    
 _salvarLastSincro() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('lastSincroDta', DateTime.now().toString());
  appData.wtlLastSincroDataHor = DateTime.now();
 }
  
  






} // fim de tudo
