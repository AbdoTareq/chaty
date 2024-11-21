import '../../export.dart';

// methods
showWarningDialog({String? title = '', String? text = ''}) async {
  await showDialog(
      context: navKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title ?? '👍'),
          content: Text(text ?? 'under_dev'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.t.yes),
            ),
          ],
        );
      });
}

showSimpleDialog({String title = '', String text = ''}) async {
  await showDialog(
      context: navKey.currentContext!,
      builder: (context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text((title.isNotEmpty ? title : '👍')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.t.yes),
            ),
          ],
        );
      });
}

Future showOptionsDialog<T>(
    {String title = 'Are you sure?',
    String text = '',
    required Future<T> Function() yesFunction}) async {
  return await showDialog(
      context: AppRouter.routes.configuration.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title.isNotEmpty ? title : '👍'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                yesFunction();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      });
}

void showSuccessSnack({required String message}) {
  ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: kPrimaryColor,
    ),
  );
}

void showFailSnack({required String message}) {
  ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: kRed,
    ),
  );
}

Future<dynamic> handleRequest(Future<dynamic> Function() asyncFunction,
    {bool showMessage = false, String? message}) async {
  dynamic res;
  showDialog(
    barrierDismissible: false,
    context: AppRouter.routes.configuration.navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return const AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      );
    },
  );
  res = await handleError(asyncFunction);
  Navigator.pop(AppRouter.routes.configuration.navigatorKey.currentContext!);
  return res;
}

Future<dynamic> handleError(Future<dynamic> Function() asyncFunction,
    {bool showMessage = false,
    String? message,
    Function(dynamic e)? onError}) async {
  try {
    return await asyncFunction();
  } catch (e) {
    Logger().e(e);
    Logger().e(StackTrace.current);
    if (onError != null) onError(e);
    if (e.toString().contains('Unauthenticated')) {
      showFailSnack(message: navKey.currentContext!.t.logInFirst);
    } else {
      List<String> messages =
          e.toString().replaceAll('}', '').split('message:');
      await showWarningDialog(
          title: message ?? 'error',
          text: messages.length > 1 ? messages[1] : messages[0]);
    }
  }
}

Widget? errorLoading(dynamic state) {
  if (state.error != null) {
    return Text(state.error.toString());
  }
  if (state.isLoading) {
    return Image.asset('assets/images/logo.png');
  }
  return null;
}

bool hasMatch(String? value, String pattern) {
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}

bool isEmail(String s) => hasMatch(s,
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

getColorFromHex(String color) =>
    Color(int.parse(color.toString().replaceAll('#', '0xff')));

String getName(item) {
  dynamic temp = item as dynamic;
  try {
    return temp.name;
  } catch (e) {}
  try {
    return temp.title;
  } catch (e) {}
  try {
    return temp.value;
  } catch (e) {}
  try {
    return temp.id;
  } catch (e) {}
  return item.toString();
}

int? getId(item) {
  dynamic temp = item as dynamic;
  try {
    return temp.id;
  } catch (e) {}
  return null;
}

getJson(item) {
  dynamic temp = item as dynamic;
  try {
    return temp.toMap();
  } catch (e) {
    return temp.toJson();
  }
}

// navKey won't work
bool isEn() => LocaleSettings.currentLocale == AppLocale.en;

/// item is modelInstance that has .fromMap & doesn't has data, map is the data
T getModel<T>(modelInstance, data) {
  dynamic temp = modelInstance as dynamic;
  if (modelInstance is Map) {
    return data;
  }
  try {
    return temp.fromMap(data);
  } catch (e) {
    return temp.fromJson(data);
  }
}
