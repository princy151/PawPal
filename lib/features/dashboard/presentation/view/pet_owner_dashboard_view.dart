import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';
import 'package:pawpal/features/dashboard/presentation/view/pet_sitter_details_view.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/owner_dashboard_bloc.dart';

class OwnerDashboardPage extends StatelessWidget {
  const OwnerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pet Sitters',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFB55C50),
      ),
      body: BlocBuilder<OwnerDashboardBloc, OwnerDashboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFB55C50),
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

          if (state.sitters.isEmpty) {
            return const Center(
              child: Text(
                'No sitters available.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in grid
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75, // Aspect ratio of each card
            ),
            itemCount: state.sitters.length,
            itemBuilder: (context, index) {
              PetSitterEntity sitter = state.sitters[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120, // Fixed height for image
                      decoration: BoxDecoration(
                        color: const Color(0xFFB55C50),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                        image: DecorationImage(
                          image: _getImageProvider(sitter.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        sitter.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        sitter.email,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB55C50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailView(product: sitter),
                            ),
                          );
                        },
                        child: const Text('View Details'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Get the image provider based on the image type (Base64, URL, or asset).
  ImageProvider _getImageProvider(String? image) {
    if (image == null) {
      // Return a placeholder image if no image is available.
      return const AssetImage('assets/images/sitter_placeholder.png');
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
