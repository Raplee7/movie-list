import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielist/UI/list_ui.dart';
import 'package:provider/provider.dart';

class DashboardUI extends StatelessWidget {
  const DashboardUI({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.black,
            ),
            body:Stack(
              children: [
                Container(
                  height:300,
                  color: Colors.black,
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                    ),
                  margin: EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('img/pattern.png'),fit: BoxFit.fitWidth)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Text('Hai! Nonton apa kita hari ini?', style: TextStyle(fontSize: 20)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row( 
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox.fromSize(
                              size: Size(150,100), // button width and height
                              child: Material(
                                color: Color.fromARGB(255, 145, 145, 145), // button color
                                child: InkWell( // splash color
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => ListUI()));
                                  }, // button pressed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.movie,
                                        color: Colors.white,
                                      ), // icon
                                      Text(
                                        "Lihat Daftar Movie",
                                        style: TextStyle(color: Colors.white),
                                      ), // text
                                    ],
                                  ),
                                ),
                              ),
                          ),
                                ],
                              ),
                            )
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 100,
                          )
                        ]
                        ),),
                  ),
                ),
              )
            ],
          ),
        );
      
  }
}