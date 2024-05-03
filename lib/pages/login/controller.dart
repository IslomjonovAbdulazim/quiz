part of 'imports.dart';

class LoginController extends ChangeNotifier {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  FocusNode lastnameFocus = FocusNode();
  bool isLoading = false;
  String? problem;
  String? avatar;

  void onSubmitted(BuildContext context) {
    check();
    if (problem != null) {
      showDialog(context);
    } else {
      createAccount(context);
    }
  }

  void createAccount(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final id = await getUUID();
    UserModel user = UserModel(
      id: id,
      avatar: null,
      firstname: firstnameController.text.trim(),
      lastname: lastnameController.text.trim(),
    );
    if (avatar != null) {
      StorageService storage = StorageService();
      String? avatarPath = await storage.uploadImageToFirebase(avatar!, id);
      if (avatarPath != null) {
        user.avatar = avatarPath;
      }
    }
    DBService db = DBService();
    await db.createUser(user);
    await AuthService.createAccount(id);
    isLoading = false;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    var path = (await picker.pickImage(source: ImageSource.gallery))?.path;
    if (path != null) {
      avatar = path;
      notifyListeners();
    }
  }

  Future<void> getImageFromCamera() async {
    final picker = ImagePicker();
    final path = (await picker.pickImage(source: ImageSource.camera))?.path;
    if (path != null) {
      avatar = path;
      notifyListeners();
    }
  }

  Future<void> deleteAvatar() async {
    avatar = null;
    notifyListeners();
  }

  Future<String> getUUID() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    late String uuid;
    if (Platform.isAndroid) {
      uuid = (await deviceInfoPlugin.androidInfo).id;
    } else if (Platform.isIOS) {
      uuid = (await deviceInfoPlugin.iosInfo).identifierForVendor!;
    }
    return uuid;
  }

  void showDialog(BuildContext context) {
    HapticFeedback.vibrate();
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(problem!),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void check() {
    if (firstnameController.text.trim().isEmpty) {
      problem = "Firstname cannot be empty";
    } else if (lastnameController.text.trim().isEmpty) {
      problem = "Lastname cannot be empty";
    } else {
      problem = null;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    lastnameFocus.dispose();
    super.dispose();
  }
}
