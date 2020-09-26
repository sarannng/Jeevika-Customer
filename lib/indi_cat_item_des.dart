import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prakrati_datacollection/contactus.dart';

class Indicatdes extends StatefulWidget {
  final String shoplistDoc;
  final String shopCat;
  final String indiCatDoc;
  final String indiCatDes;
  Indicatdes(
      {Key key,
      this.shoplistDoc,
      this.shopCat,
      this.indiCatDoc,
      this.indiCatDes})
      : super(key: key);

  @override
  _IndicatdesState createState() => _IndicatdesState();
}

class _IndicatdesState extends State<Indicatdes> {
  String item_img;
  String appbarHeading;

    getAppbarHeading(){
  var data= Firestore.instance.collection('/main/GviDBFwfTjPNPSoAy7FZ/service_cat/${widget.shoplistDoc}/shop_list/${widget.shopCat}/shop_cat/${widget.indiCatDoc}/shop_item_list').document('${widget.indiCatDes}').snapshots();

    data.listen((event) { 
     setState(() {
       appbarHeading= event.data['shop_item_name'];
    
     });
     });
}


  getItemDetails() {
    var data = Firestore.instance
        .collection(
            '/main/GviDBFwfTjPNPSoAy7FZ/service_cat/${widget.shoplistDoc}/shop_list/${widget.shopCat}/shop_cat/${widget.indiCatDoc}/shop_item_list')
        .document('${widget.indiCatDes}')
        .snapshots();
    data.listen((event) {
   setState(() {
        item_img = event.data['shop_item_image'];
   });
    });
  }

