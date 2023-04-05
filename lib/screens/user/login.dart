import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/custom_textfield.dart';
import 'package:virtual_store/components/hidden_keyboard.dart';
import 'package:virtual_store/components/logo_animated.dart';
import 'package:virtual_store/components/snackbar.dart';
import 'package:virtual_store/components/spacers.dart';
import 'package:virtual_store/components/title_sigin_signup.dart';
import 'package:virtual_store/models/user_account.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:virtual_store/utils/constants.dart';
import 'package:virtual_store/utils/validations/validator_form_fields.dart';

class Login extends StatelessWidget with ValidationsFormFields {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final size = getScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: InkWell(
          onTap: hiddenKeyboard,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TitleSignInSignUp(
                        text: 'Sign In',
                      ),
                      Column(
                        children: [
                          logoAnimated(),
                          CustomTextFieldRounded(
                            validator: (value) => validators(
                              [
                                () => isNotEmpty(value),
                                () => isValidEmail(value),
                              ],
                            ),
                            controller: _emailFieldController,
                            keyboard: TextInputType.emailAddress,
                            icon: Icons.email,
                            iconColor: primaryColor,
                            hintText: 'Informe seu e-mail',
                            hintTextColor: primaryColor,
                            backgroundColor: Colors.lightBlueAccent,
                            backgroundWithOpacity: true,
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          CustomTextFieldRounded(
                            validator: (value) => hasQuantityChars(value, 6),
                            controller: _passwordFieldController,
                            keyboard: TextInputType.number,
                            icon: Icons.security,
                            iconColor: primaryColor,
                            hintText: 'Informe sua senha',
                            hintTextColor: primaryColor,
                            backgroundColor: Colors.lightBlueAccent,
                            backgroundWithOpacity: true,
                            isSecurity: true,
                            maxLenght: 6,
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Consumer<UserAccountmanager>(
                            builder: (_, userManager, __) {
                              return Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final user = UserAccount(
                                            id: '',
                                            name: 'name',
                                            email: _emailFieldController.text,
                                            phone: 'phone',
                                            isAdmin: false);

                                        await userManager.userSignIn(
                                          user: user,
                                          password:
                                              _passwordFieldController.text,
                                          onSucess: () =>
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  RoutesNamed.home
                                                      .getRoutePath()),
                                          onFail: (error) {
                                            context.showSnackBar(
                                                type: SnackbarType.error,
                                                message: error);
                                          },
                                        );
                                      }
                                    },
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                              const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      )),
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(size.width, 56)),
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(26),
                                        ),
                                      ),
                                    ),
                                    child: userManager.loading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.black45,
                                            ),
                                          )
                                        : const Text('Sign in'),
                                  ),
                                  SpacerHeight.h10(),
                                  SignInButton(
                                    text: 'Entrar com o Google',
                                    Buttons.GoogleDark,
                                    onPressed: () {},
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, RoutesNamed.signup.getRoutePath()),
                            child: Text(
                              'Ainda não tem uma conta? Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
