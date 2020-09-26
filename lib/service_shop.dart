import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prakrati_datacollection/individual_shop/indi_home.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ServiceShop extends StatefulWidget {
 final String categoryDoc;
  ServiceShop({Key key, this.categoryDoc,   }) : super(key: key);

  @override
  _ServiceShopState createState() => _ServiceShopState();
}

class _ServiceShopState extends State<ServiceShop> {




  String categoryDoc;
  String appbarHeading;
 
setcategoryDoc(){
  setState(() {
    categoryDoc=widget.categoryDoc;
  });
}

getAppbarHeading(){
  var data= Firestore.instance.collection('/main/GviDBFwfTjPNPSoAy7FZ/service_cat').document('$categoryDoc').snapshots();

    data.listen((event) { 
     setState(() {
       appbarHeading= event.data['ser_name'];
    
     });
     });
}

 @override
  void initState() {
     setcategoryDoc();
     getAppbarHeading();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appbarHeading,
          style: GoogleFonts.raleway(textStyle: TextStyle(
            fontFamily: 'montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),)
        ),
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
            Expanded(child:StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('/main/GviDBFwfTjPNPSoAy7FZ/service_cat/$categoryDoc/shop_list')
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
                        onTap: () {
                          print(document.documentID);
                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Indihome( shoplistDoc: categoryDoc, shopCat: document.documentID )));
                        },
                        leading: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black38, width: 1)),
                          child: Image.network(
                            //'https://cdn.adiglobal.in/userfiles/India/New-ADI-logo.png',
                            document['shop_image'],
                            height: 50,
                            width: 50,
                          ),
                        ),
                        title: Text(
                            document['shop_name'],
                          //'Danisco Security',
                          style: GoogleFonts.lato(textStyle: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        subtitle: Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                      SmoothStarRating(
          allowHalfRating: false,
          onRated: (v) {
           },
          starCount: 5,
           // rating:   double.parse(document['shop_rating']), 
          size: 20.0,
          isReadOnly:true,
          // filledIconData: Icons.blur_off,
          // halfFilledIconData: Icons.blur_on,
          color: Colors.red,
          borderColor: Colors.green,
          spacing:0.0
    ),

                                //  Container(
                                //    height: 20,
                                //    width: 50,
                                //    child:    RatingBar(
                                     
                                //       initialRating: 3,
                                //       minRating: 1,
                                //       direction: Axis.horizontal,
                                //       allowHalfRating: true,
                                //       itemCount: 5,
                                //       itemPadding:
                                //           EdgeInsets.symmetric(horizontal: 4.0),
                                //       itemBuilder: (context, _) => Icon(
                                //         Icons.star,
                                //         color: Colors.red,
                                //         size:  20 ,
                                //       ),
                                //       onRatingUpdate: (rating) {
                                //         print(rating);
                                //       },
                                //     ),
                                  
                                //  ),

                             //   Text('Raitings'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(  'Address: '  +document['shop_address'] , style: GoogleFonts.raleway(textStyle: TextStyle(fontWeight: FontWeight.w600)),),
                                  ],
                                ),
                              ],
                            )),

                           trailing: CircleAvatar(
                             radius: 30,
                             backgroundColor: Colors.transparent,
                             child: Image.network('https://cdn.pixabay.com/photo/2012/04/11/17/53/approved-29149_1280.png'), 
                      
                           )
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
    );
  }
}
