import 'package:flutter/material.dart';

class ViewSaleQuotation extends StatefulWidget {
  ViewSaleQuotation({Key key}) : super(key: key);

  @override
  State<ViewSaleQuotation> createState() => _ViewSaleQuotationState();
}

class _ViewSaleQuotationState extends State<ViewSaleQuotation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('View Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 80,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order ID ',
                          textAlign: TextAlign.start,
                        ),
                        Text('10001')
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email Address',
                          textAlign: TextAlign.start,
                        ),
                        Text('someone@exampl.com')
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Customer Name',
                          textAlign: TextAlign.start,
                        ),
                        Text('United Intl Trdg')
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone Number',
                          textAlign: TextAlign.start,
                        ),
                        Text('939393939')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _tabSection(context)
          ],
        ),
      ),
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                indicatorColor: Colors.grey,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(text: "View Customer"),
                  Tab(text: "Comments/Logs"),
                  Tab(text: "Task"),
                  Tab(text: "Meeting"),
                  Tab(text: "Documment"),
                ]),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 80,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID ',
                            textAlign: TextAlign.start,
                          ),
                          Text('10001')
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email Address',
                            textAlign: TextAlign.start,
                          ),
                          Text('someone@exampl.com')
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer Name',
                            textAlign: TextAlign.start,
                          ),
                          Text('United Intl Trdg')
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone Number',
                            textAlign: TextAlign.start,
                          ),
                          Text('939393939')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Text("Articles Body"),
              ),
              Container(
                child: Text("User Body"),
              ),
              Container(
                child: Text("User Body"),
              ),
              Container(
                child: Text("User Body"),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
