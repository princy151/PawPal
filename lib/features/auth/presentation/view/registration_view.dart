import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawpal/features/auth/presentation/view_model/owner_signup/owner_signup_bloc.dart';
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

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          //Send image to server
          context.read<OwnerSignupBloc>().add(
                LoadImage(file: _img!),
              );
        });
      } else {
        return;
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
                                    _browseImage(ImageSource.camera);
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
                                    _browseImage(ImageSource.gallery);
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
                          backgroundImage: _img != null
                              ? FileImage(_img!)
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
                    if (isPetOwner) ...[
                      TextFormField(
                        controller: petNameController,
                        decoration: InputDecoration(
                          labelText: "Pet Name",
                          prefixIcon:
                              const Icon(Icons.pets, color: Color(0xFFB55C50)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Pet name is required"
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: petTypeController,
                        decoration: InputDecoration(
                          labelText: "Pet Type",
                          prefixIcon:
                              const Icon(Icons.pets, color: Color(0xFFB55C50)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Pet type is required"
                            : null,
                      ),
                      const SizedBox(height: 16),
                      // TextFormField(
                      //   controller: petWeightController,
                      //   decoration: InputDecoration(
                      //     labelText: "Pet Weight (kg)",
                      //     prefixIcon:
                      //         const Icon(Icons.scale, color: Color(0xFFB55C50)),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.number,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Pet weight is required";
                      //     }
                      //     if (double.tryParse(value) == null) {
                      //       return "Enter a valid number";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // const SizedBox(height: 16),
                    ],
                    if (!isPetOwner) ...[
                      TextFormField(
                        controller: experienceController,
                        decoration: InputDecoration(
                          labelText: "Experience",
                          prefixIcon:
                              const Icon(Icons.star, color: Color(0xFFB55C50)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Experience is required"
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: sitterTypeController,
                        decoration: InputDecoration(
                          labelText: "Sitter Type (e.g., Full-time)",
                          prefixIcon: const Icon(Icons.people,
                              color: Color(0xFFB55C50)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Sitter type is required"
                            : null,
                      ),
                    ],
                    const SizedBox(height: 16),
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
                    // const SizedBox(height: 16),
                    // TextFormField(
                    //   controller: dobController,
                    //   decoration: InputDecoration(
                    //     labelText: "Date of Birth",
                    //     prefixIcon: const Icon(Icons.calendar_today,
                    //         color: Color(0xFFB55C50)),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    //   keyboardType: TextInputType.datetime,
                    //   validator: (value) => value == null || value.isEmpty
                    //       ? "Date of birth is required"
                    //       : null,
                    // ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final registerState =
                              context.read<OwnerSignupBloc>().state;
                          final imageName = registerState.imageName;
                          context.read<OwnerSignupBloc>().add(
                                RegisterOwner(
                                  context: context,
                                  name: ownerNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  petname: petNameController.text,
                                  type: petTypeController.text,
                                  address: addressController.text,
                                  image: imageName,
                                ),
                              );
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
      ),
    );
  }
}
