import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_fatec/mensagens/models/mensagens.dart';
import 'package:projeto_fatec/nossowidget/widget_input.dart';
import 'package:projeto_fatec/nossowidget/widget_button_custom.dart';

class MensagensFirestore extends StatefulWidget {
String user;
String friend;
MensagensFirestore(this.user, this.friend);

  @override
  _MensagensFirestoreState createState() => _MensagensFirestoreState();
}

class _MensagensFirestoreState extends State<MensagensFirestore> {
  final _evento= TextEditingController();
  final _descricao = TextEditingController();
  final _local = TextEditingController();
   late QuerySnapshot result;

   Future <void> inicializarFirebase() async {
     await Firebase.initializeApp();
     Firebase.initializeApp().whenComplete(() => ("Conectado firebase"));
   }

  @override
  Widget build(BuildContext context) {
     inicializarFirebase();

    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Evento"),

      ),
      body: _body(),
    );
  }
  _body(){
    return ListView(
      padding: EdgeInsets.all(9),
      children: [
        ContainerInsere(_evento, "","Nome do evento:"),
        ContainerInsere(_descricao, "","Descrição:"),
        ContainerInsere(_local, "","Local:"),
        BotoesCustom("Criar", onPressed:() {
          _clicksend(context);
        }),
      ],
    );
  }

  ContainerInsere(TextEditingController txt, String label, String rotulo)
  {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 3, right: 3, bottom: 0, top: 0),
      child: InputTextos(rotulo, label,controller: txt,),
      alignment: AlignmentDirectional.topStart,
    );
  }

  void _clicksend(BuildContext ctx) {
     Mensagens ms = new Mensagens();
     ms.evento=_evento.text.toString().trim();
     ms.descricao=_descricao.text.toString().trim();
     ms.local=_local.text.toString().trim();
     ms.data=DateTime.now();
     ms.data_criacao=DateTime.now();

     CollectionReference instanciaColecaoFirestore = FirebaseFirestore.instance.collection("eventos");
     Future<void> addMsg(){
       return instanciaColecaoFirestore
           .doc(ms.data_criacao.toString().trim())
           .set(ms.toJson())
           .then((value) => print("Evento adicionado"))
           .catchError((onError) => print("Erro ao gravar no banco $onError"));
     }
     addMsg();
     _evento.text = "";
     _descricao.text = "";
     _local.text = "";
  }
}