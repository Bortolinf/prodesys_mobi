import 'package:firebase_auth/firebase_auth.dart';

class AppData {
  static final AppData _appData = new AppData._internal();
  
  String uid = "";   // id do usuario
  String cnpjEmp = ""; // cnpj da empresa
  FirebaseUser wtlUser;
  String wtlUsrName = ""; 

  DateTime wtlLastSincroDataHor;

  String wtlopc  = "";
  int wtlCliId = 0;
  int wtlCliIdHas = 0;
  int wtlCliIdProde = 0;
  String wtlCliNom = "";
  String wtlCliEnd = "";
  String wtlCliTel = "";
  String wtlCliObs = "";
  int wtlCliPess = 0;
  double wtlSaldoAtu = 0.0;

  String wtlPrdId = "";
  String wtlPrdDsc = "";
  double wtlPrdVlr = 0.0;

  String wtlDespId = "";
  String wtlDespDsc = "";
  DateTime wtlDespDate;
  double wtlDespVlr = 0.0;
  double wtlTotDesp = 0.0;

  String wtlFiltroFin = "7";
  String wtlRecId = "";
  String wtlRecDsc = "";
  String wtlRecCli = "";
  String wtlRecCliNome = "";
  DateTime wtlRecDate;
  double wtlRecVlr = 0.0;
  double wtlTotRec = 0.0;

  Map<String,List<dynamic>> wtlDiasSel = {};    // Map();
  Map<String,List<dynamic>> wtlDiasRec = {};    // Map();
  String wtlMesAno = "";

  String wtlDataProgrX = "";
  DateTime wtlDataProgr;
  Map<String, List<Map<String, dynamic>>> wtlProgrDiaCli = {};
  //Map<String, List> wtlProgrDiaCliDados = {};

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}
final appData = AppData();