// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'dart:convert';
import 'package:email_helper/Common/UI/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:downloadsfolder/downloadsfolder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _emailTempleteList = ["default"];
    _recipientList = [];
    setState(() {});
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isCallProcess = false;
  String? name;
  String? companyName;
  String? positionName;
  String? _downloadsfolderPath;
  String? _emailTemplete;
  String? _recipientEmail;
  List<String>? _emailTempleteList;
  List<String>? _recipientList;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      color: context.canvasColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: context.canvasColor,
          body: ProgressHUD(
            key: UniqueKey(),
            inAsyncCall: isCallProcess,
            child: Center(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formkey,
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 25),
                      // Name
                      Container(
                        decoration: BoxDecoration(
                          color: context.cardColor,
                          border: Border.all(
                            color: context.accentColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Full Name',
                              hintText: 'Enter your full name',
                            ),
                            onSaved: (String? value) {
                              name = value;
                            },
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                            ]).call,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      
                      // Company Name
                      Container(
                        decoration: BoxDecoration(
                          color: context.cardColor,
                          border: Border.all(
                            color: context.accentColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Company Name',
                              hintText: 'Enter your company name',
                            ),
                            onSaved: (String? value) {
                              companyName = value;
                            },
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                            ]).call,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Company Name
                      Container(
                        decoration: BoxDecoration(
                          color: context.cardColor,
                          border: Border.all(
                            color: context.accentColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Position Name',
                              hintText: 'Enter your position',
                            ),
                            onSaved: (String? value) {
                              positionName = value;
                            },
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                            ]).call,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      //Recipients
                      Row(
                        children: [
                          //Recipients
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.cardColor,
                                border: Border.all(
                                  color: context.accentColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Text(
                                  _recipientList!.join(', '),
                                  style: const TextStyle(height: 2, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          //add new Recipient
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                addNewRecipientEmail(context);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(14),
                              ),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      //Email Templete
                      Row(
                        children: [
                          //Email Templete
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.cardColor,
                                border: Border.all(
                                  color: context.accentColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Templete",
                                    hintText: "Select Email Templete",
                                  ),
                                  value: _emailTemplete,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _emailTemplete = newValue!;
                                    });
                                  },
                                  icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  items: _emailTempleteList!.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                    color: context.accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  // dropdownColor: context.canvasColor,
                                ),
                              ),
                            ),
                          ),
                          //create new Email Templete
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                //createNewTopic(context);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(14),
                              ),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Send Button
                      ElevatedButton(
                        onPressed: () async {
                          if (validateAndSave()) {
                            setState(() {
                              isCallProcess = true;
                            });

                            //Todo
                            if(_emailTemplete == "default")
                            {
                              String jsonString = await rootBundle.loadString("assets/emailTemplete.json");
                              Map<String, dynamic> data = jsonDecode(jsonString);

                              String subject = getFinalConvertedString(data['email']['subject']);
                              String body = getFinalConvertedString(data['email']['body']);

                              await Clipboard.setData(ClipboardData(text: body));
                              sendMail(subject, body);

                              Get.snackbar('Success', 'Successfully Copied.',
                              margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
                            }
                            else
                            {
                              Get.snackbar('Failed', 'Please Select any Email Templete.',
                              margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
                            }

                            setState(() {
                              isCallProcess = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          minimumSize: Size(size.width, size.height * 0.08),
                        ),
                        child: const Text(
                          "Send Email",
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
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

  addNewRecipientEmail(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Add Recipient Email"),
        content: Column(
          children: [
            CupertinoTextFormFieldRow(
              style: TextStyle(fontSize: 18.0, color: context.accentColor),
              placeholder: 'Enter Recipient Email',
              decoration: BoxDecoration(
                color: context.cardColor,
                border: Border.all(
                  color: context.accentColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              onChanged: (String? value) {
                _recipientEmail = value;
              },
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              _recipientEmail = "";
              Get.back();
            },
            isDefaultAction: true,
            child: const Text("Cancel"),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              if (_recipientEmail != "") {
                setState(() {
                  isCallProcess = true;
                });

                Get.back();
                _recipientList!.add(_recipientEmail!);

                setState(() {
                  isCallProcess = false;
                });
              }
            },
            isDefaultAction: true,
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String getFinalConvertedString(String str) {
    return str.replaceAll("{{cName}}", companyName!).replaceAll("{{name}}", name!).replaceAll("{{pName}}", positionName!);
  }

  Future<void> save(String filename, String content) async {
    if(_downloadsfolderPath != null) {
      final path = '$_downloadsfolderPath/$filename';
      final file = File(path);
      await file.writeAsString(content);
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _getDownloadPath() async {
    Directory downloadsfolderPath;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      downloadsfolderPath = await getDownloadDirectory();
      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      setState(() {
        _downloadsfolderPath = downloadsfolderPath.path;
      });
    } on PlatformException {
      if (!mounted) return;
      setState(() {
        _downloadsfolderPath = 'Failed to get folder path.';
      });
    }
  }

  Future<void> sendMail(String subject, String body) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: _recipientList!,
      //attachmentPaths: attachments,
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      
      Get.snackbar('Success', 'Mail send successfully.',
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
    } catch (error) {
      Get.snackbar('send email failed.', error.toString(),
      margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
    }
  }

}