  @override
  void initState() {
    super.initState();
    getItemDetails();
    getAppbarHeading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appbarHeading, style: GoogleFonts.raleway( textStyle: TextStyle(
            fontFamily: 'montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),)),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 5),
                ),
                child: Image.network(item_img),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(22, 10, 0, 0),
                  decoration: BoxDecoration(),
                  child: Text(
                    'Description',
                    style: GoogleFonts.raleway(textStyle: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),)
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(),
              child: Divider(
                thickness: 2,
              ),
            ),


            Expanded(child:  Container(
        child: Column(
          children: <Widget>[
            Expanded(child:StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('/main/GviDBFwfTjPNPSoAy7FZ/service_cat/${widget.shoplistDoc}/shop_list/${widget.shopCat}/shop_cat/${widget.indiCatDoc}/shop_item_list/${widget.indiCatDes}/shop_item_des_points')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:  
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                            
                        return new ListTile(
                          dense: true,
                        onTap: () {
                          print(document.documentID);
                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Indihome( shoplistDoc: categoryDoc, shopCat: document.documentID )));
                        },
                        // leading: Container(
                        //   decoration: BoxDecoration(
                        //       border:
                        //           Border.all(color: Colors.black38, width: 1)),
                        //   child: Image.network(
                        //     //'https://cdn.adiglobal.in/userfiles/India/New-ADI-logo.png',
                        //     document['shop_image'],
                        //     height: 50,
                        //     width: 50,
                        //   ),
                        // ),
                        // title: Text(
                        //     document['shop_name'],
                        //   //'Danisco Security',
                        //   style: TextStyle(fontWeight: FontWeight.w600),
                        // ),
                       isThreeLine: true,
                        subtitle: 
                             Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_right,
                        color: Colors.redAccent,
                      ),
                      Expanded(child: Container(
                        child: Text(
                          document.data['data'],style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                          overflow: TextOverflow.clip,
                        ),
                      ),)
                    ],
                  ),
                ),
                 
                          //  trailing: CircleAvatar(
                          //    radius: 30,
                          //    backgroundColor: Colors.transparent,
                          //    child: Image.network('https://cdn.pixabay.com/photo/2012/04/11/17/53/approved-29149_1280.png'), 
                      
                          //  )
                            );
                      }).toList(),
                    );
                }
              },
            ),
 )
    //         Expanded(
    //           child: ListView.builder(itemBuilder: (context, index) {
    //             return Column(
    //               children: <Widget>[
    //                 Container(
    //                   child: ListTile(
    //                     onTap: () {
    //                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Indihome()));
    //                     },
    //                     leading: Container(
    //                       decoration: BoxDecoration(
    //                           border:
    //                               Border.all(color: Colors.black38, width: 1)),
    //                       child: Image.network(
    //                         'https://cdn.adiglobal.in/userfiles/India/New-ADI-logo.png',
    //                         height: 50,
    //                         width: 50,
    //                       ),
    //                     ),
    //                     title: Text(
    //                       'Danisco Security',
    //                       style: TextStyle(fontWeight: FontWeight.w600),
    //                     ),
    //                     subtitle: Container(
    //                         padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: <Widget>[
    //                             Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: <Widget>[
    //                                   SmoothStarRating(
    //       allowHalfRating: false,
    //       onRated: (v) {
    //        },
    //       starCount: 5,
    //       rating: 4,
    //       size: 20.0,
    //       isReadOnly:true,
    //       // filledIconData: Icons.blur_off,
    //       // halfFilledIconData: Icons.blur_on,
    //       color: Colors.red,
    //       borderColor: Colors.green,
    //       spacing:0.0
    // ),

    //                             //  Container(
    //                             //    height: 20,
    //                             //    width: 50,
    //                             //    child:    RatingBar(
                                     
    //                             //       initialRating: 3,
    //                             //       minRating: 1,
    //                             //       direction: Axis.horizontal,
    //                             //       allowHalfRating: true,
    //                             //       itemCount: 5,
    //                             //       itemPadding:
    //                             //           EdgeInsets.symmetric(horizontal: 4.0),
    //                             //       itemBuilder: (context, _) => Icon(
    //                             //         Icons.star,
    //                             //         color: Colors.red,
    //                             //         size:  20 ,
    //                             //       ),
    //                             //       onRatingUpdate: (rating) {
    //                             //         print(rating);
    //                             //       },
    //                             //     ),
                                  
    //                             //  ),

    //                          //   Text('Raitings'),
    //                                 SizedBox(
    //                                   height: 5,
    //                                 ),
    //                                 Text('Address: Jail Road'),
    //                               ],
    //                             ),
    //                           ],
    //                         )),

    //                        trailing: CircleAvatar(
    //                          radius: 30,
    //                          backgroundColor: Colors.transparent,
    //                          child: Image.network('https://cdn.pixabay.com/photo/2012/04/11/17/53/approved-29149_1280.png'), 
                      
    //                        )
    //                         ),
    //                 ),
    //                 Divider(),
    //                 Container(
    //                   child: ListTile(
    //                     leading: Container(
    //                       decoration: BoxDecoration(
    //                           border:
    //                               Border.all(color: Colors.black38, width: 1)),
    //                       child: Image.asset(
    //                         'assets/images/kirana.png',
    //                         height: 50,
    //                         width: 50,
    //                       ),
    //                     ),
    //                     title: Text(
    //                       'Kirana App',
    //                       style: TextStyle(fontWeight: FontWeight.w600),
    //                     ),
    //                     subtitle: Container(
    //                         padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: <Widget>[
    //                             Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: <Widget>[
    //                                   SmoothStarRating(
    //       allowHalfRating: false,
    //       onRated: (v) {
    //        },
    //       starCount: 5, 
    //       rating: 3,
    //       size: 20.0,
    //       isReadOnly:true,
    //       // filledIconData: Icons.blur_off,
    //       // halfFilledIconData: Icons.blur_on,
    //       color: Colors.red,
    //       borderColor: Colors.green,
    //       spacing:0.0
    // ),

    //                             //  Container(
    //                             //    height: 20,
    //                             //    width: 50,
    //                             //    child:    RatingBar(
                                     
    //                             //       initialRating: 3,
    //                             //       minRating: 1,
    //                             //       direction: Axis.horizontal,
    //                             //       allowHalfRating: true,
    //                             //       itemCount: 5,
    //                             //       itemPadding:
    //                             //           EdgeInsets.symmetric(horizontal: 4.0),
    //                             //       itemBuilder: (context, _) => Icon(
    //                             //         Icons.star,
    //                             //         color: Colors.red,
    //                             //         size:  20 ,
    //                             //       ),
    //                             //       onRatingUpdate: (rating) {
    //                             //         print(rating);
    //                             //       },
    //                             //     ),
                                  
    //                             //  ),

    //                          //   Text('Raitings'),
    //                                 SizedBox(
    //                                   height: 5,
    //                                 ),
    //                                 Text('Address: Kothari Market'),
    //                               ],
    //                             ),
    //                           ],
    //                         )),

    //                        trailing: CircleAvatar(
    //                          radius: 30,
    //                          backgroundColor: Colors.transparent,
    //                          child: Image.network('https://cdn.pixabay.com/photo/2012/04/11/17/53/approved-29149_1280.png'), 
                      
    //                        )
    //                         ),
    //                       ),
    //                        Divider()               
   
    //               ],
    //             );
    //           }),
    //         ),
          
          ],
        ),
      ),
    ),



            // Expanded(
            //     child: Column(
            //   children: <Widget>[
            //     Container(
            //       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //       child: Row(
            //         children: <Widget>[
            //           Icon(
            //             Icons.arrow_right,
            //             color: Colors.redAccent,
            //           ),
            //           Container(
            //             child: Text(
            //               'asdf;asdfjlasjdf;lasdlfj;asldkfj;lasdjf;lasjdf;laskjf;slaf',
            //               overflow: TextOverflow.clip,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     SizedBox(
            //       height: 6,
            //     ),
            //     // Container(
            //     //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //     //   child: Row(
            //     //     children: <Widget>[
            //     //       Icon(
            //     //         Icons.arrow_right,
            //     //         color: Colors.redAccent,
            //     //       ),
            //     //       Container(
            //     //         child: Text(
            //     //           '15fps@5MP(2592×1944) and 25/30fps@3MP ',
            //     //           overflow: TextOverflow.clip,
            //     //         ),
            //     //       ),
            //     //     ],
            //     //   ),
            //     // ),
            //     // SizedBox(
            //     //   height: 6,
            //     // ),
            //     // Container(
            //     //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //     //   child: Row(
            //     //     children: <Widget>[
            //     //       Icon(
            //     //         Icons.arrow_right,
            //     //         color: Colors.redAccent,
            //     //       ),
            //     //       Container(
            //     //         child: Text(
            //     //           'Support Starlight Function',
            //     //           overflow: TextOverflow.clip,
            //     //         ),
            //     //       ),
            //     //     ],
            //     //   ),
            //     // ),
            //     // SizedBox(
            //     //   height: 6,
            //     // ),
            //     // Container(
            //     //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //     //   child: Row(
            //     //     children: <Widget>[
            //     //       Icon(
            //     //         Icons.arrow_right,
            //     //         color: Colors.redAccent,
            //     //       ),
            //     //       Container(
            //     //         child: Text(
            //     //           '1/2.7” 5MP PS CMOS Image Sensor',
            //     //           overflow: TextOverflow.clip,
            //     //         ),
            //     //       ),
            //     //     ],
            //     //   ),
            //     // ),
            //     // SizedBox(
            //     //   height: 6,
            //     // ),
            //     // Container(
            //     //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //     //   child: Row(
            //     //     children: <Widget>[
            //     //       Icon(
            //     //         Icons.arrow_right,
            //     //         color: Colors.redAccent,
            //     //       ),
            //     //       Container(
            //     //         child: Text(
            //     //           'H.265 and H.264 triple-stream encoding',
            //     //           overflow: TextOverflow.clip,
            //     //         ),
            //     //       ),
            //     //     ],
            //     //   ),
            //     // ),
              
            //   ],
            // )),
   
   
   
   
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                            //color: Colors.redAccent
                            ),
                        child: RaisedButton(
                            child: Text(
                              'Order Now',
                              style: GoogleFonts.raleway(textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                            ),
                            color: Colors.orangeAccent,
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Contactus(shopCat: widget.shopCat, shoplistDoc: widget.shoplistDoc,)));
                              print('object');
                              //   await FlutterLaunch.launchWathsApp(phone: "5534992016545", message: "Hello");
                            }),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //     padding: EdgeInsets.all(5),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //           //color: Colors.redAccent
                  //           ),
                  //       child: RaisedButton(
                  //           elevation: 10,
                  //           child: Container(
                  //             child: Text(
                  //               'Add to cart',
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //           color: Colors.redAccent,
                  //           onPressed: () {}),
                  //     ),
                  //   ),
                  // ),
               
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
