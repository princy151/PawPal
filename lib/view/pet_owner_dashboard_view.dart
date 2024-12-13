import 'package:flutter/material.dart';

class PetOwnerDashboardView extends StatelessWidget {
  const PetOwnerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFFB55C50), // Custom pet theme color
        actions: [
          // Logout Icon in AppBar
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Features Section
              const Text(
                'Features',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB55C50),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      _buildFeatureCard(
                          'Calendar', Icons.calendar_today, Colors.blue,
                          square: true),
                      const SizedBox(width: 8),
                      _buildFeatureCard('My Pets', Icons.pets, Colors.green,
                          square: true),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildFeatureCard(
                            'View Sitters', Icons.person_search, Colors.orange,
                            square: false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeatureCard(
                            'Ongoing', Icons.work, Colors.purple,
                            square: false),
                      ),
                      const SizedBox(width: 8),
                      _buildFeatureCard('Messaging', Icons.message, Colors.red,
                          square: true),
                      const SizedBox(width: 8),
                      _buildFeatureCard(
                          'Notifications', Icons.notifications, Colors.yellow,
                          square: true),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // My Pets Section
              const Text(
                'My Pets',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB55C50),
                ),
              ),
              const SizedBox(height: 16),
              _buildCard('Buddy', 'Golden Retriever', Icons.pets, Colors.blue),

              const SizedBox(height: 24),

              // Recent Sitters Section
              const Text(
                'Recent Sitters',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB55C50),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  _buildSitterCard('John Doe', 'Experienced in dog sitting',
                      Icons.person, Colors.blue),
                  const SizedBox(height: 16),
                  _buildSitterCard('Jane Smith', 'Cat and dog care expert',
                      Icons.person, Colors.blue),
                ],
              ),

              // Logout Button at Bottom
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Feature Card Widget
  Widget _buildFeatureCard(String title, IconData icon, Color color,
      {bool square = true}) {
    return Container(
      width: square ? 80 : double.infinity,
      height: square ? 80 : 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // My Pets Card Widget
  Widget _buildCard(String title, String subtitle, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }

  // Recent Sitters Card Widget
  Widget _buildSitterCard(
      String name, String description, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:
                  color.withOpacity(0.2), // Light background for the icon
              radius: 40,
              child: Icon(
                icon,
                size: 40,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(description),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
