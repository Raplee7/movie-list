import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FotoProvider with ChangeNotifier {
  File? foto;

  void ubahFoto(File f) {
    foto = f;
    notifyListeners();
  }

  void simpan(String nama) async {
    if (foto == null) return;

    final _col = FirebaseFirestore.instance.collection('foto_movie');
    _col
        .doc(nama)
        .set({'nama': nama, 'foto': base64Encode(foto!.readAsBytesSync())});
  }
}
