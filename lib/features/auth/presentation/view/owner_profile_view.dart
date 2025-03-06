import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/presentation/view_model/profile/owner_profile_bloc.dart';

class OwnerProfilePage extends StatefulWidget {
  const OwnerProfilePage({super.key});

  @override
  State<OwnerProfilePage> createState() => _OwnerProfilePageState();
}

class _OwnerProfilePageState extends State<OwnerProfilePage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _img;
  Future _browseImage(ImageSource imagesource) async {
    try {
      final image = await ImagePicker().pickImage(source: imagesource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<OwnerProfileBloc>().loadClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFFB55C50),
        elevation: 0,
      ),
      body: BlocBuilder<OwnerProfileBloc, OwnerProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.owner == null) {
            return const Center(
                child: Text("No owner available",
                    style: TextStyle(color: Colors.black)));
          } else {
            final owner = state.owner!;
            _nameController.text = owner.name;
            _emailController.text = owner.email;
            _phoneController.text = owner.phone;
            _addressController.text = owner.address;

            final String? imageUrl = owner.image;
            final String baseUrl = Platform.isIOS
                ? "http://127.0.0.1:3000"
                : "http://10.0.2.2:3000";
            final String fullImageUrl = imageUrl != null && imageUrl.isNotEmpty
                ? "$baseUrl/uploads/$imageUrl"
                : '';

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey[900],
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildImagePickerButton(context, "Camera",
                                      Icons.camera, ImageSource.camera),
                                  _buildImagePickerButton(context, "Gallery",
                                      Icons.image, ImageSource.gallery),
                                ],
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _img != null
                              ? FileImage(_img!)
                              : (fullImageUrl.isNotEmpty
                                      ? NetworkImage(fullImageUrl)
                                      : const AssetImage(
                                          'assets/images/profile.png'))
                                  as ImageProvider,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField("Name", _nameController),
                      _buildTextField("Email", _emailController),
                      _buildTextField("Phone", _phoneController),
                      _buildTextField("Address", _addressController),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final updatedOwner = PetOwnerEntity(
                            ownerId: owner.ownerId,
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            address: _addressController.text,
                            image: _img?.path,
                          );
                          // Trigger the update event in the OwnerProfileBloc
                          context
                              .read<OwnerProfileBloc>()
                              .add(UpdateOwnerEvent(owner: updatedOwner));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFB55C50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          elevation: 5,
                        ),
                        child: const Text("Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 204, 204)),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 251, 251, 251),
          hintStyle: const TextStyle(color: Colors.black),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  ElevatedButton _buildImagePickerButton(
      BuildContext context, String label, IconData icon, ImageSource source) {
    return ElevatedButton.icon(
      onPressed: () {
        _browseImage(source);
        Navigator.pop(context);
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xFFB55C50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        elevation: 5,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
