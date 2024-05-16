import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late WebViewController webViewController;

  int currentIndex = 0;
  List<String> urls = [
    "https://www.togoparts.com/home",
    "https://www.togoparts.com/bikeprofile/trides",
    "https://www.togoparts.com/marketplace/create",
    "https://www.togoparts.com/marketplace/browse"
  ];

  @override
  void initState() {
// TODO: implement initState
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (a) {},
          onProgress: (b) {},
          onPageFinished: (c) {},
        ),
      );

    webViewController.loadRequest(Uri.parse(urls.elementAt(currentIndex)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Text(
              'TogoParts',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.white,),
              ),
              IconButton(
                onPressed: () async {
                  final Uri emailUri =
                      Uri(scheme: 'mailto', path: 'store@togoparts.com');
                  if (await canLaunchUrl(emailUri)) {
                    launchUrl(emailUri);
                  } else {
                    throw Exception('Could not launch $emailUri');
                  }
                },
                icon: const Icon(Icons.email_rounded, color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.settings),
                          ),
                          Text("Setting"),
                        ],
                      ),
                    )
                  ],
                  child: const Icon(Icons.more_vert_rounded, color: Colors.white,),
                ),
              )
            ]),
        body: Material(
          child: WebViewWidget(
            controller: webViewController,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              webViewController.loadRequest(
                Uri.parse(
                  urls.elementAt(currentIndex),
                ),
              );
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_bike_rounded),
                label: "Rides",
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined),
                label: "Add Post",
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_business_rounded),
                label: "Marketplace",
                backgroundColor: Colors.orange),
          ],
        ),
      ),
    );
  }
}
