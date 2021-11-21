import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_fatec/mensagens/models/mensagens.dart';

Widget buildMessageCard(BuildContext context, DocumentSnapshot document) {
  {
    final eventos = Mensagens.fromSnapshot(document);
    return new Container(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                child: Wrap(
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    Text(
                      eventos.evento,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                )
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                  child: Wrap(
                    runAlignment: WrapAlignment.start,
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      Text(
                        eventos.descricao,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      )
                    ],
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                  child: Wrap(
                    runAlignment: WrapAlignment.start,
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      Text(
                        eventos.local + " - ",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        eventos.data_criacao.toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      )
                    ],
                  )
              ),
              Divider()
            ],
          ),
        ),
      )
    );
  }
}