import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signup_and_login/screens/browse_products.dart';
import 'package:signup_and_login/NavBar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:signup_and_login/screens/checklist_screen.dart';
import 'package:signup_and_login/screens/checkout_screen.dart';
import 'package:signup_and_login/screens/scan_results.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String scanBarcode = "";
  List imageList = [
    {"id": 1, "image_path": 'assets/images/butter.jpeg'},
    {"id": 2, "image_path": 'assets/images/biscuit.png'},
    {"id": 3, "image_path": 'assets/images/cereals.png'}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      scanBarcode = barcodeScanRes;
    });
  }

  /*Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }*/

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color(0xFFFFFFB8);
    Color myColor2 = const Color(0xFF274F21);

    return Scaffold(
      backgroundColor: myColor,
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: myColor2,
        centerTitle: true,
        title: const Text("Welcome!"),
      ),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            InkWell(
              onTap: () {
                print(currentIndex);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Set the border color
                    width: 2.0, // Set the border width
                  ),
                ),
                child: CarouselSlider(
                  items: imageList
                      .map(
                        (item) => Image.asset(
                          item['image_path'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 1.5,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 17 : 7,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentIndex == entry.key
                              ? Colors.red
                              : Colors.teal),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 65,
        ),
        SizedBox(
          width: 350,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChecklistScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: myColor2, // Button background color
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 18), // Text color
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Button border radius
              ),
              elevation: 5.0, // Button elevation
              shadowColor: Colors.black, // Shadow color
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.checklist_outlined), // Add your desired icon
                SizedBox(width: 10),
                Text("Checklist"),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        /*SizedBox(
          child: ElevatedButton(
            child: const Text("Browse products"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FetchData()));
            },
          ),
        ),*/
        SizedBox(
          width: 350,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FetchData()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: myColor2, // Button background color
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 18), // Text color
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Button border radius
              ),
              elevation: 5.0, // Button elevation
              shadowColor: Colors.black, // Shadow color
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search), // Add your desired icon
                SizedBox(width: 10),
                Text("Browse Products"),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        /*const SizedBox(
          height: 20,
        ),*/
        /*SizedBox(
          child: ElevatedButton(
            child: const Text("Loyalty Programs"),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Checkout()));
            },
          ),
        ),*/
        SizedBox(
          width: 350,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Checkout()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: myColor2, // Button background color
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 18), // Text color
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Button border radius
              ),
              elevation: 5.0, // Button elevation
              shadowColor: Colors.black, // Shadow color
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events_outlined), // Add your desired icon
                SizedBox(width: 10),
                Text("Loyalty Programs"),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          width: 350,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              scanBarcodeNormal();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ScanResults(scanBarcode: scanBarcode)));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: myColor2, // Button background color
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 18), // Text color
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Button border radius
              ),
              elevation: 5.0, // Button elevation
              shadowColor: Colors.black, // Shadow color
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.scanner), // Add your desired icon
                SizedBox(width: 10),
                Text("Scan Barcode"),
              ],
            ),
          ),
        ),
        /*SizedBox(
          child: ElevatedButton(
              child: const Text("Start Barcode Scan"),
              onPressed: () {
                scanBarcodeNormal();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScanResults(scanBarcode: scanBarcode)));
              }),
        ),*/

        /*SizedBox(
          child: ElevatedButton(
            child: const Text("Start barcode scan stream"),
            onPressed: () => startBarcodeScanStream(),
          ),
        ),*/
      ]),
    );
  }
}
