import 'dart:collection';
import 'package:injaz_task/models/requst_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Locaction extends StatefulWidget {
 // final double latitude,longitude;
  Request request;
 // Locaction(this.latitude,this.longitude);
  Locaction(this.request);

  @override
  _LocactionState createState() => _LocactionState();
}

class _LocactionState extends State<Locaction> {



  var myMarker=HashSet<Marker>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.request.latitude, widget.request.longitude
          ),zoom: 13,


        ),
        onMapCreated: (GoogleMapController googleMapController){
          setState(() {

            myMarker.add(Marker(markerId:MarkerId('1'),position: LatLng(widget.request.latitude, widget.request.longitude),
              infoWindow: InfoWindow(
                title: 'Code2Start',
                onTap: (){
                  print('code2start');
                },

                snippet: 'Please shear code2Start',

              ),
             // icon:customMarker,
            )

            );
          });
        },
        markers: myMarker,
        //  polygons: myPolygon(),
      ),
    );
  }
}
