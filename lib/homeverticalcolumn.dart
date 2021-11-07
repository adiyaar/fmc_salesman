import 'package:flutter/material.dart';

class homeverticalcolumn extends StatefulWidget {
  @override
  _homeverticalcolumn createState() => _homeverticalcolumn();
}

class _homeverticalcolumn extends State<homeverticalcolumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFd9d9d9)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFd9d9d9),
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              //BoxShadow
            ],
            color: Colors.white,
          ),
          width: double.infinity,
          height: 100.0,
          //color: Colors.white, if box decoration is there u cant keep color outside it should be compulsory inside
          child: Row(
            children: [
              MaterialButton(
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                child: Icon(
                  Icons.chat_bubble,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: 230.0,
                    height: 40.0,
                    color: Colors.white,
                    child: Text(
                      '18',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 230.0,
                    height: 30.0,
                    color: Colors.white,
                    child: Text(
                      'No of Leads',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFb3b3b3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFd9d9d9)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFd9d9d9),
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              //BoxShadow
            ],
            color: Colors.white,
          ),
          width: double.infinity,
          height: 100.0,
          //color: Colors.white,
          child: Row(
            children: [
              MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                textColor: Colors.white,
                child: Icon(
                  Icons.chrome_reader_mode,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: 230.0,
                    height: 40.0,
                    color: Colors.white,
                    child: Text(
                      '15',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 230.0,
                    height: 30.0,
                    color: Colors.white,
                    child: Text(
                      'No of Sales Quotation',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFb3b3b3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFd9d9d9)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFd9d9d9),
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              //BoxShadow
            ],
            color: Colors.white,
          ),
          width: double.infinity,
          height: 100.0,
          //color: Colors.white,
          child: Row(
            children: [
              MaterialButton(
                onPressed: () {},
                color: Colors.yellow,
                textColor: Colors.white,
                child: Icon(
                  Icons.collections_bookmark,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: 230.0,
                    height: 40.0,
                    color: Colors.white,
                    child: Text(
                      '10',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 230.0,
                    height: 30.0,
                    color: Colors.white,
                    child: Text(
                      'No of Sales Order',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFb3b3b3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFd9d9d9)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFd9d9d9),
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              //BoxShadow
            ],
            color: Colors.white,
          ),
          width: double.infinity,
          height: 100.0,
          //color: Colors.white,
          child: Row(
            children: [
              MaterialButton(
                onPressed: () {},
                color: Colors.orange,
                textColor: Colors.white,
                child: Icon(
                  Icons.directions_bus,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: 230.0,
                    height: 40.0,
                    color: Colors.white,
                    child: Text(
                      '7',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 230.0,
                    height: 30.0,
                    color: Colors.white,
                    child: Text(
                      'No of Delivery Note',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFb3b3b3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFd9d9d9)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFd9d9d9),
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
              //BoxShadow
            ],
            color: Colors.white,
          ),
          width: double.infinity,
          height: 100.0,
          //color: Colors.white,
          child: Row(
            children: [
              MaterialButton(
                onPressed: () {},
                color: Colors.green,
                textColor: Colors.white,
                child: Icon(
                  Icons.confirmation_number,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: 230.0,
                    height: 40.0,
                    color: Colors.white,
                    child: Text(
                      '5',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 230.0,
                    height: 30.0,
                    color: Colors.white,
                    child: Text(
                      'No of Sales Invoice',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFb3b3b3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
