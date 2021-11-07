import 'package:flutter/material.dart';
import 'package:testing/dynamic/All_branch.dart';
import 'package:testing/dynamic/itemmaster.dart';

class homehorizontalrow extends StatefulWidget {
  @override
  _homehorizontalrow createState() => _homehorizontalrow();
}

class _homehorizontalrow extends State<homehorizontalrow> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
            child: Container(
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
                width: 150.0,
                height: 100.0,
                //color: Colors.white,
                child: Center(
                  child: InkWell(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                '3',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                'Company',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFb3b3b3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                      }),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
              width: 150.0,
              height: 100.0,
              //color: Colors.white,
              child: Center(
                  child: InkWell(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              '12',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              'Branch',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFb3b3b3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => All_branch()),
                        );
                      }
                  ),
                  ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
              width: 150.0,
              height: 100.0,
              //color: Colors.white,
              child: Center(
                child: InkWell(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              '22000',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              'Items',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFb3b3b3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Itemmaster()),
                      );
                    }
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                width: 150.0,
                height: 100.0,
                //color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            '102',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            'Employees',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFb3b3b3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                width: 150.0,
                height: 100.0,
                //color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            '986',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            'Customer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFb3b3b3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
            child: Container(
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
                width: 150.0,
                height: 100.0,
                //color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            '189',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            'Supplier',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFb3b3b3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
