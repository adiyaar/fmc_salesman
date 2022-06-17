import 'package:flutter/material.dart';
import 'package:responsify/responsify.dart';
import 'package:testing/Common/common.dart';
import 'package:testing/models/LeadModel.dart';

class LeadScreen extends StatefulWidget {
  @override
  _LeadScreenState createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  List<EmailItem> _emails;
  @override
  void initState() {
    _emails = emails;
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return ResponsiveUiWidget(
      targetOlderComputers: true,
      builder: (context, deviceinfo) {
        if (deviceinfo.deviceTypeInformation == DeviceTypeInformation.TABLET &&
            deviceinfo.orientation == Orientation.landscape) {
          return Container();
        } else {
          return Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              elevation: 0.0,
              actions: [
                IconButton(
                  icon: Icon(Icons.archive),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.mail_outline),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: emails.length,
                      itemBuilder: (context, index) {
                        return EmailListTile(item: emails[index]);
                      })
                ],
              ),
            ),
          );
        }
      },
    );
    
  }
}

List<EmailItem> emails = <EmailItem>[
  EmailItem(
    avatar: "RD",
    title: "New Flutter App",
    description: "Just some quick thoughts...",
    favorite: true,
    date: DateTime(2018, 9, 7, 17, 30),
  ),
  EmailItem(
    avatar: "AD",
    title: "Taxes 2019",
    description:
        "What W2s do you need to complete taxes? I see the one from last year but not this year.",
    favorite: true,
    date: DateTime(2018, 10, 7, 17, 30),
  ),
  EmailItem(
    avatar: "CJ",
    title: "New App Idea",
    description:
        "What if there was an app that could detect if something was a hot dog or not a hot dog?!",
    favorite: false,
    date: DateTime(2018, 11, 7, 17, 30),
  ),
  EmailItem(
    avatar: "AD",
    title: "Save 10% with Geico",
    description: "15 minutes could save you 15% or more on Car Insurance.",
    favorite: false,
    date: DateTime(2018, 11, 8, 17, 30),
  ),
  EmailItem(
    avatar: "RD",
    title: "Follow Up",
    description:
        "Still haven't heard back, I have sent you many ideas. Let me know if you are interested.",
    favorite: true,
    date: DateTime(2018, 12, 7, 17, 30),
  ),
  EmailItem(
    avatar: "FG",
    title: "Time to Refinance",
    description: "Rates have never been lower!",
    favorite: false,
    date: DateTime(2018, 12, 8, 17, 30),
  ),
  EmailItem(
    avatar: "RD",
    title: "New Flutter App",
    description: "Just some quick thoughts...",
    favorite: true,
    date: DateTime(2018, 9, 7, 17, 30),
  ),
  EmailItem(
    avatar: "AD",
    title: "Taxes 2019",
    description:
        "What W2s do you need to complete taxes? I see the one from last year but not this year.",
    favorite: true,
    date: DateTime(2018, 10, 7, 17, 30),
  ),
  EmailItem(
    avatar: "CJ",
    title: "New App Idea",
    description:
        "What if there was an app that could detect if something was a hot dog or not a hot dog?!",
    favorite: false,
    date: DateTime(2018, 11, 7, 17, 30),
  ),
  EmailItem(
    avatar: "AD",
    title: "Save 10% with Geico",
    description: "15 minutes could save you 15% or more on Car Insurance.",
    favorite: false,
    date: DateTime(2018, 11, 8, 17, 30),
  ),
  EmailItem(
    avatar: "RD",
    title: "Follow Up",
    description:
        "Still haven't heard back, I have sent you many ideas. Let me know if you are interested.",
    favorite: true,
    date: DateTime(2018, 12, 7, 17, 30),
  ),
  EmailItem(
    avatar: "FG",
    title: "Time to Refinance",
    description: "Rates have never been lower!",
    favorite: false,
    date: DateTime(2018, 12, 8, 17, 30),
  ),
  EmailItem(
    avatar: "RD",
    title: "New Flutter App",
    description: "Just some quick thoughts...",
    favorite: true,
    date: DateTime(2018, 9, 7, 17, 30),
  ),
  EmailItem(
    avatar: "AD",
    title: "Taxes 2019",
    description:
        "What W2s do you need to complete taxes? I see the one from last year but not this year.",
    favorite: true,
    date: DateTime(2018, 10, 7, 17, 30),
  ),
  EmailItem(
    avatar: "CJ",
    title: "New App Idea",
    description:
        "What if there was an app that could detect if something was a hot dog or not a hot dog?!",
    favorite: false,
    date: DateTime(2018, 11, 7, 17, 30),
  ),
  EmailItem(
    avatar: "AD",
    title: "Save 10% with Geico",
    description: "15 minutes could save you 15% or more on Car Insurance.",
    favorite: false,
    date: DateTime(2018, 11, 8, 17, 30),
  ),
  EmailItem(
    avatar: "RD",
    title: "Follow Up",
    description:
        "Still haven't heard back, I have sent you many ideas. Let me know if you are interested.",
    favorite: true,
    date: DateTime(2018, 12, 7, 17, 30),
  ),
  EmailItem(
    avatar: "FG",
    title: "Time to Refinance",
    description: "Rates have never been lower!",
    favorite: false,
    date: DateTime(2018, 12, 8, 17, 30),
  ),
];

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(),
    );
  }
}

class AppSideMenu extends StatelessWidget {
  const AppSideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          IconButton(
            icon: Icon(Icons.inbox),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.people_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.star_border),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
