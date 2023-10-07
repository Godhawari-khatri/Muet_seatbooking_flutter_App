import 'package:flutter/material.dart';

class JourneyDetailsScreen extends StatelessWidget {
  final List<String> selectedSeats;
  final String startingPoint;
  final String destination;

  JourneyDetailsScreen({
    required this.selectedSeats,
    required this.startingPoint,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(247, 41, 55, 83),
        title: Text('Journey Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: Container(
            constraints: BoxConstraints(maxHeight: 400.0), 
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    'Ticket Details',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    title: Text(
                      'Selected Seats:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      children: selectedSeats.map((seat) {
                        return Text(seat);
                      }).toList(),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Starting Point:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(startingPoint),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Destination:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(destination),
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
