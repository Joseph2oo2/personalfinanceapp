import 'package:flutter/material.dart';
import 'package:personalfinanceapp/models/user_model.dart';
import 'package:personalfinanceapp/services/auth_service.dart';
import 'package:personalfinanceapp/widgets/apptext.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../widgets/appbutton.dart';
import '../widgets/customtextformfiled.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final _registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Form(
            key: _registerKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        data: "Create an Account",
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is Mandatory";
                            }
                            return null;
                          },
                          controller: _emailController,
                          hintText: "Email"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is Mandatory";
                            }
                            if (value.length < 6) {
                              return "Password should be greater than 6 characters";
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: _passwordController,
                          hintText: "Password"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is Mandatory";
                            }
                            return null;
                          },
                          controller: _nameController,
                          hintText: "Name"),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone is Mandatory";
                            }
                            return null;
                          },
                          controller: _phoneController,
                          hintText: "Phone"),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: AppButton(
                            height: 52,
                            width: 250,
                            color: Colors.deepOrange,
                            onTap: () async{
                              var uuid=Uuid().v1();
                              if (_registerKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                     return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });

                                UserModel user=UserModel(
                                    id:uuid,
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    name: _nameController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                    status: 1);

                                final reg=await authService.registerUser(user);
                                Navigator.pop(context);
                                if(reg==true){
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: AppText(
                              data: "Register",
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            data: "Already have an Account?",
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: AppText(
                                data: "Login",
                                color: Colors.white,
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
