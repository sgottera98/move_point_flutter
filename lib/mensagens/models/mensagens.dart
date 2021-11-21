import 'package:cloud_firestore/cloud_firestore.dart';

class Mensagens{
  String evento = "";
  String descricao = "";
  String local = "";
  DateTime data = DateTime.now();
  DateTime data_criacao = DateTime.now();

  Mensagens();

  Map<String, dynamic> toJson() =>
      {
        'evento': evento,
        'descricao': descricao,
        'local': local,
        'data': data,
        'data_criacao': data_criacao
      };

  Mensagens.fromSnapshot(DocumentSnapshot snapshot):
      evento = snapshot['evento'],
      descricao = snapshot['descricao'],
      local = snapshot['local'],
      data = snapshot['data'].toDate(),
      data_criacao = snapshot['data_criacao'].toDate();
}