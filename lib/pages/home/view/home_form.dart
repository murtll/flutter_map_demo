import 'package:first_flutter_app/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'package:flutter_map/flutter_map.dart';

import '../cubit/home_repository.dart';

class HomeForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  var zoom = 8.0;

  List<Marker> _markers = [];

  @override
  void initState() {
    HomeRepository.sampleData?.asMap()?.forEach((key, data) {
      _markers.add(Marker(
        point: LatLng(data['location']['coordinates'][0],
            data['location']['coordinates'][1]),
        builder: (context) => Container(
          child: Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
        ),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMap(),
        Column(
          children: [
            SafeArea(
              minimum: EdgeInsets.only(top: 40, left: 20),
              child: CustomButton(
                onTap: _showDrawer,
                icon: Icon(
                  Icons.menu,
                  size: 32,
                  color: Colors.blueGrey[800],
                ),
              ),
            ),
            // _zoomMapButton(),
            // _unzoomMapButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildMap() => FlutterMap(
        options: new MapOptions(
          center: new LatLng(59.9386, 30.3141),
          zoom: zoom,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: _markers,
          ),
        ],
      );

  Widget _zoomMapButton() => SafeArea(
        minimum: EdgeInsets.only(top: 20, left: 20),
        child: GestureDetector(
          onTap: _incrementZoom,
          child: Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  )
                ]),
            child: Icon(
              Icons.zoom_in,
              size: 32,
              color: Colors.blueGrey[800],
            ),
          ),
        ),
      );

  Widget _unzoomMapButton() => SafeArea(
        minimum: EdgeInsets.only(top: 10, left: 20),
        child: GestureDetector(
          onTap: _decrementZoom,
          child: Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  )
                ]),
            child: Icon(
              Icons.zoom_out,
              size: 32,
              color: Colors.blueGrey[800],
            ),
          ),
        ),
      );

  _showDrawer() => (Scaffold.of(context).isDrawerOpen)
      ? Scaffold.of(context).openEndDrawer()
      : Scaffold.of(context).openDrawer();

  void _incrementZoom() {
    setState(() {
      if (zoom < 20) zoom++;
      // print(zoom);
    });
  }

  void _decrementZoom() {
    setState(() {
      if (zoom > 2) zoom--;
    });
  }
}
