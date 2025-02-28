import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawpal/core/common/my_snackbar.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/presentation/view_model/signup/owner_signup_bloc.dart'
    as owner;
import 'package:pawpal/features/auth/presentation/view_model/signup/sitter_signup_bloc.dart'
    as sitter;
import 'package:permission_handler/permission_handler.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

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
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sitterNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  bool isPetAdded = false; // Flag to track if pet form is expanded

  File? _profileImg;
  File? _petImg; // New image for pet

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future _browseImage(ImageSource imageSource, bool isProfile) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          if (isProfile) {
            _profileImg = File(image.path);
            // Send profile image to server
            context
                .read<owner.OwnerSignupBloc>()
                .add(owner.LoadImage(file: _profileImg!));
          } else {
            _petImg = File(image.path); // Set pet image
            context
                .read<owner.OwnerSignupBloc>()
                .add(owner.LoadPetImage(file: _petImg!));
          }
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
        backgroundColor: const Color(0xFFB55C50),
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
                  color: const Color(0xFFFFD8D3),
                  borderRadius: BorderRadius.circular(25),
                ),
                labelColor: Colors.black,
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
    final formKey = GlobalKey<FormState>();
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Profile Image Picker
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.black,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ImageSource.camera, true);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.camera,
                                      color: Colors.white),
                                  label: const Text(
                                    'Camera',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor:
                                        Colors.white.withOpacity(0.38),
                                    disabledBackgroundColor:
                                        Colors.white.withOpacity(0.12),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _browseImage(ImageSource.gallery, true);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.image,
                                      color: Colors.white),
                                  label: const Text(
                                    'Gallery',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor:
                                        Colors.white.withOpacity(0.38),
                                    disabledBackgroundColor:
                                        Colors.white.withOpacity(0.12),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _profileImg != null
                              ? FileImage(_profileImg!)
                              : const AssetImage('assets/images/profile.jpg')
                                  as ImageProvider,
                        ),
                      ),
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
                    // Name Field
                    if (isPetOwner)
                      TextFormField(
                        controller: ownerNameController,
                        decoration: InputDecoration(
                          labelText: "Owner's Name",
                          prefixIcon: const Icon(Icons.person,
                              color: Color(0xFFB55C50)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Owner's name is required"
                            : null,
                      )
                    else
                      TextFormField(
                        controller: sitterNameController,
                        decoration: InputDecoration(
                          labelText: "Sitter's Name",
                          prefixIcon: const Icon(Icons.person,
                              color: Color(0xFFB55C50)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Sitter's name is required"
                            : null,
                      ),
                    const SizedBox(height: 16),
                    // Email Field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(r"^[^@]+@[^@]+\.[^@]+$").hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Password is required"
                          : null,
                    ),
                    const SizedBox(height: 20),
                    // Phone Number Field (for both Pet Owner and Pet Sitter)
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon:
                            const Icon(Icons.phone, color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.isEmpty
                          ? "Phone number is required"
                          : null,
                    ),
                    const SizedBox(height: 16),
                    // Address Field
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: "Address",
                        prefixIcon: const Icon(Icons.location_on,
                            color: Color(0xFFB55C50)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Address is required"
                          : null,
                    ),
                    const SizedBox(height: 16),
                    // Pet Owner Specific Fields
                    if (isPetOwner) ...[
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isPetAdded = !isPetAdded;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB55C50),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          isPetAdded ? "Remove Pet" : "Add Pet",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (isPetAdded) ...[
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: petNameController,
                          decoration: InputDecoration(
                            labelText: "Pet's Name",
                            prefixIcon: const Icon(Icons.pets,
                                color: Color(0xFFB55C50)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Pet's name is required"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: petTypeController,
                          decoration: InputDecoration(
                            labelText: "Pet Type",
                            prefixIcon: const Icon(Icons.pets,
                                color: Color(0xFFB55C50)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Pet type is required"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.black,
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
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        checkCameraPermission();
                                        _browseImage(ImageSource.camera, false);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.camera,
                                          color: Colors.white),
                                      label: const Text(
                                        'Camera',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        disabledForegroundColor:
                                            Colors.white.withOpacity(0.38),
                                        disabledBackgroundColor:
                                            Colors.white.withOpacity(0.12),
                                        side: const BorderSide(
                                            color: Colors.white),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _browseImage(
                                            ImageSource.gallery, false);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.image,
                                          color: Colors.white),
                                      label: const Text(
                                        'Gallery',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        disabledForegroundColor:
                                            Colors.white.withOpacity(0.38),
                                        disabledBackgroundColor:
                                            Colors.white.withOpacity(0.12),
                                        side: const BorderSide(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _petImg != null
                                  ? FileImage(_petImg!)
                                  : const AssetImage(
                                          'assets/images/profile.jpg')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: petWeightController,
                          decoration: InputDecoration(
                            labelText: "Pet's Info",
                            prefixIcon: const Icon(Icons.info_outline,
                                color: Color(0xFFB55C50)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Pet info is required"
                              : null,
                        ),
                      ],
                    ],
                    const SizedBox(height: 20),
                    // Register Button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final registerState =
                              context.read<owner.OwnerSignupBloc>().state;

                          if (isPetOwner) {
                            // Handle Pet Owner registration
                            if (isPetAdded && registerState.petImage == null) {
                              showMySnackBar(
                                context: context,
                                message:
                                    "Please upload a pet image before registering.",
                              );
                              return;
                            }
                            final imageName = registerState.imageName;
                            final petImage = registerState.petImage;
                            context.read<owner.OwnerSignupBloc>().add(
                                  owner.RegisterOwner(
                                    context: context,
                                    name: ownerNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    address: addressController.text,
                                    phone: phoneController.text,
                                    image: imageName,
                                    pets: [
                                      PetEntity(
                                        petname: petNameController.text,
                                        type: petTypeController.text,
                                        petimage: petImage,
                                        petinfo: petWeightController.text,
                                        openbooking: 'no',
                                        booked: 'no',
                                      ),
                                    ],
                                  ),
                                );
                          } else {
                            // Handle Pet Sitter registration
                            final imageName = registerState.imageName;
                            context.read<sitter.SitterSignupBloc>().add(
                                  sitter.RegisterSitter(
                                    context: context,
                                    name: sitterNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    address: addressController.text,
                                    phone: phoneController.text,
                                    image: imageName,
                                  ),
                                );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB55C50),
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
                    // Login Button
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
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
      ),
    );
  }
}
