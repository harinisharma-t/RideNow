
import 'package:flutter/material.dart';

void main() {
  runApp(const RideNowApp());
}

const Color navy = Color(0xFF101D35);
const Color green = Color(0xFF19B77A);
const Color background = Color(0xFFF5F7FA);

// BOOKING DATA

class RideBooking {
  final String id;
  final String pickup;
  final String destination;
  final String vehicle;
  final int fare;
  final DateTime date;

  RideBooking({
    required this.id,
    required this.pickup,
    required this.destination,
    required this.vehicle,
    required this.fare,
    required this.date,
  });
}

// Temporary booking history
final List<RideBooking> bookingHistory = [];

// MAIN APPLICATION

class RideNowApp extends StatelessWidget {
  const RideNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RideNow',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          primary: green,
        ),
        fontFamily: 'Arial',
      ),
      home: const HomeScreen(),
    );
  }
}

// HOME SCREEN

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  int selectedRide = 0;

  final List<Map<String, dynamic>> rides = [
    {
      'name': 'Mini',
      'description': 'Affordable everyday rides',
      'price': 120,
      'icon': Icons.directions_car,
    },
    {
      'name': 'Sedan',
      'description': 'Comfortable and spacious',
      'price': 180,
      'icon': Icons.airport_shuttle,
    },
    {
      'name': 'SUV',
      'description': 'Extra space for your journey',
      'price': 250,
      'icon': Icons.directions_car_filled,
    },
  ];

  @override
  void dispose() {
    pickupController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  void bookRide() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final booking = RideBooking(
      id: DateTime.now().microsecondsSinceEpoch.toString().substring(8),
      pickup: pickupController.text.trim(),
      destination: destinationController.text.trim(),
      vehicle: rides[selectedRide]['name'],
      fare: rides[selectedRide]['price'],
      date: DateTime.now(),
    );

    bookingHistory.insert(0, booking);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmation(
          booking: booking,
        ),
      ),
    );
  }

  void openMyRides() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyRidesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNavigationBar(),
            _buildHeroSection(),
            _buildBookingSection(),
            _buildBenefitsSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Row(
            children: [
              const Icon(
                Icons.local_taxi,
                color: green,
                size: 32,
              ),
              const SizedBox(width: 8),
              const Text(
                'RideNow',
                style: TextStyle(
                  color: navy,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Home',
                  style: TextStyle(color: navy),
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: openMyRides,
                icon: const Icon(
                  Icons.history,
                  color: green,
                ),
                label: const Text(
                  'My Rides',
                  style: TextStyle(color: navy),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () {
                  Scrollable.ensureVisible(
                    formKey.currentContext ?? context,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: green,
                ),
                child: const Text('Book a Ride'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      color: navy,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 65,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: green.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'YOUR JOURNEY, OUR PRIORITY',
                  style: TextStyle(
                    color: green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Your ride.\nYour way.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  height: 1.15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Book comfortable, affordable and reliable rides\nwith just a few clicks.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),
              const Row(
                children: [
                  Icon(Icons.check_circle, color: green, size: 19),
                  SizedBox(width: 9),
                  Text(
                    'Easy booking',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 24),
                  Icon(Icons.check_circle, color: green, size: 19),
                  SizedBox(width: 9),
                  Text(
                    'Affordable fares',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 35,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: Form(
            key: formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 750;

                return Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Book Your Ride',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Enter your journey details to get started.',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 25),
                      if (isWide)
                        Row(
                          children: [
                            Expanded(child: _buildLocationFields()),
                            const SizedBox(width: 28),
                            Expanded(child: _buildVehicleSelection()),
                          ],
                        )
                      else
                        Column(
                          children: [
                            _buildLocationFields(),
                            const SizedBox(height: 28),
                            _buildVehicleSelection(),
                          ],
                        ),
                      const SizedBox(height: 25),
                      _buildFareAndButton(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pickup Location',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: navy,
          ),
        ),
        const SizedBox(height: 9),
        TextFormField(
          controller: pickupController,
          decoration: _inputDecoration(
            'Enter pickup location',
            Icons.my_location,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your pickup location';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'Destination',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: navy,
          ),
        ),
        const SizedBox(height: 9),
        TextFormField(
          controller: destinationController,
          decoration: _inputDecoration(
            'Enter destination',
            Icons.location_on_outlined,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your destination';
            }
            return null;
          },
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: green),
      filled: true,
      fillColor: background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: green, width: 1.5),
      ),
    );
  }

  Widget _buildVehicleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Your Vehicle',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: navy,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(rides.length, (index) {
          final ride = rides[index];
          final isSelected = selectedRide == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedRide = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: isSelected
                    ? green.withValues(alpha: 0.08)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? green : Colors.grey.shade300,
                  width: isSelected ? 1.7 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    ride['icon'],
                    color: isSelected ? green : navy,
                    size: 30,
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ride['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: navy,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          ride['description'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '₹${ride['price']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: navy,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: isSelected ? green : Colors.grey,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFareAndButton() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Estimated Fare',
                style: TextStyle(
                  color: navy,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '₹${rides[selectedRide]['price']}',
                style: const TextStyle(
                  color: green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: bookRide,
              icon: const Icon(Icons.local_taxi),
              label: const Text(
                'Book Your Ride',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Demo application — fares are sample estimates.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 40,
      ),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Why Choose RideNow?',
            style: TextStyle(
              color: navy,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 25,
            runSpacing: 25,
            alignment: WrapAlignment.center,
            children: [
              _benefitCard(
                Icons.speed,
                'Quick Booking',
                'Book your ride in just a few steps.',
              ),
              _benefitCard(
                Icons.payments_outlined,
                'Affordable Prices',
                'Choose a ride that fits your budget.',
              ),
              _benefitCard(
                Icons.verified_user_outlined,
                'Easy Experience',
                'Simple and user-friendly interface.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _benefitCard(
    IconData icon,
    String title,
    String description,
  ) {
    return SizedBox(
      width: 260,
      child: Column(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: green.withValues(alpha: 0.12),
            child: Icon(icon, color: green, size: 27),
          ),
          const SizedBox(height: 13),
          Text(
            title,
            style: const TextStyle(
              color: navy,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: navy,
      child: const Column(
        children: [
          Text(
            'RideNow',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your journey, our priority.',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 12),
          Text(
            '© 2026 RideNow. Academic demonstration project.',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// MY RIDES SCREEN

class MyRidesScreen extends StatelessWidget {
  const MyRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
        title: const Text(
          'My Rides',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: bookingHistory.isEmpty
          ? _buildEmptyState(context)
          : _buildBookingList(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_car_outlined,
              size: 75,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Rides Yet',
              style: TextStyle(
                color: navy,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your booked rides will appear here.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.local_taxi),
              label: const Text('Book a Ride'),
              style: FilledButton.styleFrom(
                backgroundColor: green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Your Booking History',
          style: TextStyle(
            color: navy,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${bookingHistory.length} booking(s) found',
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        ...bookingHistory.map(
          (booking) => _bookingCard(booking),
        ),
      ],
    );
  }

  Widget _bookingCard(RideBooking booking) {
    final date =
        '${booking.date.day}/${booking.date.month}/${booking.date.year}';
    final time =
        '${booking.date.hour.toString().padLeft(2, '0')}:${booking.date.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_taxi,
                color: green,
                size: 26,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  booking.vehicle,
                  style: const TextStyle(
                    color: navy,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                '₹${booking.fare}',
                style: const TextStyle(
                  color: green,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ],
          ),
          const Divider(height: 25),
          _locationRow(
            Icons.my_location,
            booking.pickup,
          ),
          const SizedBox(height: 13),
          _locationRow(
            Icons.location_on_outlined,
            booking.destination,
          ),
          const Divider(height: 25),
          Row(
            children: [
              const Icon(
                Icons.confirmation_number_outlined,
                color: Colors.grey,
                size: 17,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Booking ID: ${booking.id}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                '$date  $time',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Demo Booking',
              style: TextStyle(
                color: green,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationRow(IconData icon, String location) {
    return Row(
      children: [
        Icon(icon, color: green, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            location,
            style: const TextStyle(
              color: navy,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

// BOOKING CONFIRMATION SCREEN

class BookingConfirmation extends StatelessWidget {
  final RideBooking booking;

  const BookingConfirmation({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: navy,
        title: const Text(
          'Booking Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: Color(0xFFE3F8EF),
                  child: Icon(
                    Icons.check_circle,
                    color: green,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Booking Confirmed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: navy,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Your demo ride has been successfully booked.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                _detailRow(
                  Icons.my_location,
                  'Pickup Location',
                  booking.pickup,
                ),
                const Divider(height: 28),
                _detailRow(
                  Icons.location_on_outlined,
                  'Destination',
                  booking.destination,
                ),
                const Divider(height: 28),
                _detailRow(
                  Icons.directions_car,
                  'Selected Vehicle',
                  booking.vehicle,
                ),
                const Divider(height: 28),
                _detailRow(
                  Icons.payments_outlined,
                  'Estimated Fare',
                  '₹${booking.fare}',
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5DF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'This is an academic demo. No actual driver has been assigned and no payment has been processed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8A641D),
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: green,
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyRidesScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.history),
                  label: const Text('View My Rides'),
                  style: TextButton.styleFrom(
                    foregroundColor: navy,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: green, size: 23),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  color: navy,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
