import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  CircularProgressIndicator indicator;
  String drawerUsername = username;

  @override
  Widget build(BuildContext context) => Drawer(
          child: Container(
        margin: EdgeInsets.only(top: 25),
        // color: Theme.of(context).backgroundColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SafeArea(
              child: drawerUsername == null
                  ? GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed('/login')
                          .then((value) => setState(() {
                                drawerUsername = username;
                              })),
                      child: Container(
                        // margin: EdgeInsets.only(top: 25),
                        width: 270,
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 1,
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Log in',
                            style: GoogleFonts.lato(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Good evening, $drawerUsername!",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        GestureDetector(
                            onTap: () async {
                              setState(() {
                                indicator = CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                );
                              });
                              await Future.delayed(Duration(seconds: 2));
                              Navigator.pop(context);
                              setState(() {
                                indicator = null;
                                username = null;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 25),
                              width: 170,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Colors.redAccent,
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: indicator != null
                                    ? indicator
                                    : Text(
                                        'Logout',
                                        style: GoogleFonts.lato(
                                            fontSize: 15, color: Colors.white),
                                      ),
                              ),
                            ))
                      ],
                    )),
        ]),
      ));
}
