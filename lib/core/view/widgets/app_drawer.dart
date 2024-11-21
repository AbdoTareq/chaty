import '../../../export.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SwitchListTile(
          //     title: darkMode.text.bold.make(),
          //     value: controller.darkMode.value,
          //     secondary: Icon(Icons.sunny, color: kPrimaryColor),
          //     onChanged: (_) {
          //       controller.darkMode.toggle();
          //       controller.box.write('dark', controller.darkMode.value);
          //     }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            // lets loop over all supported locales
            children: AppLocale.values.map((locale) {
              // active locale
              AppLocale activeLocale = LocaleSettings.currentLocale;
              // typed version is preferred to avoid typos
              bool active = activeLocale == locale;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: active ? Colors.blue.shade100 : null,
                  ),
                  onPressed: () async {
                    // locale change, will trigger a rebuild (no setState needed)
                    LocaleSettings.setLocale(locale);
                    setState(() {});
                    await sl<GetStorage>()
                        .write(kLanguage, locale.languageCode);
                  },
                  child: Text(locale.languageTag),
                ),
              );
            }).toList(),
          ),
          GetStorage().hasData('token')
              ? CustomListTile(
                  onTap: () {
                    GetStorage().remove('token');
                    // Get.find<AppSettingsController>().user.value.data = null;
                  },
                  title: Text(context.t.logOut),
                  leading: const Icon(Icons.exit_to_app, color: kPrimaryColor),
                )
              : CustomListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: Text(context.t.logInFirst),
                  leading: const Icon(Icons.login, color: kPrimaryColor),
                ),
        ],
      ),
    );
  }
}
