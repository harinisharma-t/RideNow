
import 'package:flutter/material.dart';

const Color navy = Color(0xFF14243A);
const Color green = Color(0xFFB9F36B);

class BookingConfirmation extends StatelessWidget {
  final String pickup;
  final String destination;
  final String vehicle;
  final int fare;

  const BookingConfirmation({
    super.key,
    required this.pickup,
    required this.destination,
    required this.vehicle,
    required this.fare,
  });

  @override
  Widget build(BuildContext context) {
    final bookingId =
        'RN${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: const Text(
          'RideNow',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: Color(0xFFF0F9E6),
                    child: Icon(
                      Icons.check_circle,
                      color: Color(0xFF79B832),
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ride Booked!',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your ride has been successfully booked.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'BOOKING ID',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blueGrey,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          bookingId,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: navy,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  _detailRow(
                    Icons.my_location,
                    'Pickup Location',
                    pickup,
                  ),
                  const SizedBox(height: 20),
                  _detailRow(
                    Icons.location_on,
                    'Destination',
                    destination,
                  ),
                  const SizedBox(height: 20),
                  _detailRow(
                    Icons.directions_car,
                    'Selected Vehicle',
                    vehicle,
                  ),
                  const Divider(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Estimated Fare',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: navy,
                        ),
                      ),
                      Text(
                        '₹$fare',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF79B832),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F9E6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline, color: navy, size: 18),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Demo booking – no driver has been assigned.',
                            style: TextStyle(
                              fontSize: 12,
                              color: navy,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navy,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF79B832), size: 23),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: navy,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
