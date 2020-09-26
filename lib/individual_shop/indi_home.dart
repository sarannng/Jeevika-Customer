import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prakrati_datacollection/contactus.dart';
import 'package:prakrati_datacollection/indi_category_item.dart';

class Indihome extends StatefulWidget {
  final String shoplistDoc;
  final String shopCat;
  Indihome({Key key, this.shoplistDoc, this.shopCat}) : super(key: key);

  @override
  _IndihomeState createState() => _IndihomeState();
}

class _IndihomeState extends State<Indihome> {
  String appbarHeading;
  List caraousal = [];
  String shop_owner;
  getcontactdetails() {
    var data = Firestore.instance
        .collection(
            '/main/GviDBFwfTjPNPSoAy7FZ/service_cat/${widget.shoplistDoc}/shop_list')
        .document('${widget.shopCat}')
        .snapshots();

    data.listen((event) {
      setState(() {
        shop_owner = event.data['shop_owner'];
      });
    });
  }

  getcaraousal() {
    print(';test');
    var data = Firestore.instance
        .collection(
            '/main/GviDBFwfTjPNPSoAy7FZ/service_cat/${widget.shoplistDoc}/shop_list/${widget.shopCat}/caraousal_indi')
        .getDocuments();

    data.then((value) {
      print('in then');
      print(value.documents.length);

      for (int i = 0; i < value.documents.length; i++) {
        var docid = value.documents[i].documentID;
        print(value.documents[i].documentID);

        var data1 = Firestore.instance
            .collection(
                '/main/GviDBFwfTjPNPSoAy7FZ/service_cat/${widget.shoplistDoc}/shop_list/${widget.shopCat}/caraousal_indi')
            .document('$docid')
            .snapshots();
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

  getAppbarHeading() {
    var data = Firestore.instance
        .collection(
            '/main/GviDBFwfTjPNPSoAy7FZ/service_cat/${widget.shoplistDoc}/shop_list')
        .document('${widget.shopCat}')
        .snapshots();

    data.listen((event) {
      setState(() {
        appbarHeading = event.data['shop_name'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppbarHeading();
    getcaraousal();
    getcontactdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarHeading, style: GoogleFonts.raleway( textStyle: TextStyle(
            fontFamily: 'montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),),
         flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange[900],
                Colors.orange[800],
                Colors.orange[400],
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              height: 170.0,
              items: caraousal.map((i) {
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Our Services',
              style: GoogleFonts.raleway(textStyle: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),)
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
                                    '/main/GviDBFwfTjPNPSoAy7FZ/service_cat/${widget.shoplistDoc}/shop_list/${widget.shopCat}/shop_cat')
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
                                                      IndiCategory(
                                                          shoplistDoc:
                                                              '${widget.shoplistDoc}',
                                                          shopCat:
                                                              '${widget.shopCat}',
                                                          indiCatDoc: document
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
                                                  BorderRadius.circular(20),
                                                   boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 5.0,
                                                      ),
                                                    ]
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Image.network(document[
                                                      'shop_ser_image'], height: 60,
                                                        width: 60,),
                                                ),
                                                Text(
                                                  document['shop_ser_name'],
                                                  style: GoogleFonts.raleway(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15))
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
                  ),
                  InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(20)),
                        height: MediaQuery.of(context).size.height / 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Business owned by: $shop_owner',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                            Text('Tap for more.',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                )),
                          ],
                        )),
                    onTap: () {
                      //${widget.shoplistDoc}/shop_list/${widget.shopCat}/
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Contactus(
                                  shopCat: widget.shopCat,
                                  shoplistDoc: widget.shoplistDoc)));
                    },
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
