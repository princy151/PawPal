import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/dashboard/presentation/view/pet_details_view.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/sitter_dashboard_bloc.dart';

class PetSitterDashboardView extends StatelessWidget {
  const PetSitterDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pets Available for Sitter',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor:
            const Color(0xFFA7522A), // Updated color from PetOwnerDashboard
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SitterDashboardBloc, SitterDashboardState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color:
                      Color(0xFFA7522A), // Updated color from PetOwnerDashboard
                ),
              );
            }

            if (state.error != null) {
              return Center(
                child: Text(
                  'Error: ${state.error}',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            if (state.owners.isEmpty) {
              return const Center(
                child: Text(
                  'No pets available.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              );
            }

            // Extract pets from all owners
            List<PetEntity> pets =
                state.owners.expand((owner) => owner.pets).toList();

            if (pets.isEmpty) {
              return const Center(
                child: Text(
                  'No pets available.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap:
                  true, // Ensures GridView takes up only the necessary space
              physics:
                  NeverScrollableScrollPhysics(), // Prevents GridView from scrolling independently
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in grid
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75, // Aspect ratio of each card
              ),
              itemCount: pets.length,
              itemBuilder: (context, index) {
                PetEntity pet = pets[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          width:
                              double.infinity, // Ensure it takes up full width
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFFA7522A), // Updated color from PetOwnerDashboard
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(12)),
                            image: DecorationImage(
                              image: _getImageProvider(pet.petimage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pet.petname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  pet.type,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double
                              .infinity, // Ensures the button takes the full width
                          height: 45, // Fixed height for button
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xFFA7522A), // Updated color from PetOwnerDashboard
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              // Navigate to PetDetailView, passing the selected pet directly
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (context) =>
                                        getIt<SitterDashboardBloc>(),
                                    child: PetDetailView(
                                      product: pet,
                                      tokenSharedPrefs:
                                          getIt<TokenSharedPrefs>(),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'View Details',
                              style: TextStyle(
                                  color: Colors
                                      .white), // Button text color to white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// Get the image provider based on the image type (Base64, URL, or asset).
  ImageProvider _getImageProvider(String? image) {
    if (image == null) {
      // Return a placeholder image if no image is available.
      return const AssetImage('assets/images/pet_placeholder.png');
    } else if (image.startsWith('data:image')) {
      // If image is Base64 encoded, decode it and show as MemoryImage
      return MemoryImage(base64Decode(image.split(',').last));
    } else if (Uri.tryParse(image)?.isAbsolute ?? false) {
      // If the image is a URL, use NetworkImage
      return NetworkImage(image);
    } else if (File(image).existsSync()) {
      // If the image is a file path, use FileImage
      return FileImage(File(image));
    } else {
      // If image is a local asset path, use AssetImage
      return AssetImage(image);
    }
  }
}
