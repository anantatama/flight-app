import 'package:flightapp/CustomShapeClipper.dart';
import 'package:flightapp/main.dart';
import 'package:flutter/material.dart';

final Color flightBorderColor = Color(0xFFE6E6E6);
final Color chipBackgroundColor = Color(0xFFF6F6F6);
final Color discountBackgroundColor = Color(0xFFFFE08D);

class InheritedFlightListing extends InheritedWidget{
  final String fromLocation, toLocation;

  InheritedFlightListing({this.fromLocation, this.toLocation, Widget child}) : super(child: child); 
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InheritedFlightListing of(BuildContext context) => context.inheritFromWidgetOfExactType(InheritedFlightListing);

}

class FlightListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Result",),
        elevation: 0.0,
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
          ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            FlightListTopPart(),
            SizedBox(height: 20.0,),
            FlightListingBottomPart(),
          ],
        ),
      ),
    );
  }
}

class FlightListTopPart extends StatelessWidget {
  
  final String fromLocation, toLocation;

  FlightListTopPart({this.fromLocation, this.toLocation});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [firstColor, secondColor],
              )
            ),
            height: 160.0,
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              elevation: 10.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${InheritedFlightListing.of(context).fromLocation}', style: TextStyle(fontSize: 16.0,)),
                          Divider(color: Colors.grey, height: 20.0,),
                          Text('${InheritedFlightListing.of(context).toLocation}', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.import_export, color: Colors.black, size: 32.0,)),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class FlightListingBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Best Deals for Next 6 Months",
              style: dropDownMenuItemStyle,
            ),
          ),
          SizedBox(height: 10.0,),
          ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              FlightCard(),
              FlightCard(),
              FlightCard(),
              FlightCard(),
              FlightCard(),
            ],
          )
        ],
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
          children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0),),
              border: Border.all(color: flightBorderColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '${formatCurrency.format(4159)}', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(width: 4.0,),
                      Text(
                        '(${formatCurrency.format(9999)})', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 16.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: -8.0,
                    children: <Widget>[
                      FlightDetailChip(Icons.calendar_today, "June 2019"),
                      FlightDetailChip(Icons.flight_takeoff, "Jet Airways"),
                      FlightDetailChip(Icons.star, "4.4")
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                '55%', 
                style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0)
                )
              ),
            ),
          )
        ]
      ),
    );
  }
}

class FlightDetailChip extends StatelessWidget {

  final IconData iconData;
  final String label;

  FlightDetailChip(this.iconData, this.label);
  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(color:  Colors.black, fontSize: 14.0),
      backgroundColor: chipBackgroundColor,
      avatar: Icon(iconData, size: 14.0,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0),),
      ),
    );
  }
}