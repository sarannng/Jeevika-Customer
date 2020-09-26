import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatefulWidget {
  final String shopCat;
  final String shoplistDoc;
  Contactus({Key key, this.shopCat, this.shoplistDoc}) : super(key: key);

  @override
  _ContactusState createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  String shop_image;
  String shop_owner;
  String shop_phone;
  String shop_address;
  String shop_qr;
  String shop_description;

  getcontactdetails() {
    var data = Firestore.instance
        .collection(
            '/main/GviDBFwfTjPNPSoAy7FZ/service_cat/${widget.shoplistDoc}/shop_list')
        .document('${widget.shopCat}')
        .snapshots();

    data.listen((event) {
      setState(() {
        shop_image = event.data['shop_image'];
        shop_owner = event.data['shop_owner'];
        shop_phone = event.data['shop_phone'];
        shop_address = event.data['shop_mapaddress'];
        shop_qr = event.data['shop_qr'];
        shop_description = event.data['shop_description'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcontactdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact Details',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontFamily: 'montserrat',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange[900],
                Colors.orange[800],
                Colors.orange[400],

                // Color.fromRGBO(11, 76, 181, 1),
                //           Colors.blue
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Image.network(
            //  'https://cdn.pixabay.com/photo/2017/02/27/12/30/businessmen-2103120__340.png',
              shop_image,
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  //                 if(await Permission.phone.request().isGranted){

                  //   // Either the permission was already granted before or the user just granted it.
                  //   print('permission granted');

                  // }
                  launch("tel:$shop_phone");
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.blue,
                        size: 25,
                      ),
                      Container(
                        child: Text(
                          'Phone',
                          style:
                              GoogleFonts.raleway(fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  String query = Uri.encodeComponent(
                       shop_address);
                  String googleUrl =
                      "https://www.google.com/maps/search/?api=1&query=$query";

                  if (await canLaunch(googleUrl) != null) {
                    await launch(googleUrl);
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Icon(
                        Icons.directions,
                        color: Colors.blue,
                        size: 25,
                      ),
                      Container(
                        child: Text(
                          'Route',
                          style:
                              GoogleFonts.raleway(fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
//     String img= 'http://jeevika.online/img/logo3.png';

//                   final ByteData bytes = await rootBundle.load('http://jeevika.online/img/logo3.png');
// await Share.file('esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png', text: 'My optional text.');
                  var request = await HttpClient().getUrl(Uri.parse(
                      shop_qr));
                  var response = await request.close();
                  Uint8List bytes =
                      await consolidateHttpClientResponseBytes(response);
                  await Share.file('Jeevika', 'jeevika.png', bytes, 'image/png',
                      text:
                          'Scan this code with Jeevika app to open our shop!');
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.blue,
                        size: 25,
                      ),
                      Container(
                        child: Text(
                          'Share',
                          style:
                              GoogleFonts.raleway(fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Owner Name :',
                style: GoogleFonts.raleway(
                    color: Colors.orange[500],
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                shop_owner,
                style: GoogleFonts.raleway(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              )
            ],
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              shop_description,
              overflow: TextOverflow.clip,
              style: GoogleFonts.raleway(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ))
        ],
      ),
    );
  }
}
