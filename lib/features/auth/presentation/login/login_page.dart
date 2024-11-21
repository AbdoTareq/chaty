import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit.dart';
import 'package:super_rich_text/super_rich_text.dart';

import '../../../../../export.dart';

class LoginPage extends HookWidget {
  LoginPage({super.key});
  final controller = sl<AuthCubit>();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final emailTextController = useTextEditingController();
    final passTextController = useTextEditingController();
    final isRemember = useState(true);

    loginClick() async {
      if (formKey.currentState!.validate()) {
        final res = await controller.login({
          "email": emailTextController.text,
          "password": passTextController.text,
        });
        if (res != null) {
          Logger().i(res.toJson());
          context.goNamed(Routes.posts);
        }
      }
    }

    return Scaffold(
        backgroundColor: kBGGreyColor,
        appBar: CustomAppBar(title: 'accountLogin'),
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
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    activeColor: kPrimaryColor,
                    checkColor: kBGGreyColor,
                    side: MaterialStateBorderSide.resolveWith((states) =>
                        const BorderSide(width: 2, color: Colors.black12)),
                    title: Text(
                      'context.t.remember',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    value: isRemember.value,
                    onChanged: (value) => isRemember.value = value!,
                  ),
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
                child: SuperRichText(
                  text: '${context.t.doHaveAccount}  ll${context.t.register}ll',
                  style: Theme.of(context).textTheme.titleMedium!,
                  othersMarkers: [
                    MarkerText(
                      marker: 'll',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
