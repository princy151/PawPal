import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/auth/presentation/view/registration_view.dart';
import 'package:pawpal/features/auth/presentation/view_model/login/owner_login_bloc.dart'
    as owner;
import 'package:pawpal/features/auth/presentation/view_model/login/sitter_login_bloc.dart'
    as sitter;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login",
            style:
                TextStyle(color: Colors.white, fontFamily: 'Montserrat Bold')),
        centerTitle: true,
        backgroundColor: const Color(0xFFB55C50),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Tab Bar Section
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
            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLoginForm("Pet Owner", Icons.pets),
                  _buildLoginForm("Pet Sitter", Icons.person_outline),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(String userType, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: SingleChildScrollView(
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
                    icon,
                    color: const Color(0xFFB55C50),
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "$userType Login",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB55C50),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  ElevatedButton(
                    onPressed: () {
                      if (userType == "Pet Owner") {
                        // Trigger Pet Owner login event
                        context.read<owner.OwnerLoginBloc>().add(
                              owner.LoginOwnerEvent(
                                context: context,
                                username: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      } else if (userType == "Pet Sitter") {
                        // Trigger Pet Sitter login event (different event)
                        context.read<sitter.SitterLoginBloc>().add(
                              sitter.LoginSitterEvent(
                                context: context,
                                username: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB55C50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 32,
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      if (userType == "Pet Owner") {
                        // Navigate to Pet Owner Registration Screen
                        context.read<owner.OwnerLoginBloc>().add(
                              owner.NavigateRegisterScreenEvent(
                                destination: RegistrationView(),
                                context: context,
                              ),
                            );
                      } else if (userType == "Pet Sitter") {
                        // Navigate to Pet Sitter Registration Screen (if applicable)
                        context.read<sitter.SitterLoginBloc>().add(
                              sitter.NavigateRegisterScreenEvent(
                                destination: RegistrationView(),
                                context: context,
                              ),
                            );
                      }
                    },
                    child: const Text(
                      "Don't have an account? Register",
                      style: TextStyle(color: Color(0xFFB55C50)),
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
