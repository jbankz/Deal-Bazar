import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:deal_bazaar/UI/Screens/SignUp_SignIn_Screens/sign_up_viewmodel.dart';
import 'package:deal_bazaar/UI/shared/button.dart';
import 'package:deal_bazaar/UI/shared/textview.dart';
import 'package:deal_bazaar/marka_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/utils/validators.dart';
import '../../shared/custom_textview.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _phonController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _address2Controller = TextEditingController();

  final TextEditingController _zipCodeController = TextEditingController();

  final TextEditingController _faceIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SignUpViewModel>();
    return Scaffold(
      backgroundColor: yellowColor,
      appBar: AppBar(
        backgroundColor: yellowColor,
        iconTheme: IconThemeData(color: Colors.black),
        title: TextView(
          text: 'Sign up',
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        elevation: .0,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView(
            children: [
              SizedBox(height: 16.h),
              CustomTextFieldWithLeadingIcon(
                obsecure: false,
                controller: _fullNameController,
                validatorFunction: Validators.validateString(
                    error: 'Please enter your full name'),
                hint: 'Full Name',
                leadingIcon: Icons.person,
                bcColor: whiteColor,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.h),
              CustomTextFieldWithLeadingIcon(
                obsecure: false,
                controller: _phonController,
                validatorFunction: Validators.validatePhone(
                    error: 'Please enter your phone number'),
                hint: 'Phone Number',
                leadingIcon: Icons.phone_android_sharp,
                bcColor: whiteColor,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              CustomTextFieldWithLeadingIcon(
                obsecure: false,
                controller: _emailController,
                validatorFunction: Validators.validateEmail(
                    error: 'Please enter your email address'),
                hint: 'Email',
                leadingIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                bcColor: whiteColor,
              ),
              SizedBox(height: 16.h),
              CustomTextFieldWithLeadingIcon(
                obsecure: false,
                controller: _addressController,
                validatorFunction: Validators.validateString(
                    error: 'Please enter your address'),
                hint: 'Address',
                leadingIcon: Icons.location_on,
                bcColor: whiteColor,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.h),
              CustomTextFieldWithLeadingIcon(
                obsecure: false,
                controller: _address2Controller,
                hint: 'Address 2 (Optional)',
                leadingIcon: Icons.location_on,
                bcColor: whiteColor,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.h),
              CustomTextFieldWithLeadingIcon(
                obsecure: false,
                controller: _zipCodeController,
                validatorFunction: Validators.validateString(
                    error: 'Please enter your zipcode'),
                hint: 'Zip Code',
                leadingIcon: Icons.maps_home_work_outlined,
                bcColor: whiteColor,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.h),
              CustomTextFieldWithLeadingIcon(
                obsecure: true,
                controller: _passwordController,
                validatorFunction: Validators.validatePlainPass(
                    error: 'Please choose your password'),
                hint: 'Password',
                leadingIcon: Icons.lock,
                bcColor: whiteColor,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.h),
              CustomTextFieldWithLeadingIcon(
                obsecure: true,
                controller: _faceIdController,
                hint: 'FaceID (Optional)',
                leadingIcon: Icons.face_unlock_outlined,
                bcColor: whiteColor,
              ),
              SizedBox(height: 20.h),
              ButtonWidget(
                btnText: 'Sign Up',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    vm.setFinalData(
                        fullName: _fullNameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        addressLine: _addressController.text,
                        phoneNumber: _phonController.text,
                        zipCode: _zipCodeController.text,
                        addressLine2: _address2Controller.text,
                        faceId: _faceIdController.text);
                  }
                },
                isLoading: vm.loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
