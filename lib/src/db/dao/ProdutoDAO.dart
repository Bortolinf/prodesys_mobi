import 'package:moor_flutter/moor_flutter.dart';
import '../my_database.dart';

part 'ProdutoDAO.g.dart';

@UseDao(tables:[Produtos])
class ProdutoDAO extends DatabaseAccessor<MyDatabase> with _$ProdutoDAOMixin{
  ProdutoDAO(MyDatabase db) : super(db);
}