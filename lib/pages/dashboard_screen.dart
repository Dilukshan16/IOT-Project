import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');// Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimeHeader(),
            const SizedBox(height: 20),
            _buildStatsRow(context),
            const SizedBox(height: 20),
            _buildMapSection(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Bins',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: 'Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        onTap: (index) {
          // Handle navigation
          switch (index) {
            case 0:
              // Already on dashboard
              break;
            case 1:
              Navigator.pushNamed(context, '/bins');
              break;
            case 2:
              Navigator.pushNamed(context, '/routes');
              break;
            case 3:
              Navigator.pushNamed(context, '/notifications');
              break;
          }
        },
      ),
    );
  }

  Widget _buildTimeHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '9:41 AM',
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(255, 156, 226, 125),
          ),
        ),
        const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard(
          context,
          title: 'Full Bins',
          value: '5',
          subtitle: 'pickups',
          color: const Color.fromARGB(255, 8, 8, 8),
          icon: Icons.delete,
          image: const AssetImage('web/assets/images.jpg'),
        ),
        _buildStatCard(
          context,
          title: 'Urgent',
          value: '12',
          subtitle: 'bins >80%',
          color: Colors.red,
          icon: Icons.warning,
          image: const AssetImage('web/assets/full bin.jpg'),
        ),
        _buildStatCard(
          context,
          title: 'Total Bins',
          value: '42',
          subtitle: 'in system',
          color: Colors.blue,
          icon: Icons.storage,
          image: const AssetImage('web/assets/images.jpg'),
        ),
        _buildStatCard(
          context,
          title: 'Optimized',
          value: '8',
          subtitle: 'routes',
          color: Colors.green,
          icon: Icons.alt_route,
          image: const AssetImage('web/assets/routes.jpg'),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required IconData icon,
    ImageProvider? image,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            if (image != null)
              Positioned(
                right: 0,
                bottom: 0,
                child:Center(
               
                  child: Image(
                    image: image,
                    width: 690,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                  
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 243, 244, 243),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 250, 249, 249),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildDataCard(
                icon: Icons.delete,
                title: 'Bins',
                onTap: () {
                  Navigator.pushNamed(context, '/bins');
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDataCard(
                icon: Icons.route,
                title: 'Routes',
                onTap: () {
                  Navigator.pushNamed(context, '/routes');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.pushNamed(context, '/map');
            },
            child: Container(
              height: 190,
             
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
                image: const DecorationImage(
                  image: AssetImage('web/assets/map view..jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Stack(
                children: [
                  Positioned(
                    bottom:10,
                    right: 10,
                    child: Chip(
                      label: Text('View Full Map'),
                      backgroundColor: Colors.green,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}