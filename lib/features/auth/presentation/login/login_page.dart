import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 56),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              .2.sh.heightBox,
              Text(context.t.singInNew,
                  style: Theme.of(context).textTheme.headlineMedium),
              32.h.heightBox,
              TextInput(
                autofillHints: const [AutofillHints.email],
                controller: emailTextController,
                inputType: TextInputType.emailAddress,
                hint: context.t.email,
                validate: (value) =>
                    value!.contains('@') ? null : context.t.msErrorEmail,
              ),
              PasswordInput(
                controller: passTextController,
                hint: context.t.password,
              ),
              BlocListener<AuthCubit, BaseState<User?>>(
                bloc: controller,
                listener: (context, state) {
                  if (state.status == RxStatus.success) {
                    context.pushNamed(Routes.personsList);
                  } else if (state.status == RxStatus.error) {
                    showFailSnack(
                        message: state.errorMessage ?? 'Failed to login');
                  }
                },
                child: RoundedCornerLoadingButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await controller.login(
                        emailTextController.text,
                        passTextController.text,
                      );
                    }
                  },
                  child: Text(
                    context.t.singInNew,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: kBGGreyColor),
                  ),
                ),
              ),
              24.heightBox,
              GestureDetector(
                onTap: () => context.pushNamed(Routes.signup),
                child: Text(context.t.register,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
