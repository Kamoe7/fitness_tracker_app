import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:fitness_tracker/common_widget/round_textfield.dart';
import 'package:fitness_tracker/view/login/what_your_goal_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/color_extension.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final _weight = TextEditingController();
  final _height = TextEditingController();
  final _dob = TextEditingController(); // Added for Date of Birth

  String? selectedGender; // Move outside of build()
  final user = Supabase.instance.client.auth.currentUser;

  // Function to save user profile
  void registerToUser() async {
    final weight = _weight.text;
    final height = _height.text;
    final dob = _dob.text;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No user is logged in")),
      );
      return;
    }

    try {
      await Supabase.instance.client.from('users').insert({
        'id': user?.id, // Associate with logged-in user
        'height':double.parse(height),
        'weight': double.parse(weight),
        'birth_date': dob,
        'gender': selectedGender,
        'created_at': DateTime.now().toIso8601String(),
      });



      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WhatYourGoalView()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset('assets/img/0_1.png', width: media.width, fit: BoxFit.fitWidth),
                SizedBox(height: media.width * 0.05),
                const Text("Let's complete your profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(
                  "It will help us to know more about you!",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: TColor.gray),
                ),
                SizedBox(height: media.width * 0.05),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Gender Dropdown
                      Container(
                        decoration: BoxDecoration(color: TColor.lightGray, borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Image.asset(
                                "assets/img/Profile.png",
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                                color: TColor.gray,
                              ),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedGender,
                                  items: ["Male", "Female"]
                                      .map((name) => DropdownMenuItem(
                                    value: name,
                                    child: Text(name, style:  TextStyle(color: TColor.gray, fontSize: 14)),
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                  isExpanded: true,
                                  hint:  Text(
                                    "Choose Gender",
                                    style: TextStyle(color: TColor.gray, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: media.width * 0.05),

                      // Date of Birth Input
                      RoundTextfield(
                        controller: _dob,
                        hintText: "Date of Birth",
                        icon: "assets/img/Calendar.png",
                      ),
                      SizedBox(height: media.width * 0.05),

                      // Weight Input
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextfield(
                              controller: _weight,
                              hintText: "Your Weight",
                              icon: "assets/img/weight.png",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: TColor.secondaryG),
                            ),
                            child:  Text("KG", style: TextStyle(fontSize: 15, color: TColor.white)),
                          ),
                        ],
                      ),
                      SizedBox(height: media.width * 0.05),

                      // Height Input
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextfield(
                              controller: _height,
                              hintText: "Your Height",
                              icon: "assets/img/Swap.png",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: TColor.secondaryG),
                            ),
                            child: Text("CM", style: TextStyle(fontSize: 15, color: TColor.white)),
                          ),
                        ],
                      ),
                      SizedBox(height: media.width * 0.07),

                      // Submit Button
                      RoundGradientButton(title: "Next >", onPressed: registerToUser),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
