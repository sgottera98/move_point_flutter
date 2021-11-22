import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_fatec/mensagens/messageCard.dart';
import 'mensagens/messagesFirestore.dart';
import 'nossowidget/widget_button_custom.dart';


class MenuFirestore extends StatefulWidget {

  @override
  _MenuFirestoreState createState() => _MenuFirestoreState();
}

class _MenuFirestoreState extends State<MenuFirestore> {
  List _resultsList = [];
  late QuerySnapshot result;

  final _myuser = TextEditingController();
  final _myFriend  = TextEditingController();

  Future <void> inicializarFirebase() async {
    await Firebase.initializeApp();
    Firebase.initializeApp().whenComplete(() => ("Conectado firebase"));
  }

  @override
  Widget build(BuildContext context) {
    inicializarFirebase();
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed de Eventos"),
        actions: [
          IconButton(
              onPressed: () {
                _bdFirestore(context, MensagensFirestore(_myuser.text.toString(), _myFriend.text.toString()));
              },
                icon: Icon(
                Icons.add
                ),
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(
              Icons.search
              ),
          )
        ],
      ),
      body: _menu(context),
    );
  }

  _menu(ctx) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContainerOldMessages(),
          // BotoesCustom("Visualizar eventos", onPressed: _buscaRegistro ),
        ],
      ),
    );
  }
//MessageList
  void _bdFirestore(BuildContext ctx, MensagensFirestore page) {
    Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  ContainerOldMessages() {
    _buscaRegistro();
    return Container(
      color: Colors.transparent,
      height: 600,
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 3, right: 3, bottom: 0, top: 0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _resultsList.length==null ? 0 : _resultsList.length,
        itemBuilder: (BuildContext ctx, int index) =>
            buildMessageCard(ctx, _resultsList[index]),
      ),
    );

  }

  Future <void> _buscaRegistro() async{
    var banco = FirebaseFirestore.instance.collection("eventos");
    var filtronaColecao = banco;
    var consulta;

    consulta = await filtronaColecao
        .orderBy('data_criacao', descending: true)
        .limit(100);
    result = await consulta.get();
    setState(() {
      _resultsList = result.docs;
    });
  }
  
}
