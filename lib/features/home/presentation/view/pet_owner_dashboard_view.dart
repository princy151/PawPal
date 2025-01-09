import 'package:flutter/material.dart';

class PetOwnerDashboardView extends StatefulWidget {
  const PetOwnerDashboardView({super.key});

  @override
  State<PetOwnerDashboardView> createState() => _PetOwnerDashboardViewState();
}

class _PetOwnerDashboardViewState extends State<PetOwnerDashboardView> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const DashboardContent(),
    const Center(child: Text('My Pets')),
    const Center(child: Text('Recent Sitters')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFFB55C50),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFFB55C50),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'My Pets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sitters',
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Features Section
          const SectionTitle(title: 'Features'),
          const SizedBox(height: 16),
          const FeaturesGrid(),
          const SizedBox(height: 24),

          // My Pets Section
          const SectionTitle(title: 'My Pets'),
          const SizedBox(height: 16),
          const PetCard(
              title: 'Buddy', subtitle: 'Golden Retriever', color: Colors.blue),

          const SizedBox(height: 24),

          // Recent Sitters Section
          const SectionTitle(title: 'Recent Sitters'),
          const SizedBox(height: 16),
          const SitterCard(
            name: 'John Doe',
            description: 'Experienced in dog sitting',
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          const SitterCard(
            name: 'Jane Smith',
            description: 'Cat and dog care expert',
            color: Colors.blue,
          ),

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFFB55C50),
      ),
    );
  }
}

class FeaturesGrid extends StatelessWidget {
  const FeaturesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            FeatureCard(title: 'Calendar', icon: Icons.calendar_today),
            SizedBox(width: 8),
            FeatureCard(title: 'My Pets', icon: Icons.pets),
            SizedBox(width: 8),
            Expanded(
              child: FeatureCard(
                  title: 'View Sitters',
                  icon: Icons.person_search,
                  square: false),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: FeatureCard(
                  title: 'Ongoing', icon: Icons.work, square: false),
            ),
            SizedBox(width: 8),
            FeatureCard(title: 'Messaging', icon: Icons.message),
            SizedBox(width: 8),
            FeatureCard(title: 'Notifications', icon: Icons.notifications),
          ],
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool square;

  const FeatureCard(
      {required this.title, required this.icon, this.square = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: square ? 80 : double.infinity,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFB55C50), size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const PetCard(
      {required this.title,
      required this.subtitle,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(Icons.pets, size: 40, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class SitterCard extends StatelessWidget {
  final String name;
  final String description;
  final Color color;

  const SitterCard(
      {required this.name,
      required this.description,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              radius: 40,
              child: Icon(Icons.person, size: 40, color: color),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
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
