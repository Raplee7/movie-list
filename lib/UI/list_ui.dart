import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movielist/UI/movie_form_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListUI extends StatelessWidget {

  // final FirebaseFirestore _ff = FirebaseFirestore.instance;
  // late CollectionReference _colRef;

  // ProdukUI({Key? key}) : super(key: key) {
  //   _colRef = _ff.collection('product');
  // }

  final CollectionReference _colRef =
      FirebaseFirestore.instance.collection('movie');
  final CollectionReference _colRefFoto =
      FirebaseFirestore.instance.collection('foto_movie');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
        appBar: PreferredSize(
            preferredSize: Size(100, 180),
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('img/atas.jpg'), fit: BoxFit.fill )
                ),
                height: 300,
                margin: const EdgeInsets.only(bottom: 10),
                // color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40 ),
                  child: Center(
                    child: Text('LIST MOVIE', style: TextStyle(fontSize: 30, color: Colors.white)),
                  ),
                ),
              ),
            ),
        ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.gamepad), backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => MovieFormUI(null)));
          }),
      body:
      StreamBuilder<QuerySnapshot>(
          stream: _colRef.snapshots(),
          builder: (c, snap) => Card(
            shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      ),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
                  children: [
                    for (var d in snap.data?.docs ?? [])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Builder(builder: (c) {
                          var data = d.data();
                          return ListTile(
                            leading: FutureBuilder(
                                future: _colRefFoto.doc(data['nama']).get(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snap) {
                                  print('visi : ${snap.data?.exists}');
                                  return Container(
                                      width: 100,
                                      height: 200,
                                      child:(snap.data?.exists) == true
                                          ? SizedBox(
                                            child: Image.memory(
                                                base64Decode(snap.data?.get('foto')),),
                                          )
                                          : SizedBox());
                                }),
                            onLongPress: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (c) => CupertinoAlertDialog(
                                        title: const Text('Hapus Data'),
                                        content: Text(
                                            'Movie dengan nama ${data['nama']} akan dihapus?'),
                                        actions: [
                                          CupertinoDialogAction(
                                            child: Text('Iye'),
                                            onPressed: () {
                                              _colRef.doc(data['nama']).delete();
                                              Navigator.pop(c);
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: Text('Ndk'),
                                            onPressed: () {
                                              Navigator.pop(c);
                                            },
                                          )
                                        ],
                                      ));
                            },
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (c) {
                                return MovieFormUI(data);
                              }));
                            },
                            
                            title: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(                            
                                      children: [
                                        Icon(FontAwesomeIcons.ticket, size: 15),
                                        Text(' ${data['nama']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('${data['genre']}', style: TextStyle(fontSize: 8, color: Colors.blueGrey))),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.book, size: 15),
                                      Flexible(child: Text('${data['sinopsis']}', style: TextStyle(fontSize: 10))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      )
                  ],
                ),
          )),
    );
  }
}
