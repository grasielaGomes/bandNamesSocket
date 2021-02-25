import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Paralamas do Sucesso', votes: 5),
    Band(id: '2', name: 'Legião Urbana', votes: 10),
    Band(id: '3', name: 'Engenheiros do Havaí', votes: 6),
    Band(id: '4', name: 'Kid Abelha', votes: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bands.length, itemBuilder: (_, i) => bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        child: Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  Widget bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //TODO: chamar o que apagou no servidor
      },
      background: Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        color: Colors.red.shade800,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blueAccent,
        ),
        title: Text(band.name, style: TextStyle(color: Colors.blueAccent)),
        trailing: Text(
          band.votes.toString(),
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final TextEditingController _bandController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('New band name:'),
              content: TextField(
                controller: _bandController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () => addBandName(_bandController.text),
                  child: Text('Add'),
                  color: Colors.blueAccent,
                  elevation: 5,
                  textColor: Colors.white,
                )
              ],
            );
          });
    }
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('New band name:'),
            content: CupertinoTextField(
              controller: _bandController,
            ),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dismiss'),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addBandName(_bandController.text),
              ),
            ],
          );
        });
  }

  void addBandName(String name) {
    print(name);
    if (name.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 5));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
