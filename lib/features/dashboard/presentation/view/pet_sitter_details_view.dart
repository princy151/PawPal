import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this package

class ProductDetailView extends StatelessWidget {
  final PetSitterEntity product;

  const ProductDetailView({super.key, required this.product});

  // Function to launch the phone app
  void _launchPhoneApp(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        print('Could not launch phone app for $phoneNumber');
      }
    } catch (e) {
      print('Error launching phone app: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Decode the base64 image
    Uint8List? imageBytes;
    if (product.image != null && product.image!.isNotEmpty) {
      try {
        // Remove the prefix if it exists
        String base64String = product.image!;
        if (base64String.contains(',')) {
          base64String = base64String.split(',').last;
        }
        imageBytes = base64Decode(base64String);
      } catch (e) {
        print('Error decoding base64 image: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text
          ),
        ),
        backgroundColor: const Color(0xFFB55C50), // Theme color
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.white), // White back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sitter Image
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
                          Icons.person,
                          size: 100,
                          color: Color(0xFFB55C50),
                        ),
                      ),
              ),
              const SizedBox(height: 20),

              // Sitter Name
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB55C50), // Theme color
                ),
              ),
              const SizedBox(height: 20),

              // Details Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Sitter Email
                      _buildDetailRow(Icons.email, product.email),
                      const SizedBox(height: 16),

                      // Sitter Phone
                      _buildDetailRow(Icons.phone, product.phone),
                      const SizedBox(height: 16),

                      // Sitter Address
                      _buildDetailRow(Icons.location_on, product.address),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Contact Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _launchPhoneApp(product.phone),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB55C50), // Theme color
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Contact",
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

  // Helper method to build a detail row with an icon and text
  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFFB55C50), // Theme color
          size: 24,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
