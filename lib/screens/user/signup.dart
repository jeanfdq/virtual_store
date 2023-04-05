import 'package:flutter/material.dart';
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

class SignUp extends StatelessWidget with ValidationsFormFields {
  SignUp({super.key});

  static const id = 'SignUp';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final TextEditingController _passwordConfirmedFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final size = getScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: InkWell(
        onTap: hiddenKeyboard,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const TitleSignInSignUp(
                      text: 'Sign Up',
                    ),
                    SizedBox(
                      height: 200,
                      child: logoAnimated(),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextFieldRounded(
                            validator: (value) => validators([
                              () => isNotEmpty(value),
                              () => hasQuantityChars(
                                  value, 2, 'Mínimo de 2 caracteres.')
                            ]),
                            controller: _nameController,
                            keyboard: TextInputType.name,
                            icon: Icons.person,
                            iconColor: primaryColor,
                            hintText: 'Informe seu nome',
                            hintTextColor: primaryColor,
                            backgroundColor: Colors.lightBlueAccent,
                            backgroundWithOpacity: true,
                          ),
                          SpacerHeight.h15(),
                          CustomTextFieldRounded(
                            validator: (value) => validators([
                              () => isNotEmpty(value),
                              () => hasQuantityChars(value, 15,
                                  'Você deve informar pelo menos 11 dígitos.'),
                            ]),
                            mask: '(##) 9####-####',
                            controller: _phoneController,
                            keyboard: TextInputType.phone,
                            icon: Icons.phone,
                            iconColor: primaryColor,
                            hintText: 'Informe seu telefone',
                            hintTextColor: primaryColor,
                            backgroundColor: Colors.lightBlueAccent,
                            backgroundWithOpacity: true,
                          ),
                          SpacerHeight.h15(),
                          CustomTextFieldRounded(
                            validator: (value) => validators([
                              () => isNotEmpty(value),
                              () => isValidEmail(value),
                            ]),
                            controller: _emailFieldController,
                            keyboard: TextInputType.emailAddress,
                            icon: Icons.email,
                            iconColor: primaryColor,
                            hintText: 'Informe seu e-mail',
                            hintTextColor: primaryColor,
                            backgroundColor: Colors.lightBlueAccent,
                            backgroundWithOpacity: true,
                          ),
                          SpacerHeight.h15(),
                          CustomTextFieldRounded(
                            validator: (value) => validators([
                              () => isNotEmpty(value),
                              () => hasQuantityChars(value, 6),
                            ]),
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
                          SpacerHeight.h5(),
                          CustomTextFieldRounded(
                            validator: (value) => validators([
                              () => isNotEmpty(value),
                              () => hasQuantityChars(value, 6),
                              () => confirmedPasswordValid(
                                  value, _passwordFieldController.text),
                            ]),
                            controller: _passwordConfirmedFieldController,
                            keyboard: TextInputType.number,
                            icon: Icons.security,
                            iconColor: primaryColor,
                            hintText: 'Repita sua senha',
                            hintTextColor: primaryColor,
                            backgroundColor: Colors.lightBlueAccent,
                            backgroundWithOpacity: true,
                            isSecurity: true,
                            maxLenght: 6,
                          ),
                          SpacerHeight.h5(),
                          Consumer<UserAccountmanager>(
                              builder: (_, userManager, __) {
                            return ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final userAccount = UserAccount(
                                    id: '',
                                    name: _nameController.text,
                                    email: _emailFieldController.text,
                                    phone: _phoneController.text,
                                    isAdmin: false,
                                  );

                                  await userManager.createSigUp(
                                    user: userAccount,
                                    password:
                                        _passwordConfirmedFieldController.text,
                                    onSucces: () {
                                      Navigator.pushReplacementNamed(context,
                                          RoutesNamed.home.getRoutePath());
                                    },
                                    onFail: (error) {
                                      context.showSnackBar(
                                          type: SnackbarType.error,
                                          message: error);
                                    },
                                  );
                                }
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                    const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )),
                                fixedSize: MaterialStatePropertyAll(
                                    Size(size.width, 56)),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
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
                                  : const Text('Sign Up'),
                            );
                          }),
                          SpacerHeight.h5(),
                          InkWell(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, RoutesNamed.login.getRoutePath()),
                            child: Text(
                              'Já tenho uma conta.',
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
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
