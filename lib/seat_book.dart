import 'package:flutter/material.dart';
import 'package:online_seat_booking_app/busdata.dart';
import 'package:online_seat_booking_app/ticket.dart';

class BusSeatScreen extends StatefulWidget {
  final List<String> busSeats;
  final List<String> bookedSeats;

  BusSeatScreen(this.busSeats, this.bookedSeats);

  @override
  _BusSeatScreenState createState() => _BusSeatScreenState();
}

class _BusSeatScreenState extends State<BusSeatScreen> {
 List<String> selectedSeats = [];
 String startingPoint = ''; // Initialize with the starting point
  String destination = '';   // Initialize with the destination



 void _generateTicket() {
  if (startingPoint.isNotEmpty && destination.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JourneyDetailsScreen(
          selectedSeats: selectedSeats,
          startingPoint: startingPoint,
          destination: destination,
        ),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(247, 41, 55, 83),
        title: Text('Bus Seat Booking'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Adjust the number of columns as needed
        ),
        itemCount: widget.busSeats.length,
        itemBuilder: (context, index) {
          final seat = widget.busSeats[index];
          final isSeatSelected = selectedSeats.contains(seat);
          final isSeatBooked = widget.bookedSeats.contains(seat);

          return InkWell(
            onTap: () {
              setState(() {
                if (!isSeatBooked) {
                  if (isSeatSelected) {
                    selectedSeats.remove(seat);
                  } else {
                    selectedSeats.add(seat);
                  }
                }
              });
            },
            child: Container(
              color: isSeatBooked
                  ? Colors.grey
                  : isSeatSelected
                      ? Colors.blue // Selected seat color
                      : Colors.green, // Available seat color
              margin: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  seat,
                  style: TextStyle(
                    color: isSeatBooked
                        ? Colors.black // Booked seat text color
                        : isSeatSelected
                            ? Colors.white // Selected seat text color
                            : Colors.white, // Available seat text color
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
  onPressed: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JourneyDetailsScreen(
          selectedSeats: selectedSeats,
          startingPoint: "cs dept",
          destination: "admin block",
        ),
      ),
    );
    
    
  },
  child: Text('Book Selected Seats'),
  style: ElevatedButton.styleFrom(
                    
                    primary:
                        Color.fromARGB(
                          247, 41, 55, 83), // Change the background color of the button
                    onPrimary:
                        Colors.white, // Change the text color of the button
                          
                  ),
),

    );
  }
}

List<String> generateBusSeats() {
  // Generate a list of bus seats, e.g., ['1A', '1B', '2A', '2B', ...]
  List<String> seats = [];
  for (int i = 1; i <= 10; i++) {
    for (String letter in ['A', 'B', 'C', 'D']) {
      seats.add('$i$letter');
    }
  }
  return seats;
}

List<String> getBookedSeats() {
  // Simulate booked seats, replace this with your actual booked seat data
  return ['2B', '3C', '5A','7B','8C','9A','1A','3D','9D','10C'];
}