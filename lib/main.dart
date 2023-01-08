import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seat Finder',
      home: HomePage(),
    );
  }
}

// Main class for ui and funcitons:
// Used only one class because of small size project
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Declared colors and controllers
  // Not used a text model or themedata class because of small size of widget and project

  static const Color prime = Color.fromRGBO(129, 202, 255, 1);
  static const Color subprime = Color.fromRGBO(207, 235, 255, 1);
  static const Color textcolor = Color.fromRGBO(1, 93, 197, 1);
  static const Color selected = Color.fromRGBO(0, 150, 255, 1);

  final seatcontroler = TextEditingController();

  bool isSelected = false;

  int cabineNumber = 0;

  int seatnumber = 0;

// Helper function for rendering the indiviual seat with seat number and which type of seat
  Widget custText(int x, String type) {
    return Container(
        height: 50,
        width: 45,
        decoration: BoxDecoration(
          color: x == seatnumber ? selected : subprime,
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(5), right: Radius.circular(5)),
        ),
        margin: const EdgeInsets.all(1),

        //Column for two text outputs
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Seat Number by text widger
            FittedBox(
                child: Text(
              x.toString(),
              style: TextStyle(
                  color: x == seatnumber ? Colors.white : textcolor,
                  fontSize: 17),
            )),

            //Type of seat show at bottom of container
            FittedBox(
                child: Text(
              type,
              style: TextStyle(
                  color: x == seatnumber ? Colors.white : textcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 7),
            ))
          ],
        ));
  }

// Helper function for a cabine which will be render by listview builder
  Widget custSeat({required int cabine, int seatnumber = -1}) {
// Caluculate first seat in cabine
    int x = (cabine - 1) * 8 + 1;
    return Container(
        height: 155,
        margin: const EdgeInsets.all(1),

        // Two side of sides right and left in a cabine
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Right side seats lower ,Middle ,upper and side lower
            Row(
              children: [
                // Used stack for colored region in left-half , right-halt and top
                // Not used in-built border
                Stack(children: [
                  Container(
                    height: 70,
                    width: 155,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 40,
                    width: 155,
                    decoration: BoxDecoration(
                        color: prime, borderRadius: BorderRadius.circular(7)),
                  ),

                  // Lower , Middle and upper seat
                  Positioned(
                    top: 7,
                    left: 7,
                    child: Row(
                      children: [
                        custText(x++, "LOWER"),
                        custText(x++, "MIDDLE"),
                        custText(x++, "UPPER"),
                      ],
                    ),
                  ),
                ]),

                //space for passanger
                const SizedBox(width: 125),

                // side lower seat
                // Used stack for colored region in left-half , right-halt and top
                // Not used in-built border
                Stack(children: [
                  Container(
                    height: 70,
                    width: 60,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        color: prime, borderRadius: BorderRadius.circular(7)),
                  ),
                  Positioned(
                      top: 7, left: 7, child: custText(x + 3, "SIDE LOWER")),
                ]),
              ],
            ),

            //space between seat in a cabine
            const SizedBox(height: 10),

            //left side seats Lower, Middle ,upper and side upper
            Row(
              children: [
                //stack for lower , middle and upper
                Stack(alignment: Alignment.bottomLeft, children: [
                  Container(
                    height: 70,
                    width: 155,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 40,
                    width: 155,
                    decoration: BoxDecoration(
                        color: prime, borderRadius: BorderRadius.circular(7)),
                  ),
                  Positioned(
                    top: 10,
                    left: 7,
                    child: Row(
                      children: [
                        custText(x++, "LOWER"),
                        custText(x++, "MIDDLE"),
                        custText(x++, "UPPER"),
                      ],
                    ),
                  ),
                ]),

                const SizedBox(
                  width: 125,
                ),

                //side upper seat
                Stack(alignment: Alignment.bottomLeft, children: [
                  Container(
                    height: 70,
                    width: 60,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        color: prime, borderRadius: BorderRadius.circular(7)),
                  ),
                  Positioned(
                      top: 7, left: 7, child: custText(x + 1, "SIDE UPPER")),
                ]),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        // use column for Structuring the page
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title text "Seat Finder"
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Seat Finder",
                style: TextStyle(
                    color: prime,
                    fontSize: 30,
                    wordSpacing: 1.5,
                    fontWeight: FontWeight.w600),
              ),
            ),

            // Container contains Textfield and find button
            Container(
              height: 55,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: prime,
                    width: 5.0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Text field
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    width: 250,
                    child: TextField(
                      controller: seatcontroler,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        // IMPORTANT
                        // If used backspace by laptop keyborad the warning is given .Use emulator number keyboard
                        // If user input a invalid input 0 the nothing happens
                        if (seatcontroler.text.isNotEmpty == true) {
                          isSelected = false;
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Seat Number ... ",
                        hintStyle: TextStyle(color: prime),
                        errorStyle: TextStyle(color: Colors.red),
                        //errorText: seatcontroler.text.toString()=="0"? "Enter valid Number ":null,
                      ),
                    ),
                  ),

                  // Find button for submition
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          if (seatcontroler.text.isEmpty == true) {
                            seatnumber = 0;
                          } else {
                            isSelected = true;
                            seatnumber = int.parse(seatcontroler.text);
                            cabineNumber = (seatnumber / 8).ceil();
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: prime, elevation: 0),
                        child: const Text("Find")),
                  )
                ],
              ),
            ),

            // Chat show the cabines
            // by default there are 6 cabine(4 seats) and if user input more the it is render by
            // listview builder. listview builder is more effective in number of elements are more.
            Expanded(
              child: ListView.builder(
                itemCount:
                    isSelected && cabineNumber > 6 ? cabineNumber + 1 : 6,
                itemBuilder: (context, index) {
                  if (isSelected == true) {
                    return custSeat(cabine: index + 1, seatnumber: seatnumber);
                  } else {
                    return custSeat(cabine: index + 1);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
