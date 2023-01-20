import 'package:http/http.dart';
import 'dart:convert';
import  'package:intl/intl.dart';

class WorldTime {

  late String location; // location name for the UI
  late String time;     // time in that location
  late String flag;     // url to asset flag icon
  late String url;      // url to Api end point
  late bool isDayTime;  //true or flase for day time

  WorldTime({ required this.location , required this.flag , required this.url});

  Future<void> getTime() async {

    try
    {
      // make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      String dateTime = data['datetime'].toString();
      String offset_hours = data['utc_offset'].substring(0,3);
      String offset_minutes = data['utc_offset'].substring(0,1)+data['utc_offset'].substring(4,6);
      //create a dateTime Object

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset_hours) , minutes: int.parse(offset_minutes)));

      //set the time property
      isDayTime =  now.hour > 6 && now.hour < 20 ? true : false ;
      time = DateFormat.jm().format(now);

    }
    catch(e)
    {
      print('caught error : $e');
      time = 'could not get time data';
    }



  }
}