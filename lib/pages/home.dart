import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    //set background
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor =  data['isDayTime'] ? Colors.blue : Colors.indigo[700]  as Color;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                      onPressed: () async{
                        dynamic result = await Navigator.pushNamed(context , '/location');
                        setState(() {
                          data = {
                            'time' : result['time'],
                            'location' : result['location'],
                            'isDayTime' :result['isDayTime'],
                            'flag' : result['flag'],
                          } ;
                        });
                      },
                      icon: Icon(
                          Icons.edit_location,
                        color: Colors.grey[300],
                      ),
                      label: Text(
                          'Edit Location',
                          style: TextStyle(
                            color: Colors.grey[300],
                          ),
                      ) ,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      ),
                  SizedBox(height: 20,),
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
