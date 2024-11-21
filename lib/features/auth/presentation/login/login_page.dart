import 'package:flutter_new_template/features/auth/presentation/cubit.dart';

import '../../../../../export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = sl<AuthCubit>();

  final GlobalKey<FormState> formKey = GlobalKey();

  final emailTextController = TextEditingController();

  final passTextController = TextEditingController();

  loginClick() async {
    if (formKey.currentState!.validate()) {
      final res = await controller.login({
        "email": emailTextController.text,
        "password": passTextController.text,
      });
      if (res != null) {
        Logger().i(res.toJson());
        context.goNamed(Routes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBGGreyColor,
        appBar: CustomAppBar(title: context.t.singIn),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              32.h.heightBox,
              Image.asset('assets/images/logo.png'),
              20.h.heightBox,
              TextInput(
                autofillHints: const [AutofillHints.email],
                controller: emailTextController,
                textColor: kBlack,
                inputType: TextInputType.emailAddress,
                hint: context.t.email,
                validate: (value) =>
                    value!.contains('@') ? null : context.t.msErrorEmail,
              ),
              PasswordInput(
                controller: passTextController,
                hint: context.t.password,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.t.forgetPass,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  12.w.widthBox,
                ],
              ),
              34.h.heightBox,
              RoundedCornerLoadingButton(
                onPressed: loginClick,
                child: Text(
                  context.t.logInFirst,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: kBGGreyColor),
                ),
              ),
              24.heightBox,
              GestureDetector(
                onTap: () => context.pushNamed(Routes.signup),
                child: Text(context.t.register,
                    style: Theme.of(context).textTheme.labelSmall),
              ),
            ],
          ),
        ));
  }
}
