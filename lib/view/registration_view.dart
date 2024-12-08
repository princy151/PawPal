import 'package:flutter/material.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController petNameController = TextEditingController();
  TextEditingController petTypeController = TextEditingController();
  TextEditingController petWeightController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController sitterTypeController = TextEditingController();
  TextEditingController ownerNameController =
      TextEditingController(); // New field
  TextEditingController phoneController = TextEditingController(); // New field
  TextEditingController sitterNameController =
      TextEditingController(); // New field
  TextEditingController addressController =
      TextEditingController(); // New field
  TextEditingController dobController = TextEditingController(); // New field

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFB55C50), // Reddish-brown AppBar color
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: const Color(0xFFFFD8D3), // Light reddish color
                  borderRadius: BorderRadius.circular(25),
                ),
                labelColor: Colors.black, // Dark text color for selected tab
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: Colors.black54,
                tabs: const [
                  Tab(text: "Pet Owner"),
                  Tab(text: "Pet Sitter"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildRegistrationForm("Pet Owner"),
                  _buildRegistrationForm("Pet Sitter"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationForm(String userType) {
    bool isPetOwner = userType == "Pet Owner";
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPetOwner ? Icons.pets : Icons.person_outline,
                    color: const Color(0xFFB55C50),
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "$userType Registration",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB55C50),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Owner's Name field (for Pet Owner only)
                  if (isPetOwner) ...[
                    TextField(
                      controller: ownerNameController,
                      decoration: InputDecoration(
                        labelText: "Owner's Name",
                        labelStyle: const TextStyle(color: Colors.black45),
                        prefixIcon:
                            const Icon(Icons.person, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Sitter's Name field (for Pet Sitter only)
                  if (!isPetOwner) ...[
                    TextField(
                      controller: sitterNameController,
                      decoration: InputDecoration(
                        labelText: "Sitter's Name",
                        labelStyle: const TextStyle(color: Colors.black45),
                        prefixIcon:
                            const Icon(Icons.person, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.black45),
                      prefixIcon:
                          const Icon(Icons.email, color: Color(0xFFB55C50)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.black45),
                      prefixIcon:
                          const Icon(Icons.lock, color: Color(0xFFB55C50)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // Additional fields for Pet Owner
                  if (isPetOwner) ...[
                    TextField(
                      controller: petNameController,
                      decoration: InputDecoration(
                        labelText: "Pet Name",
                        labelStyle: const TextStyle(color: Colors.black45),
                        prefixIcon:
                            const Icon(Icons.pets, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: petTypeController,
                      decoration: InputDecoration(
                        labelText: "Pet Type",
                        labelStyle: const TextStyle(color: Colors.black45),
                        prefixIcon:
                            const Icon(Icons.pets, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: petWeightController,
                      decoration: InputDecoration(
                        labelText: "Pet Weight (kg)",
                        labelStyle: const TextStyle(color: Colors.black45),
                        prefixIcon:
                            const Icon(Icons.scale, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ] else ...[
                    // Experience and Sitter Type for Pet Sitter
                    TextField(
                      controller: experienceController,
                      decoration: InputDecoration(
                        labelText: "Experience",
                        labelStyle: const TextStyle(color: Colors.black45),
                        prefixIcon:
                            const Icon(Icons.star, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: sitterTypeController,
                      decoration: InputDecoration(
                        labelText: "Sitter Type (e.g., Full-time)",
                        labelStyle: const TextStyle(color: Colors.black45),
                        prefixIcon:
                            const Icon(Icons.people, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  // Address field (for both Owner and Sitter)
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: const TextStyle(color: Colors.black45),
                      prefixIcon: const Icon(Icons.location_on,
                          color: Color(0xFFB55C50)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Date of Birth field (for both Owner and Sitter)
                  TextField(
                    controller: dobController,
                    decoration: InputDecoration(
                      labelText: "Date of Birth",
                      labelStyle: const TextStyle(color: Colors.black45),
                      prefixIcon: const Icon(Icons.calendar_today,
                          color: Color(0xFFB55C50)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle registration logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFB55C50), // Updated parameter
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(
                        color: Color(0xFFB55C50),
                        fontWeight: FontWeight.bold,
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
}
