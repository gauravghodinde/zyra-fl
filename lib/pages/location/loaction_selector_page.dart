import 'package:zyra/components/locationcard.dart';
import 'package:zyra/model/location.dart';
import 'package:zyra/pages/location/postLocationPage.dart';
import 'package:zyra/providers/locationListProvider.dart';
import 'package:zyra/providers/userProvider.dart';
import 'package:zyra/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class locationSelector extends StatelessWidget {
  const locationSelector({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context).user;
    var _locationListProvider =
        Provider.of<LocationListProvider>(context, listen: false).loactionlist;

    return Container(
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Select a location",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddLocation(
                                  userId: _user.id,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[500]!,
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.add,
                                // color: Color(Constants.mainColorHsh),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Add Address"),
                              )
                            ],
                          ),
                          Icon(Icons.navigate_next_sharp),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: <Widget>[
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "SAVED ADDRESSES",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                        itemCount: _locationListProvider.locationlist.length,
                        itemBuilder: (context, j) {
                          return LocationCard(
                            type: type,
                            location: _locationListProvider.locationlist[j],
                          );
                        }),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
