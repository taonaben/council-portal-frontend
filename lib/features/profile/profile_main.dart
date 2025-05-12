import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/components/widgets/custom_textfield.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/enums.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/auth/model/user_model.dart';
import 'package:portal/features/auth/services/user_services.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

class ProfileMain extends StatefulWidget {
  final User user;
  const ProfileMain({super.key, required this.user});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  bool editMode = false;
  bool isLoading = false;
  late User currentUser;

  bool oldVisible = false;
  bool newVisible = false;
  bool confirmVisible = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CustomPassStrength? passwordStrength;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
    usernameController = TextEditingController(text: currentUser.username);
    phoneNumberController =
        TextEditingController(text: currentUser.phone_number);
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    passwordStrength = CustomPassStrength.calculate(text: value);

    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }

    switch (passwordStrength) {
      case CustomPassStrength.weak:
        return "Password is too weak";
      case CustomPassStrength.medium:
        return null;
      case CustomPassStrength.strong:
      case CustomPassStrength.secure:
        return null;
      default:
        return "Invalid password";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background1,
      ),
      body: Column(
        children: [
          CupertinoListSection.insetGrouped(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Profile",
                  textAlign: TextAlign.start,
                ),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (editMode) {
                            updateUser();
                          } else {
                            setState(() => editMode = !editMode);
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(editMode ? "Save" : "Edit"),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: background2,
              borderRadius: BorderRadius.circular(uniBorderRadius),
            ),
            backgroundColor: background1,
            separatorColor: textColor2,
            children: [
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.person, color: textColor1),
                title: editMode
                    ? CustomTextfield(
                        labelText: "Username", controller: usernameController)
                    : Text(currentUser.username,
                        style: const TextStyle(color: textColor1)),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.person_2, color: textColor1),
                title: Text(
                    "${currentUser.first_name} ${currentUser.last_name}",
                    style: const TextStyle(color: textColor1)),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.mail, color: textColor1),
                title: Text(currentUser.email,
                    style: const TextStyle(color: textColor1)),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.phone, color: textColor1),
                title: editMode
                    ? CustomTextfield(
                        labelText: "Phone Number",
                        controller: phoneNumberController)
                    : Text(currentUser.phone_number,
                        style: const TextStyle(color: textColor1)),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: CupertinoListSection.insetGrouped(
              header: const Text(
                "Change Password",
                textAlign: TextAlign.start,
              ),
              decoration: BoxDecoration(
                color: background2,
                borderRadius: BorderRadius.circular(uniBorderRadius),
              ),
              backgroundColor: background1,
              separatorColor: textColor2,
              children: [
                CupertinoListTile(
                  title: CustomTextfield(
                    labelText: "Old Password",
                    controller: oldPasswordController,
                    obscureText: !oldVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your old password";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        oldVisible
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                        color: textColor1,
                      ),
                      onPressed: () {
                        setState(() {
                          oldVisible = !oldVisible;
                        });
                      },
                    ),
                  ),
                ),
                CupertinoListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextfield(
                        labelText: "New Password",
                        controller: newPasswordController,
                        obscureText: !newVisible,
                        onChanged: (value) {
                          setState(() {
                            validatePassword(value);
                          });
                        },
                        validator: validatePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            newVisible
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: textColor1,
                          ),
                          onPressed: () =>
                              setState(() => newVisible = !newVisible),
                        ),
                      ),
                      if (passwordStrength != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: LinearProgressIndicator(
                            value: passwordStrength!.widthPerc,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              passwordStrength!.statusColor,
                            ),
                          ),
                        ),
                      if (passwordStrength != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: passwordStrength!.statusWidget,
                        ),
                    ],
                  ),
                ),
                CupertinoListTile(
                  title: CustomTextfield(
                    labelText: "Confirm Password",
                    controller: confirmPasswordController,
                    obscureText: !confirmVisible,
                    validator: (value) {
                      if (value != newPasswordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        confirmVisible
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                        color: textColor1,
                      ),
                      onPressed: () {
                        setState(() {
                          confirmVisible = !confirmVisible;
                        });
                      },
                    ),
                  ),
                ),
                CupertinoListTile(
                  title: TextButton(
                      onPressed: () => updateUser(),
                      child: const Text(
                        "Change Password",
                        style: TextStyle(color: primaryColor),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> getChangedData() {
    Map<String, dynamic> data = {};
    if (usernameController.text != currentUser.username) {
      data["username"] = usernameController.text;
    }
    if (phoneNumberController.text != currentUser.phone_number) {
      data["phone_number"] = phoneNumberController.text;
    }
    if (oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (newPasswordController.text != confirmPasswordController.text) {
        const CustomSnackbar(message: "Passwords do not match", color: redColor)
            .showSnackBar(context);
        return data;
      }
      data["password"] = confirmPasswordController.text;
    }

    return data;
  }

  void updateUser() async {
    if (!_formKey.currentState!.validate()) return;

    Map<String, dynamic> data = getChangedData();
    if (data.isEmpty) {
      const CustomSnackbar(message: "No changes detected", color: redColor)
          .showSnackBar(context);
      return;
    }

    setState(() => isLoading = true);

    try {
      final userServices = UserService();
      DevLogs.logInfo("Updating user with data: $data");
      DevLogs.logInfo("Current user ID: ${currentUser.id}");
      bool result = await userServices.updateUser(currentUser.id!, data);

      if (result) {
        // Get updated user data
        final updatedUser = await userServices.getUserById(currentUser.id!);
        setState(() {
          currentUser = updatedUser;
          editMode = false;
          isLoading = false;
        });

        const CustomSnackbar(
                message: "Profile updated successfully", color: primaryColor)
            .showSnackBar(context);
      } else {
        throw Exception("Failed to update profile");
      }
    } catch (e) {
      setState(() => isLoading = false);
      CustomSnackbar(message: "Error updating profile: $e", color: redColor)
          .showSnackBar(context);
    }
  }
}
