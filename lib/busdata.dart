// bus_data.dart
Destination? selectedToDestination;
Destination? selectedFromDestination;
String? selectedDepartureTime;

class Destination {
  final String name;
  final String description;

  Destination(this.name, this.description);
}

class Bus {
  final String busNumber;
  final Destination destination;
  final String departureTime;

  Bus(this.busNumber, this.destination, this.departureTime);
}


List<Bus> availableBuses = [
  Bus('Bus 1', Destination('CC', 'CL'), '08:00 AM'),
  Bus('Bus 2', Destination('SW', 'EL'), '09:00 AM'),
  Bus('Bus 3', Destination('AI', 'ES'), '09:00 AM'),
  Bus('Bus 4', Destination('ME', 'CE'), '09:00 AM'),
  Bus('Bus 5', Destination('CRP', 'EE'), '09:00 AM'),
 
];


  List<Bus> filteredBuses = availableBuses.where((bus) {
  return bus.destination == selectedToDestination &&
      bus.departureTime == selectedDepartureTime;
}).toList();
