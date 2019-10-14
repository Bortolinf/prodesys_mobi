import 'package:moor_flutter/moor_flutter.dart';
import '../my_database.dart';

part 'ClienteDAO.g.dart';

@UseDao(tables:[Clientes])
class ClienteDAO extends DatabaseAccessor<MyDatabase> with _$ClienteDAOMixin{

 Stream<List<Cliente>> listAll(){
   return (select(clientes)).watch();
 }



 Future<List<Cliente>> listSubirCloud(){
   //return (select(clientes).where((cli) => cli.subirCloud.equals(true))).get();
  var query = select(clientes);
  query.where((cliente) => cliente.subirCloud.equals(true));
  return query.get();
 }

 Stream<List<Cliente>> listSubirCloudStream(){
   //return (select(clientes).where((cli) => cli.subirCloud.equals(true))).get();
  var query = select(clientes);
  query.where((cliente) => cliente.subirCloud.equals(true));
  return query.watch();
 }


 Future addCliente(Cliente entity) {
   return into(clientes).insert(entity);
 }


 Future removeCliente(id) {
  // return (delete(clientes)..where((cli) => cli.id.equals(id)) ).go();
    var query = delete(clientes);
    query.where((cliente) => cliente.id.equals(id));
    return query.go();
  }

 Future removeAllClientes() {
    print("inicio removeAllClientes");
    var query = delete(clientes);
    return query.go();
  }

 Future updateCliente(Cliente entity) {
   return update(clientes).replace(entity);
 }


// atualiza o cliente marcando o campo subirCloud como false
 Future updateClienteSubiu(Cliente entity) {
   return update(clientes).replace(Cliente(
     id: entity.id,
     idHas: entity.idHas,
     idProde: entity.idProde,
     nome: entity.nome, 
     subirCloud: false,
     dtaHorAtz: entity.dtaHorAtz
     )
     );
 }


  ClienteDAO(MyDatabase db) : super(db);
}
