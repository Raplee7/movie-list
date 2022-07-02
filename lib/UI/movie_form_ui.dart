import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movielist/providers/foto_provider.dart';
import 'package:provider/provider.dart';

class MovieFormUI extends StatelessWidget {
  final Map? data;
  final CollectionReference _colRef =
      FirebaseFirestore.instance.collection('movie');

  MovieFormUI(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {};

    return ChangeNotifierProvider(
        create: ((context) => FotoProvider()),
        builder: (context, w){
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.black,
            ),
            body:Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('img/atas.jpg'), fit: BoxFit.fill
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                      ),
                    margin: EdgeInsets.all(25),
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Text('Input Data Movie', textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
                          ),
                          SingleChildScrollView(
                                    child: Column(children: [
                                      TextFormField(
                                        controller:
                        TextEditingController(text: this.data?['nama'] ?? ''),
                                        decoration: const InputDecoration(label: Text('Nama Movie')),
                                        onChanged: (s) {
                                          data['nama'] = s;
                                        },
                                      ),
                                      TextFormField(
                                        controller:
                        TextEditingController(text: this.data?['genre'] ?? ''),
                                        decoration: const InputDecoration(label: Text('Genre')),
                                        onChanged: (s) {
                                          data['genre'] = s;
                                        },
                                      ),
                                      TextFormField(
                                        controller:
                        TextEditingController(text: this.data?['sinopsis'] ?? ''),
                                        decoration: const InputDecoration(label: Text('Sinopsis Singkat')),
                                        onChanged: (s) {
                                          data['sinopsis'] = s;
                                        },
                                        
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          ImagePicker()
                          .pickImage(
                              source: ImageSource.gallery,
                              maxWidth: 300,
                              maxHeight: 300,
                              imageQuality: 30)
                          .then((value) {
                        if (value != null) {
                          context.read<FotoProvider>().ubahFoto(File(value.path));
                        }
                                          });
                                        },
                                        child: Consumer<FotoProvider>(builder: (context, prov, w) {
                                          return prov.foto == null
                          ? const SizedBox(
                              width: 80,
                              height: 80,
                              child: Icon(Icons.image, size: 80),
                            )
                          : Image.file(prov.foto!);
                                        }),
                                      ),
                                      SizedBox(height: 20,),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.black
                                        ),
                                        onPressed: () {
                                        if (this.data != null) {
                                          _colRef.doc(this.data!['nama']).update(data).then((_) {
                        Navigator.pop(context);
                                          });
                                          context.read<FotoProvider>().simpan(this.data!['nama']);
                                        }else{
                                          _colRef.doc(data['nama']).set(data).then((_) {
                          Navigator.pop(context);
                                          });
                                          context.read<FotoProvider>().simpan(data['nama']);
                                        } 
                                      }, child: Text('Simpan'))
                                    ],
                                    ),
                                  )
                          ]
                          ),
                      ),),
                  ),
                )
              ],
            ),
          );
        }
      );
  }
}
