import 'package:flutter/material.dart';

class BinDetailsScreen extends StatelessWidget {
  final String binId;
  final String binNumber;
  final String location;
  final int fillLevel;
  final ImageProvider image;
  final String weight;
  final String wasteType;
  final String lastUpdate;
  final String coordinates;

  const BinDetailsScreen({
    super.key,
    required this.binId,
    required this.binNumber,
    required this.location,
    required this.fillLevel,
    required this.image,
    required this.weight,
    required this.wasteType,
    required this.lastUpdate,
    required this.coordinates,
  });

  @override
  Widget build(BuildContext context) {
    Color fillColor = fillLevel >= 90
        ? Colors.red
        : fillLevel >= 80
            ? Colors.orange
            : Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bin Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: image, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailItem('Bin ID', binId),
            _buildDetailItem('Location', location),
            const SizedBox(height: 16),
            _buildDetailItem('Fill Level', '$fillLevel%'),
            _buildProgressIndicator(fillLevel, fillColor),
            const SizedBox(height: 16),
            _buildDetailItem('Weight', weight),
            _buildDetailItem('Waste Type', wasteType),
            _buildDetailItem('GPS Coordinates', coordinates),
            const SizedBox(height: 16),
            _buildDetailItem('Last Update', lastUpdate),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.map),
                    label: const Text('View on Map'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Mark as Collected'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.flag_outlined),
                    label: const Text('Flag Issue'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh Data'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(int fillLevel, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
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
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}