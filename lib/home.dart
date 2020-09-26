import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prakrati_datacollection/contactusours.dart';
import 'package:prakrati_datacollection/individual_shop/indi_home.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:flutter/material.dart';
import 'package:prakrati_datacollection/service_shop.dart';
 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
List caraousal=[];


  getcaraousal(){
    print(';test');
  var data=  Firestore.instance.collection('/main/GviDBFwfTjPNPSoAy7FZ/caraousal').getDocuments();
  

    data.then((value){
 print('in then');
      print(value.documents.length);

      for(int i=0; i< value.documents.length; i++){
        var docid= value.documents[i].documentID;
        print(value.documents[i].documentID);

       var data1= Firestore.instance.collection('/main/GviDBFwfTjPNPSoAy7FZ/caraousal').document('$docid').snapshots();
         data1.listen((event) { 
           print('object');

           print(event.data['img']);
     setState(() {
        caraousal.add(event.data['img']); //caraousal.
     });
    });

   print(caraousal);

      }
    });
     
   
  }
  requestpermission() async {
    if (await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('permission granted');
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcaraousal();
    print(caraousal);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Jeevika Customer!',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontFamily: 'montserrat',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.scanner),
        //     onPressed: () async {
        //       // String photoScanResult = await scanner.scanPhoto();
        //       if (await Permission.camera.request().isGranted) {
        //         // Either the permission was already granted before or the user just granted it.
        //         print('permission granted');
        //         String cameraScanResult = await scanner.scan();

        //         print(cameraScanResult);

        //         print(cameraScanResult.split('%')[0]);

        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (BuildContext context) => Indihome(
        //                     shoplistDoc: cameraScanResult.split('%')[0],
        //                     shopCat: cameraScanResult.split('%')[1])));
        //       }
        //     },
        //   )
        // ],
     
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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          CarouselSlider(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            height: MediaQuery.of(context).size.width/2,
            
            items:  caraousal.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //decoration: BoxDecoration(color: Colors.amber),
                    child: Image.network('$i'),
                  );
                }, 
              );
            }).toList(),
          ),
          Container(
            child: Expanded(
                child: Column(
              children: <Widget>[
                  SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        //  padding: EdgeInsets.fromLTRB(6, 8, 0, 5),
                        child: Container(
                      padding: EdgeInsets.fromLTRB(6, 8, 6, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(11, 76, 181, 1),
                            Colors.blue
                          ])),
                      child: Column(
                        children: [
                          Text(
                        'Scan the QR to open shop',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Colors.white,
                             
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        )
                      ),

                      // InkWell(
                      //   child: Image.network('https://pixabay.com/vectors/scanner-handheld-barcode-scanning-36385.png'),
                      // )

                      //  Image.network('https://cdn.pixabay.com/photo/2013/07/12/14/45/qr-code-148732__340.png')

                        Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20)
                             ),
                          child: RaisedButton( 
                            color: Colors.white, child: Text('Open Scanner', style: GoogleFonts.raleway(
                              color: Colors.black87,fontWeight: FontWeight.w600, fontSize: 13
                            ),),
                            onPressed: () async {
                              if (await Permission.camera.request().isGranted) {
                // Either the permission was already granted before or the user just granted it.
                print('permission granted');
                String cameraScanResult = await scanner.scan();

                print(cameraScanResult);

                print(cameraScanResult.split('%')[0]);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Indihome(
                            shoplistDoc: cameraScanResult.split('%')[0],
                            shopCat: cameraScanResult.split('%')[1])));
              }


                            }),)

                        ],
                      )
                    )),
                  ],
                ),

                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(203, 214, 207, 1),
                        ),
                        height: 39,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Color.fromRGBO(112, 105, 105, 1),
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                  color: Color.fromRGBO(112, 105, 105, 1)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection(
                                        '/main/GviDBFwfTjPNPSoAy7FZ/service_cat')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return new Text('Loading...');
                                    default:
                                      return new GridView(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3),
                                        children: snapshot.data.documents
                                            .map((DocumentSnapshot document) {
                                          return InkWell(
                                            splashColor: Colors.orangeAccent,
                                            // highlightColor: Colors.black38,

                                            onTap: () {
                                              // contcolor(1);
                                              print(document.documentID);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ServiceShop(
                                                              categoryDoc: document
                                                                  .documentID)));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              child: Container(
                                                height: 36,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Color.fromRGBO(
                                                            184, 178, 178, 1)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 5.0,
                                                      ),
                                                    ]),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Image.network(
                                                        document['ser_image'],
                                                        height: 60,
                                                        width: 60,
                                                      ),
                                                    ),
                                                    Text(
                                                      document['ser_name'],
                                                      style: GoogleFonts.raleway(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );

                                          // return GridView.builder(  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3) , itemBuilder: (context, index) {

                                          // },);

                                          // return new ListTile(
                                          //   title: Text(document['title']),
                                          //   subtitle: Text(document['author']),
                                          //   // trailing: new Image.network(document['qr'],
                                          //   // ),
                                          //   trailing: Image.network(document['img']),
                                          // );
                                        }).toList(),
                                      );
                                  }
                                },
                              ),
                            ),

                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceAround,
                            //   children: <Widget>[
                            //     Expanded(
                            //         flex: 1,
                            //         child: InkWell(onTap: () {
                            //          // contcolor(1);
                            //        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ServiceShop()));
                            //         },

                            //         child: Container(
                            //           padding: EdgeInsets.all(3),
                            //           child: Container(
                            //             height: 36,
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               border: Border.all(
                            //                   color: Color.fromRGBO(
                            //                       184, 178, 178, 1)),
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //             child: Center(
                            //               child: Text(
                            //                 'Security',
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.bold, color: Colors.black ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),)
                            //         ),
                            //     Expanded(
                            //         flex: 1,
                            //         child: InkWell(onTap: () {
                            //           //contcolor(2);
                            //           print('Shree Ganesh');
                            //           Firestore.instance.collection('path').document().setData({
                            //             'test': 'Shree Ganesh'
                            //           });
                            //         },

                            //         child: Container(
                            //           padding: EdgeInsets.all(3),
                            //           child: Container(
                            //             height: 36,
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               border: Border.all(
                            //                   color: Color.fromRGBO(
                            //                       184, 178, 178, 1)),
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //             child: Center(
                            //               child: Text(
                            //                 'RO Water',
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.bold, color: Colors.black),
                            //               ),
                            //             ),
                            //           ),
                            //         ),)
                            //         ),
                            //   Expanded(
                            //         flex: 1,
                            //         child: InkWell(onTap: () {
                            //          // contcolor(3);
                            //         },

                            //         child: Container(
                            //           padding: EdgeInsets.all(3),
                            //           child: Container(
                            //             height: 36,
                            //             decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               border: Border.all(
                            //                   color: Color.fromRGBO(
                            //                       184, 178, 178, 1)),
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //             child: Center(
                            //               child: Text(
                            //                 'Electronics',
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.bold,color: Colors.black),
                            //               ),
                            //             ),
                            //           ),
                            //         ),)
                            //         ),
                            //     ],
                            // ),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceAround,
                            //   children: <Widget>[
                            //   Expanded(
                            //         flex: 1,
                            //         child: InkWell(onTap: () {

                            //         },

                            //         child: Container(
                            //           padding: EdgeInsets.all(3),
                            //           child: Container(
                            //             height: 36,
                            //             decoration: BoxDecoration(
                            //               border: Border.all(
                            //                   color: Color.fromRGBO(
                            //                       184, 178, 178, 1)),
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //             child: Center(
                            //               child: Text(
                            //                 'Groceries',
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.bold),
                            //               ),
                            //             ),
                            //           ),
                            //         ),)
                            //         ),
                            //     Expanded(
                            //         flex: 1,
                            //         child: InkWell(onTap: () {

                            //          },

                            //         child: Container(
                            //           padding: EdgeInsets.all(3),
                            //           child: Container(
                            //             height: 36,
                            //             decoration: BoxDecoration(
                            //               border: Border.all(
                            //                   color: Color.fromRGBO(
                            //                       184, 178, 178, 1)),
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //             child: Center(
                            //               child: Text(
                            //                 'Chocolates ',
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.bold),
                            //               ),
                            //             ),
                            //           ),
                            //         ),)
                            //         ),
                            //  Expanded(
                            //         flex: 1,
                            //         child: InkWell(onTap: () {

                            //         },

                            //         child: Container(
                            //           padding: EdgeInsets.all(3),
                            //           child: Container(
                            //             height: 36,
                            //             decoration: BoxDecoration(
                            //               border: Border.all(
                            //                   color: Color.fromRGBO(
                            //                       184, 178, 178, 1)),
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //             child: Center(
                            //                child: Text(
                            //                 'More ',
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.bold),
                            //               ),
                            //             ),
                            //           ),
                            //         ),)
                            //         ),
                            //      ],
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))

                //   Container(
                //     height: 320,
                //     decoration: BoxDecoration(
                //         // color: Colors.blueAccent[100]
                //         ),
                //     child: GridView.count(
                //       crossAxisCount: 2,
                //       childAspectRatio: 1.5,
                //       shrinkWrap: true,
                //       //physics: const NeverScrollableScrollPhysics(),

                //       children: <Widget>[
                //         InkWell(
                //           child: Container(
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               children: <Widget>[
                //                 Image.asset(
                //                   'assets/images/plumber.png',
                //                   height: 90,
                //                   width: 90,
                //                 ),
                //                 Text('Plumber')
                //               ],
                //             ),
                //           ),
                //           onTap: () {
                //             print("tapped o n container");
                // //                 Navigator.push(
                // //   context,
                // //   MaterialPageRoute(builder: (context) => Description()),
                // // );

                // Navigator.pushReplacementNamed(context, "/description");
                //           },
                //         ),

                //         // plumber wala column

                //         Center(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: <Widget>[
                //               Image.asset(
                //                 'assets/images/mechanic.png',
                //                 height: 90,
                //                 width: 90,
                //               ),
                //               Text('Mechanic')
                //             ],
                //           ),
                //         ),

                //         Center(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: <Widget>[
                //               Image.asset(
                //                 'assets/images/elec.png',
                //                 height: 80,
                //                 width: 80,
                //               ),
                //               SizedBox(
                //                 height: 8,
                //               ),
                //               Text('Electrition')
                //             ],
                //           ),
                //         ),

                //         Center(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: <Widget>[
                //               Image.asset(
                //                 'assets/images/carpenter.png',
                //                 height: 90,
                //                 width: 90,
                //               ),
                //               Text('Carpenter')
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
              ],
            )),
          ),


       InkWell(child:    Container(
          decoration: BoxDecoration(
             color: Colors.red[400],
            borderRadius: BorderRadius.circular(20)
          ),
          height: MediaQuery.of(context).size.height/20,
             child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
               Text('Business owned by: Divkin Supplier', style: GoogleFonts.raleway(textStyle:  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
               Text('Tap for more.', style: GoogleFonts.raleway(textStyle:  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),)),
             ],)
          )
        ,
        
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Contactusours()));

        },
        
        )],
      ),
    );
  }
}
