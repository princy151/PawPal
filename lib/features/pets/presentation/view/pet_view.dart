import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/sitter_dashboard_bloc.dart';

class AllPetsPage extends StatelessWidget {
  final TokenSharedPrefs tokenSharedPrefs;

  const AllPetsPage({super.key, required this.tokenSharedPrefs});

  Future<PetOwnerEntity?> getLoggedInUser() async {
    final ownerData = await tokenSharedPrefs.getOwner();
    print("Raw owner data from SharedPreferences: $ownerData"); // Debug log
    if (ownerData != null && ownerData.isNotEmpty) {
      try {
        final user = PetOwnerEntity.fromJson(ownerData);
        print("Logged-in user ID: ${user.ownerId}"); // Debug log
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Pets',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFB55C50), // Primary color
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showAddPetDialog(context); // Show the "Add Pet" dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<PetOwnerEntity?>(
          future: getLoggedInUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFB55C50), // Primary color
                ),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Text(
                  'Error: Unable to load user data.',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            final loggedInUser = snapshot.data!;

            return BlocBuilder<SitterDashboardBloc, SitterDashboardState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFB55C50), // Primary color
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

                // Filter pets for the logged-in user
                final userPets = state.owners
                    .firstWhere(
                      (owner) => owner.ownerId == loggedInUser.ownerId,
                      orElse: () => PetOwnerEntity(
                        ownerId: '',
                        name: '',
                        email: '',
                        phone: '',
                        address: '',
                        pets: [],
                      ),
                    )
                    .pets;

                if (userPets.isEmpty) {
                  return const Center(
                    child: Text(
                      'No pets available.',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userPets.length,
                  itemBuilder: (context, index) {
                    PetEntity pet = userPets[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120, // Fixed height for image
                            decoration: BoxDecoration(
                              color: const Color(0xFFB55C50), // Primary color
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              image: DecorationImage(
                                image: _getImageProvider(pet.petimage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.red[300], // Lightened red
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize: const Size(80, 40),
                                  ),
                                  onPressed: () {
                                    print(
                                        "details ${loggedInUser.ownerId} ${pet.petId}");
                                    _deletePet(context, loggedInUser.ownerId!,
                                        pet.petId!);
                                  },
                                  child: const Text('Delete',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 201, 189, 78), // Light yellow
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      minimumSize: const Size(80, 40),
                                    ),
                                    onPressed: () {
                                      _showEditPetDialog(
                                          context, loggedInUser.ownerId!, pet);
                                    },
                                    child: const Text('Edit',
                                        style: TextStyle(color: Colors.white))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
      return const AssetImage('assets/images/pet_placeholder.png');
    } else if (image.startsWith('data:image')) {
      return MemoryImage(base64Decode(image.split(',').last));
    } else {
      return AssetImage('assets/images/pet_placeholder.png');
    }
  }

  /// Show the "Add Pet" dialog
  /// Show the "Add Pet" dialog
  void _showAddPetDialog(BuildContext context) async {
    final loggedInUser = await getLoggedInUser();
    if (loggedInUser == null) return;

    final TextEditingController petnameController = TextEditingController();
    final TextEditingController typeController = TextEditingController();
    final TextEditingController petinfoController = TextEditingController();
    String? base64Image;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Pet'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: petnameController,
                  decoration: const InputDecoration(labelText: 'Pet Name'),
                ),
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
                TextField(
                  controller: petinfoController,
                  decoration: const InputDecoration(labelText: 'Pet Info'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      final bytes = await File(image.path).readAsBytes();
                      // Prepend the MIME type and encoding information
                      base64Image =
                          "data:image/jpeg;base64,${base64Encode(bytes)}";
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Image uploaded successfully')),
                      );
                    }
                  },
                  child: const Text('Upload Image',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (base64Image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please upload an image')),
                  );
                  return;
                }

                final newPet = {
                  "petname": petnameController.text,
                  "type": typeController.text,
                  "petimage": base64Image,
                  "petinfo": petinfoController.text,
                  "booked": "no",
                  "openbooking": "no",
                };

                try {
                  final response = await http.patch(
                    Uri.parse(
                        'http://10.0.2.2:3000/api/v1/auth/${loggedInUser.ownerId}/addPet'),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode(newPet),
                  );

                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pet added successfully')),
                    );
                    // Refresh the pet list
                    context.read<SitterDashboardBloc>().add(LoadOwners());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to add pet')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  /// Show the "Edit Pet" dialog
  void _showEditPetDialog(
      BuildContext context, String ownerId, PetEntity pet) async {
    final TextEditingController petnameController =
        TextEditingController(text: pet.petname);
    final TextEditingController typeController =
        TextEditingController(text: pet.type);
    final TextEditingController petinfoController =
        TextEditingController(text: pet.petinfo);
    String? base64Image = pet.petimage;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Pet'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: petnameController,
                  decoration: const InputDecoration(labelText: 'Pet Name'),
                ),
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
                TextField(
                  controller: petinfoController,
                  decoration: const InputDecoration(labelText: 'Pet Info'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      final bytes = await File(image.path).readAsBytes();
                      base64Image = base64Encode(bytes);
                    }
                  },
                  child: const Text('Upload Image'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedPet = {
                  "petname": petnameController.text,
                  "type": typeController.text,
                  "petimage": base64Image,
                  "petinfo": petinfoController.text,
                  "booked": "no",
                  "openbooking": "no",
                };

                try {
                  final response = await http.patch(
                    Uri.parse(
                        'http://10.0.2.2:3000/api/v1/auth/$ownerId/updatePet/${pet.petId}'),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode(updatedPet),
                  );

                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pet updated successfully')),
                    );
                    // Refresh the pet list
                    context.read<SitterDashboardBloc>().add(LoadOwners());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to update pet')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  /// Delete a pet
  void _deletePet(BuildContext context, String ownerId, String petId) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Pet'),
          content: const Text('Are you sure you want to delete this pet?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final response = await http.delete(
                    Uri.parse(
                        'http://10.0.2.2:3000/api/v1/auth/$ownerId/pets/$petId'),
                  );

                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pet deleted successfully')),
                    );
                    // Refresh the pet list
                    context.read<SitterDashboardBloc>().add(LoadOwners());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to delete pet')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
