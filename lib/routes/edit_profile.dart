import 'package:flutter/material.dart';

import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:csc4360/wrappers/firestore_wrapper.dart';
import 'package:csc4360/widgets/custom_forms.dart';
import 'package:csc4360/widgets/custom_buttons.dart';
import 'package:csc4360/widgets/nav_scaffold.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlName = TextEditingController();

  Future<void> resetForm() async {
    var displayName = await UserProfile(AuthWrapper.selfUID).displayName;
    if (displayName != null) {
      _ctrlName.text = displayName;
    }
  }

  Future<void> saveForm() async {
    await UserProfile(AuthWrapper.selfUID).modify(
      displayName: _ctrlName.value.text,
    );
  }

  @override
  void initState() {
    resetForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationScaffold(
      title: 'Profile',
      contents: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextFormField(
              label: 'Display name',
              icon: Icons.assignment_ind,
              controller: _ctrlName,
            ),
            SizedBox(
              height: 30,
            ),
            ButtonRow(
              buttons: <ButtonStyleButton>[
                ElevatedButton(
                  child: Text('Cancel'),
                  onPressed: resetForm,
                ),
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: saveForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
