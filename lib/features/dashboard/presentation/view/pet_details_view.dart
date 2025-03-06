import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/sitter_dashboard_bloc.dart';

class PetDetailView extends StatelessWidget {
  final PetEntity product;
  final TokenSharedPrefs tokenSharedPrefs;

  const PetDetailView(
      {super.key, required this.product, required this.tokenSharedPrefs});

  Future<PetSitterEntity?> getLoggedInUser() async {
    final ownerData = await tokenSharedPrefs.getSitter();
    print("Raw owner data from SharedPreferences: $ownerData"); // Debug log
    if (ownerData != null && ownerData.isNotEmpty) {
      try {
        final user = PetSitterEntity.fromJson(ownerData);
        print("Logged-in user ID: ${user.sitterId}"); // Debug log
        return user;
      } catch (e) {
        print("Error parsing owner data: $e"); // Debug log
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Decode the base64 image if it's provided
    Uint8List? imageBytes;
    if (product.petimage != null && product.petimage!.isNotEmpty) {
      try {
        // Remove the prefix if it exists (some base64 strings may contain 'data:image/png;base64,')
        String base64String = product.petimage!;
        if (base64String.contains(',')) {
          base64String = base64String.split(',').last;
        }
        imageBytes = base64Decode(base64String);
      } catch (e) {
        print('Error decoding base64 image: $e');
      }
    }

    // Controllers for start and end dates
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.petname,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFB55C50),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display pet image (if available)
              Center(
                child: imageBytes != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(
                          imageBytes,
                          height: 350,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB55C50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.pets,
                          size: 100,
                          color: Color(0xFFB55C50),
                        ),
                      ),
              ),
              const SizedBox(height: 20),

              // Pet Name
              Text(
                product.petname,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB55C50),
                ),
              ),
              const SizedBox(height: 20),

              // Pet Type
              Text(
                'Type: ${product.type}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Pet Info
              if (product.petinfo != null && product.petinfo!.isNotEmpty)
                Text(
                  'Info: ${product.petinfo}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              const SizedBox(height: 20),

              // Open Booking and Booked Status
              Text(
                'Open for booking: ${product.openbooking}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Currently booked: ${product.booked}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Start Date Picker
              TextFormField(
                controller: startDateController,
                decoration: const InputDecoration(
                  labelText: 'Start Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    startDateController.text =
                        selectedDate.toLocal().toString().split(' ')[0];
                  }
                },
              ),
              const SizedBox(height: 16),

              // End Date Picker
              TextFormField(
                controller: endDateController,
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    endDateController.text =
                        selectedDate.toLocal().toString().split(' ')[0];
                  }
                },
              ),
              const SizedBox(height: 20),

              // Book Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final startDate = startDateController.text;
                    final endDate = endDateController.text;

                    if (startDate.isEmpty || endDate.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please select both start and end dates.'),
                        ),
                      );
                      return;
                    }

                    // Fetch the logged-in user's ID
                    final loggedInUser = await getLoggedInUser();
                    if (loggedInUser == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Unable to fetch logged-in user details.'),
                        ),
                      );
                      return;
                    }

                    // Dispatch the AddBooking event with the logged-in user's ID
                    context.read<SitterDashboardBloc>().add(
                          AddBooking(
                            '67b823498e406c60b19a9ac6',
                            '67c4730d223b79b4906c1010',
                            '67b8292edebd59a94a4972d1',
                            DateTime.parse(startDate),
                            DateTime.parse(endDate),
                            'pending', // Default status
                            DateTime.now(),
                          ),
                        );

                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Booking added successfully!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB55C50), // Theme color
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Book Now",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
}
