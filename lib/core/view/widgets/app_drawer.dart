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
                  },
                  child: Text(locale.languageTag),
                ),
              );
            }).toList(),
          ),
          CustomListTile(
            onTap: () {},
            title: Text(context.t.logOut),
            leading: const Icon(Icons.exit_to_app, color: kPrimaryColor),
          )
        ],
      ),
    );
  }
}
