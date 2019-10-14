import 'package:moor_flutter/moor_flutter.dart';
import 'package:prodesys_mobi/src/db/dao/ClienteDAO.dart';

import 'dao/ProdutoDAO.dart';
part 'my_database.g.dart';

class Produtos extends Table {
  TextColumn get codigo => text()();
  TextColumn get descricao => text().withLength(min: 2, max: 40)();
  DateTimeColumn get datahora => dateTime()();
}

class Clientes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idHas => integer()();
  IntColumn get idProde => integer()();
  TextColumn get nome => text().withLength(min: 2, max: 40)();
  BoolColumn get subirCloud => boolean()(); 
  DateTimeColumn get dtaHorAtz => dateTime()();
}




// o Jacob fez algumas alteracoes aqui nesta classe para que ela fique em singleton
@UseMoor(tables: [Produtos, Clientes])
class MyDatabase extends _$MyDatabase {

  static final MyDatabase instance = MyDatabase._internal();
  ProdutoDAO produtoDAO;
  ClienteDAO clienteDAO;

  MyDatabase._internal() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite')){
   // instancia o clienteDAO vinculando ele ao MyDatabase, representado aqui pelo 'instante'
   clienteDAO = ClienteDAO(this);
   produtoDAO = ProdutoDAO(this);
  }






  @override
  int get schemaVersion => 3; 
}