import 'package:flutter/material.dart';
import 'package:online_seat_booking_app/seat_book.dart';
import 'package:online_seat_booking_app/ticket.dart';

import 'busdata.dart';

class Destination {
  final String name;
  final String description;

  Destination(this.name, this.description);
}
class BookingData {
  Destination? from;
  Destination? to;
  String? departureTime;

  BookingData({this.from, this.to, this.departureTime});
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
  BookingData bookingData = BookingData();

}

class _MainScreenState extends State<MainScreen> {
  List<Destination> destinations = [
    Destination(
      'CL',
      'software dept',
    ),
    Destination('telecom dept', 'electrical dept'),
    Destination('admin block', 'water dept'),
    Destination('enviroment dept', 'crp dept'),
    Destination('civil dept', 'AI dept'),
    Destination('cs dept', 'bscs dept'),
    Destination('IT dept', 'elctronics dept'),
    Destination('machinical dept', 'CC'),
    Destination('CC', 'IT CANTEEN'),
    Destination('BBA dept', 'cyber security'),

    // Add more destinations as needed.
  ];

  Destination? selectedFromDestination;
  Destination? selectedToDestination;
  String? selectedDepartureTime;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showBusListPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Available Buses'),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: availableBuses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(availableBuses[index].busNumber),
                      subtitle: Text(
                        'Destination: ${availableBuses[index].destination.name}\n'
                        'Departure Time: ${availableBuses[index].departureTime}',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusSeatScreen(
                                generateBusSeats().cast<String>(),
                                getBookedSeats()),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    
                    primary:
                        Color.fromARGB(
                          247, 41, 55, 83), // Change the background color of the button
                    onPrimary:
                        Colors.white, // Change the text color of the button
                          minimumSize: Size(30, 48),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _generateTicket() {
  if (selectedFromDestination != null && selectedToDestination != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JourneyDetailsScreen(
          startingPoint: selectedFromDestination!.name,
          destination: selectedToDestination!.name,
          selectedSeats: const [], 
        ),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where do you want to go?'),
        backgroundColor: Color.fromARGB(247, 41, 55, 83),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<Destination>(
                decoration: InputDecoration(
                  labelText: 'From',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          247, 41, 55, 83), 
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          247, 41, 55, 83), 
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(
                        247, 41, 55, 83), 
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(
                        247, 41, 55, 83), 
                  ),
                ),
                isExpanded: true,
                iconSize: 30,
                style: TextStyle(color: Colors.black, fontSize: 16),
                value: selectedFromDestination,
                onChanged: (Destination? newValue) {
                  setState(() {
                    selectedFromDestination = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a departure location';
                  }
                  return null;
                },
                items: destinations.map<DropdownMenuItem<Destination>>(
                  (Destination value) {
                    return DropdownMenuItem<Destination>(
                      value: value,
                      child: Text(value.name),
                    );
                  },
                ).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<Destination>(
                decoration: InputDecoration(
                  labelText: 'To',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          247, 41, 55, 83), 
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          247, 41, 55, 83), 
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(
                        247, 41, 55, 83), 
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(
                        247, 41, 55, 83), 
                  ),
                ),
                isExpanded: true,
                iconSize: 30,
                style: TextStyle(color: Colors.black, fontSize: 16),
                value: selectedToDestination,
                onChanged: (Destination? newValue) {
                  setState(() {
                    selectedToDestination = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a destination';
                  }
                  return null;
                },
                items: destinations.map<DropdownMenuItem<Destination>>(
                  (Destination value) {
                    return DropdownMenuItem<Destination>(
                      value: value,
                      child: Text(value.name),
                    );
                  },
                ).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Timings',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          247, 41, 55, 83),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          247, 41, 55, 83), 
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(
                        247, 41, 55, 83), 
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(
                        247, 41, 55, 83),
                  ),
                ),
                isExpanded: true,
                iconSize: 30,
                style: TextStyle(color: Colors.black, fontSize: 16),
                value: selectedDepartureTime,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDepartureTime = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a departure time';
                  }
                  return null;
                },
                items: [
                  '08:00 AM',
                  '09:00 AM',
                  '10:00 AM',
                  '11:00 AM',
                  '12:00 PM',
                  '01:00 PM',
                  '02:00 PM',
                  '03:00 PM',
                 
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  
                  _showBusListPopup(context);
                }
               
                
              },
              child: Text('Continue'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(247, 41, 55,
                    83), 
                onPrimary: Colors.white,
                padding: EdgeInsets.all(16),
                textStyle: TextStyle(fontSize: 18),
                elevation: 3,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 3,
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10.0), 
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/buspic.jpg',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Enjoy your journey of MUET'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
