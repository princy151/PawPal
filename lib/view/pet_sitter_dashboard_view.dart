import 'package:flutter/material.dart';

class PetSitterDashboardView extends StatelessWidget {
  const PetSitterDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Sitter Dashboard'),
        backgroundColor: const Color(0xFF6C4F3D), // Brownish pet theme color
        actions: [
          // Logout Button in AppBar
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
              // Dashboard Greeting
              const Text(
                'Welcome, Pet Sitter!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C4F3D),
                ),
              ),
              const SizedBox(height: 16),

              // Quick Actions Section
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickActionCard(
                      'My Schedule', Icons.calendar_today, Colors.blue),
                  _buildQuickActionCard(
                      'Messages', Icons.message, Colors.green),
                  _buildQuickActionCard(
                      'Completed Tasks', Icons.check_circle, Colors.orange),
                ],
              ),
              const SizedBox(height: 24),

              // Upcoming Appointments Section
              const Text(
                'Upcoming Appointments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _buildAppointmentCard(
                  'Buddy the Golden Retriever', '12 Aug, 10:00 AM'),
              _buildAppointmentCard('Mittens the Cat', '12 Aug, 3:00 PM'),
              _buildAppointmentCard('Charlie the Beagle', '13 Aug, 11:00 AM'),
              const SizedBox(height: 24),

              // Completed Tasks Section
              const Text(
                'Completed Tasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _buildCompletedTaskCard(
                  'Walked Buddy for 30 mins', '11 Aug, 4:00 PM'),
              _buildCompletedTaskCard(
                  'Fed Mittens her lunch', '11 Aug, 1:00 PM'),

              // Logout Button at the Bottom
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

  // Quick Action Card Widget
  Widget _buildQuickActionCard(String title, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Appointment Card Widget
  Widget _buildAppointmentCard(String petName, String dateTime) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.pets, size: 36, color: Colors.blue),
        title:
            Text(petName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(dateTime),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  // Completed Task Card Widget
  Widget _buildCompletedTaskCard(String task, String dateTime) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.check_circle, size: 36, color: Colors.green),
        title: Text(task, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(dateTime),
      ),
    );
  }
}
