import 'package:flutter/material.dart';
import 'package:practicing_mvvm_architecture/res/components/round_button.dart';
import 'package:practicing_mvvm_architecture/utils/routes/routes_name.dart';
import 'package:practicing_mvvm_architecture/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("LogIn"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email",
                labelText: "Email",
                prefixIcon: Icon(Icons.alternate_email_outlined),
              ),
              onFieldSubmitted: (value){
                Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: (context, value, child){
                  return TextFormField(
                    controller: _passwordController,
                    focusNode: passwordFocusNode,
                    obscureText: _obscurePassword.value,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: "Password",
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: InkWell(
                        onTap: (){
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                          child: Icon(_obscurePassword.value ? Icons.visibility_off_outlined: Icons.visibility)
                      ),
                    ),
                  );
                }
            ),
            SizedBox(height: height * .085,),
            RoundButton(
                title: "LogIn",
                loading: authViewModel.loading,
                onPress: (){
                  if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessages("Please enter Email", context);
                  }
                  else if(_passwordController.text.isEmpty){
                    Utils.flushBarErrorMessages("Please enter Password", context);
                  }
                  else if(_passwordController.text.length < 6){
                    Utils.flushBarErrorMessages("Please enter 6 digit Password ", context);
                  }
                  else{
                    Map data = {
                      'email' : _emailController.text.toString(),
                      'password' : _passwordController.text.toString()
                    };

                    authViewModel.loginApi(data, context);
                    print("Api hit");
                  }
                }
            ),
            SizedBox(height: height * .02,),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.signup);
              },
                child: Text("Don't have an account? Sign Up")
            ),

          ],
        ),
      )
    );
  }
}
