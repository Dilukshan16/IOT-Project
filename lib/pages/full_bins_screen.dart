import 'package:flutter/material.dart';
import 'package:waste_management_app/pages/bin_details_screen.dart';

class FullBinsScreen extends StatelessWidget {
  const FullBinsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Bins'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimeHeader(),
            const SizedBox(height: 20),
            _buildBinList(context),
            const SizedBox(height: 20),
            _buildActionButtons(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Bins'),
          BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Routes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
        ],
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
          if (index == 2) Navigator.pushReplacementNamed(context, '/routes');
          if (index == 3) Navigator.pushReplacementNamed(context, '/notifications');
        },
      ),
    );
  }

  Widget _buildTimeHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('9:41 AM', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        const Text('Full Bins', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBinList(BuildContext context) {
    return Column(
      children: [
        _buildBinCard(
          context,
          binId: 'BIN-12345',
          binNumber: 'Bin 1',
          location: 'Main St',
          fillLevel: 85,
          image: const AssetImage('web/assets/bin4.png'),
          weight: '15kg',
          wasteType: 'Plastic',
          lastUpdate: '10 mins ago',
          coordinates: '37.7749° N, 122.4194° W',
        ),
        const SizedBox(height: 16),
        _buildBinCard(
          context,
          binId: 'BIN-67890',
          binNumber: 'Bin 2',
          location: '2nd Ave',
          fillLevel: 90,
          image: const AssetImage('web/assets/plastic.png'),
          weight: '18kg',
          wasteType: 'Mixed',
          lastUpdate: '15 mins ago',
          coordinates: '37.7750° N, 122.4195° W',
        ),
        const SizedBox(height: 16),
        _buildBinCard(
          context,
          binId: 'BIN-54321',
          binNumber: 'Bin 3',
          location: 'Park Lane',
          fillLevel: 82,
          image: const AssetImage('web/assets/bin.jpg'),
          weight: '12kg',
          wasteType: 'Paper',
          lastUpdate: '5 mins ago',
          coordinates: '37.7748° N, 122.4193° W',
        ),
      ],
    );
  }

  Widget _buildBinCard(
    BuildContext context, {
    required String binId,
    required String binNumber,
    required String location,
    required int fillLevel,
    required ImageProvider image,
    required String weight,
    required String wasteType,
    required String lastUpdate,
    required String coordinates,
  }) {
    Color fillColor = fillLevel >= 90
        ? Colors.red
        : fillLevel >= 80
            ? Colors.orange
            : Colors.blue;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BinDetailsScreen(
              binId: binId,
              binNumber: binNumber,
              location: location,
              fillLevel: fillLevel,
              image: image,
              weight: weight,
              wasteType: wasteType,
              lastUpdate: lastUpdate,
              coordinates: coordinates,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(image: image, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(binNumber, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('ID: $binId', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    const SizedBox(height: 4),
                    Text('Location: $location', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Fill: $fillLevel%', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: fillLevel / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: fillColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('View Map'),
            onPressed: () {}, // Added required onPressed
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.location_on),
            label: const Text('All Locations'),
            onPressed: () {}, // Added required onPressed
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}