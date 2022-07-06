import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martizoom/presentation_layer/screens/register/register_phone_screen.dart';
import 'package:martizoom/shared/components/default_button.dart';
import 'package:martizoom/shared/components/default_text_form_field.dart';
import '../../../business_logic_layer/auth_cubit/auth_cubit.dart';
import '../../../main.dart';
import '../../../shared/constants/constants.dart';

class LoginPhoneScreen extends StatelessWidget {
  LoginPhoneScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: setHeightValue(
                portraitValue: 0.1,
                landscapeValue: 0.15,
              ),
              bottom: setHeightValue(
                portraitValue: 0.05,
                landscapeValue: 0.1,
              ),
              start: setWidthValue(
                portraitValue: 0.05,
                landscapeValue: 0.1,
              ),
              end: setWidthValue(
                portraitValue: 0.05,
                landscapeValue: 0.1,
              ),
            ),
            child: Form(
              key: _formKey,
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is LoginSuccessState) {
                    MyApp.restartApp(context);
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.fill,
                          height: 120.0,
                          width: 120.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          appLocalization!.letsSignYouIn,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          10.0,
                        ),
                        child: Text(
                          appLocalization!.welcomeBack,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(
                            40.0,
                          ),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                              child: DefaultTextFormField(
                                controller: _phoneTextEditingController,
                                type: TextInputType.phone,
                                label: appLocalization!.phone,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return appLocalization!
                                        .phoneNumberIsRequired;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: DefaultTextFormField(
                                controller: _passwordTextEditingController,
                                type: TextInputType.text,
                                isPassword: true,
                                label: appLocalization!.password,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return appLocalization!.passwordIsRequired;
                                  }
                                  if (value.isEmpty || value.contains(' ')) {
                                    return appLocalization!.passwordIsNotValid;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: BuildCondition(
                                  condition: state is LoginLoadingState,
                                  builder: (_) =>
                                      const CircularProgressIndicator(),
                                  fallback: (context) {
                                    return DefaultButton(
                                      function: () {
                                        _submit(context);
                                      },
                                      text: appLocalization!.signIn,
                                      radius: 15.0,
                                      backgroundColor: const Color(0xFFce0900),
                                    );
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    appLocalization!.dontHaveAnAccount,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14.0),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  TextButton(
                                    onPressed: state is LoginLoadingState
                                        ? null
                                        : () {
                                            navigateAndFinishTo(
                                              context: context,
                                              screen: RegisterPhoneScreen(),
                                            );
                                          },
                                    child: Text(
                                      appLocalization!.signUp,
                                      style: const TextStyle(
                                        color: Color(0xFFce0900),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(context) {
    if (!_formKey.currentState!.validate()) return;

    AuthCubit.get(context).userLogin(
      phone: _phoneTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    );
  }
}
