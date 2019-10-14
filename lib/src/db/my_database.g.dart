// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Produto extends DataClass implements Insertable<Produto> {
  final String codigo;
  final String descricao;
  final DateTime datahora;
  Produto(
      {@required this.codigo,
      @required this.descricao,
      @required this.datahora});
  factory Produto.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Produto(
      codigo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      descricao: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}descricao']),
      datahora: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}datahora']),
    );
  }
  factory Produto.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Produto(
      codigo: serializer.fromJson<String>(json['codigo']),
      descricao: serializer.fromJson<String>(json['descricao']),
      datahora: serializer.fromJson<DateTime>(json['datahora']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'codigo': serializer.toJson<String>(codigo),
      'descricao': serializer.toJson<String>(descricao),
      'datahora': serializer.toJson<DateTime>(datahora),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Produto>>(bool nullToAbsent) {
    return ProdutosCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      datahora: datahora == null && nullToAbsent
          ? const Value.absent()
          : Value(datahora),
    ) as T;
  }

  Produto copyWith({String codigo, String descricao, DateTime datahora}) =>
      Produto(
        codigo: codigo ?? this.codigo,
        descricao: descricao ?? this.descricao,
        datahora: datahora ?? this.datahora,
      );
  @override
  String toString() {
    return (StringBuffer('Produto(')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao, ')
          ..write('datahora: $datahora')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(codigo.hashCode, $mrjc(descricao.hashCode, datahora.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Produto &&
          other.codigo == this.codigo &&
          other.descricao == this.descricao &&
          other.datahora == this.datahora);
}

class ProdutosCompanion extends UpdateCompanion<Produto> {
  final Value<String> codigo;
  final Value<String> descricao;
  final Value<DateTime> datahora;
  const ProdutosCompanion({
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.datahora = const Value.absent(),
  });
  ProdutosCompanion.insert({
    @required String codigo,
    @required String descricao,
    @required DateTime datahora,
  })  : codigo = Value(codigo),
        descricao = Value(descricao),
        datahora = Value(datahora);
  ProdutosCompanion copyWith(
      {Value<String> codigo,
      Value<String> descricao,
      Value<DateTime> datahora}) {
    return ProdutosCompanion(
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      datahora: datahora ?? this.datahora,
    );
  }
}

class $ProdutosTable extends Produtos with TableInfo<$ProdutosTable, Produto> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProdutosTable(this._db, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  GeneratedTextColumn _codigo;
  @override
  GeneratedTextColumn get codigo => _codigo ??= _constructCodigo();
  GeneratedTextColumn _constructCodigo() {
    return GeneratedTextColumn(
      'codigo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descricaoMeta = const VerificationMeta('descricao');
  GeneratedTextColumn _descricao;
  @override
  GeneratedTextColumn get descricao => _descricao ??= _constructDescricao();
  GeneratedTextColumn _constructDescricao() {
    return GeneratedTextColumn('descricao', $tableName, false,
        minTextLength: 2, maxTextLength: 40);
  }

  final VerificationMeta _datahoraMeta = const VerificationMeta('datahora');
  GeneratedDateTimeColumn _datahora;
  @override
  GeneratedDateTimeColumn get datahora => _datahora ??= _constructDatahora();
  GeneratedDateTimeColumn _constructDatahora() {
    return GeneratedDateTimeColumn(
      'datahora',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [codigo, descricao, datahora];
  @override
  $ProdutosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'produtos';
  @override
  final String actualTableName = 'produtos';
  @override
  VerificationContext validateIntegrity(ProdutosCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.codigo.present) {
      context.handle(
          _codigoMeta, codigo.isAcceptableValue(d.codigo.value, _codigoMeta));
    } else if (codigo.isRequired && isInserting) {
      context.missing(_codigoMeta);
    }
    if (d.descricao.present) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableValue(d.descricao.value, _descricaoMeta));
    } else if (descricao.isRequired && isInserting) {
      context.missing(_descricaoMeta);
    }
    if (d.datahora.present) {
      context.handle(_datahoraMeta,
          datahora.isAcceptableValue(d.datahora.value, _datahoraMeta));
    } else if (datahora.isRequired && isInserting) {
      context.missing(_datahoraMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Produto map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Produto.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProdutosCompanion d) {
    final map = <String, Variable>{};
    if (d.codigo.present) {
      map['codigo'] = Variable<String, StringType>(d.codigo.value);
    }
    if (d.descricao.present) {
      map['descricao'] = Variable<String, StringType>(d.descricao.value);
    }
    if (d.datahora.present) {
      map['datahora'] = Variable<DateTime, DateTimeType>(d.datahora.value);
    }
    return map;
  }

  @override
  $ProdutosTable createAlias(String alias) {
    return $ProdutosTable(_db, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final int id;
  final int idHas;
  final int idProde;
  final String nome;
  final bool subirCloud;
  final DateTime dtaHorAtz;
  Cliente(
      {@required this.id,
      @required this.idHas,
      @required this.idProde,
      @required this.nome,
      @required this.subirCloud,
      @required this.dtaHorAtz});
  factory Cliente.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Cliente(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      idHas: intType.mapFromDatabaseResponse(data['${effectivePrefix}id_has']),
      idProde:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_prode']),
      nome: stringType.mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      subirCloud: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}subir_cloud']),
      dtaHorAtz: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}dta_hor_atz']),
    );
  }
  factory Cliente.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Cliente(
      id: serializer.fromJson<int>(json['id']),
      idHas: serializer.fromJson<int>(json['idHas']),
      idProde: serializer.fromJson<int>(json['idProde']),
      nome: serializer.fromJson<String>(json['nome']),
      subirCloud: serializer.fromJson<bool>(json['subirCloud']),
      dtaHorAtz: serializer.fromJson<DateTime>(json['dtaHorAtz']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'idHas': serializer.toJson<int>(idHas),
      'idProde': serializer.toJson<int>(idProde),
      'nome': serializer.toJson<String>(nome),
      'subirCloud': serializer.toJson<bool>(subirCloud),
      'dtaHorAtz': serializer.toJson<DateTime>(dtaHorAtz),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Cliente>>(bool nullToAbsent) {
    return ClientesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idHas:
          idHas == null && nullToAbsent ? const Value.absent() : Value(idHas),
      idProde: idProde == null && nullToAbsent
          ? const Value.absent()
          : Value(idProde),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      subirCloud: subirCloud == null && nullToAbsent
          ? const Value.absent()
          : Value(subirCloud),
      dtaHorAtz: dtaHorAtz == null && nullToAbsent
          ? const Value.absent()
          : Value(dtaHorAtz),
    ) as T;
  }

  Cliente copyWith(
          {int id,
          int idHas,
          int idProde,
          String nome,
          bool subirCloud,
          DateTime dtaHorAtz}) =>
      Cliente(
        id: id ?? this.id,
        idHas: idHas ?? this.idHas,
        idProde: idProde ?? this.idProde,
        nome: nome ?? this.nome,
        subirCloud: subirCloud ?? this.subirCloud,
        dtaHorAtz: dtaHorAtz ?? this.dtaHorAtz,
      );
  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('id: $id, ')
          ..write('idHas: $idHas, ')
          ..write('idProde: $idProde, ')
          ..write('nome: $nome, ')
          ..write('subirCloud: $subirCloud, ')
          ..write('dtaHorAtz: $dtaHorAtz')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          idHas.hashCode,
          $mrjc(
              idProde.hashCode,
              $mrjc(nome.hashCode,
                  $mrjc(subirCloud.hashCode, dtaHorAtz.hashCode))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.id == this.id &&
          other.idHas == this.idHas &&
          other.idProde == this.idProde &&
          other.nome == this.nome &&
          other.subirCloud == this.subirCloud &&
          other.dtaHorAtz == this.dtaHorAtz);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<int> id;
  final Value<int> idHas;
  final Value<int> idProde;
  final Value<String> nome;
  final Value<bool> subirCloud;
  final Value<DateTime> dtaHorAtz;
  const ClientesCompanion({
    this.id = const Value.absent(),
    this.idHas = const Value.absent(),
    this.idProde = const Value.absent(),
    this.nome = const Value.absent(),
    this.subirCloud = const Value.absent(),
    this.dtaHorAtz = const Value.absent(),
  });
  ClientesCompanion.insert({
    this.id = const Value.absent(),
    @required int idHas,
    @required int idProde,
    @required String nome,
    @required bool subirCloud,
    @required DateTime dtaHorAtz,
  })  : idHas = Value(idHas),
        idProde = Value(idProde),
        nome = Value(nome),
        subirCloud = Value(subirCloud),
        dtaHorAtz = Value(dtaHorAtz);
  ClientesCompanion copyWith(
      {Value<int> id,
      Value<int> idHas,
      Value<int> idProde,
      Value<String> nome,
      Value<bool> subirCloud,
      Value<DateTime> dtaHorAtz}) {
    return ClientesCompanion(
      id: id ?? this.id,
      idHas: idHas ?? this.idHas,
      idProde: idProde ?? this.idProde,
      nome: nome ?? this.nome,
      subirCloud: subirCloud ?? this.subirCloud,
      dtaHorAtz: dtaHorAtz ?? this.dtaHorAtz,
    );
  }
}

class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  final GeneratedDatabase _db;
  final String _alias;
  $ClientesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _idHasMeta = const VerificationMeta('idHas');
  GeneratedIntColumn _idHas;
  @override
  GeneratedIntColumn get idHas => _idHas ??= _constructIdHas();
  GeneratedIntColumn _constructIdHas() {
    return GeneratedIntColumn(
      'id_has',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idProdeMeta = const VerificationMeta('idProde');
  GeneratedIntColumn _idProde;
  @override
  GeneratedIntColumn get idProde => _idProde ??= _constructIdProde();
  GeneratedIntColumn _constructIdProde() {
    return GeneratedIntColumn(
      'id_prode',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  GeneratedTextColumn _nome;
  @override
  GeneratedTextColumn get nome => _nome ??= _constructNome();
  GeneratedTextColumn _constructNome() {
    return GeneratedTextColumn('nome', $tableName, false,
        minTextLength: 2, maxTextLength: 40);
  }

  final VerificationMeta _subirCloudMeta = const VerificationMeta('subirCloud');
  GeneratedBoolColumn _subirCloud;
  @override
  GeneratedBoolColumn get subirCloud => _subirCloud ??= _constructSubirCloud();
  GeneratedBoolColumn _constructSubirCloud() {
    return GeneratedBoolColumn(
      'subir_cloud',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dtaHorAtzMeta = const VerificationMeta('dtaHorAtz');
  GeneratedDateTimeColumn _dtaHorAtz;
  @override
  GeneratedDateTimeColumn get dtaHorAtz => _dtaHorAtz ??= _constructDtaHorAtz();
  GeneratedDateTimeColumn _constructDtaHorAtz() {
    return GeneratedDateTimeColumn(
      'dta_hor_atz',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, idHas, idProde, nome, subirCloud, dtaHorAtz];
  @override
  $ClientesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'clientes';
  @override
  final String actualTableName = 'clientes';
  @override
  VerificationContext validateIntegrity(ClientesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.idHas.present) {
      context.handle(
          _idHasMeta, idHas.isAcceptableValue(d.idHas.value, _idHasMeta));
    } else if (idHas.isRequired && isInserting) {
      context.missing(_idHasMeta);
    }
    if (d.idProde.present) {
      context.handle(_idProdeMeta,
          idProde.isAcceptableValue(d.idProde.value, _idProdeMeta));
    } else if (idProde.isRequired && isInserting) {
      context.missing(_idProdeMeta);
    }
    if (d.nome.present) {
      context.handle(
          _nomeMeta, nome.isAcceptableValue(d.nome.value, _nomeMeta));
    } else if (nome.isRequired && isInserting) {
      context.missing(_nomeMeta);
    }
    if (d.subirCloud.present) {
      context.handle(_subirCloudMeta,
          subirCloud.isAcceptableValue(d.subirCloud.value, _subirCloudMeta));
    } else if (subirCloud.isRequired && isInserting) {
      context.missing(_subirCloudMeta);
    }
    if (d.dtaHorAtz.present) {
      context.handle(_dtaHorAtzMeta,
          dtaHorAtz.isAcceptableValue(d.dtaHorAtz.value, _dtaHorAtzMeta));
    } else if (dtaHorAtz.isRequired && isInserting) {
      context.missing(_dtaHorAtzMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cliente map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Cliente.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ClientesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.idHas.present) {
      map['id_has'] = Variable<int, IntType>(d.idHas.value);
    }
    if (d.idProde.present) {
      map['id_prode'] = Variable<int, IntType>(d.idProde.value);
    }
    if (d.nome.present) {
      map['nome'] = Variable<String, StringType>(d.nome.value);
    }
    if (d.subirCloud.present) {
      map['subir_cloud'] = Variable<bool, BoolType>(d.subirCloud.value);
    }
    if (d.dtaHorAtz.present) {
      map['dta_hor_atz'] = Variable<DateTime, DateTimeType>(d.dtaHorAtz.value);
    }
    return map;
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $ProdutosTable _produtos;
  $ProdutosTable get produtos => _produtos ??= $ProdutosTable(this);
  $ClientesTable _clientes;
  $ClientesTable get clientes => _clientes ??= $ClientesTable(this);
  @override
  List<TableInfo> get allTables => [produtos, clientes];
}
