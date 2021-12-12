import 'package:flutter/material.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';
import 'package:CartOn/widgets/PrimaryAppBar.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:CartOn/models/signin.dart';
import 'package:dio/dio.dart' ;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  Dio dio = new Dio();
  bool _isLoading = false;
  String pin ="loading";


  @override
  void dispose(){
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    ParamType params = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: PrimaryAppBar(
        title: params.title,
        context: context,
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(Constant.PADDING_VIEW),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    TextWidget(
                      text: params.title == Constant.LOGIN
                          ? Constant.WELCOME_BACK
                          : Constant.GET_STARTED,
                      fontColor: Pallete.textColor,
                      fontSize: Constant.MEDIUM_TEXT_FONT,
                      fontFamily: Constant.ROBOTO_BOLD,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                      text: params.title == Constant.LOGIN
                          ? Constant.ALREADY_HAVE_ACCOUNT
                          : Constant.TOP_PICKS,
                      fontColor: Pallete.textSubTitle,
                      fontSize: Constant.TEXT_FONT,
                      maxLines: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              maxLength: 50,
                              style:
                              TextStyle(fontSize: 18, color: Pallete.textPrimaryColor),
                              decoration: InputDecoration(
                                  hintText: Constant.HINT_NAME_EXAMPLE,
                                  hintStyle: TextStyle(
                                      color: Pallete.textPrimaryColor,
                                      fontSize: Constant.TEXT_FONT,
                                      fontFamily: Constant.ROBOTO_REGULAR),
                                  alignLabelWithHint: true,
                                  // floatingLabelBehavior:
                                  //     FloatingLabelBehavior.always,
                                  labelText: Constant.HINT_NAME,
                                  labelStyle: TextStyle(
                                      color: Pallete.textColor,
                                      fontSize: Constant.HINT_TEXT_FONT)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return Constant.INVALID_NAME;
                                }
                                return null;
                              },
                              controller: nameController,
                              cursorColor: Pallete.textCursorColor,
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              maxLength: 10,
                              style:
                              TextStyle(fontSize: 18, color: Pallete.textPrimaryColor),
                              decoration: InputDecoration(
                                  hintText: Constant.HINT_MOBILE_EXAMPLE,
                                  hintStyle: TextStyle(
                                      color: Pallete.textPrimaryColor,
                                      fontSize: Constant.TEXT_FONT,
                                      fontFamily: Constant.ROBOTO_REGULAR),
                                  alignLabelWithHint: true,
                                  // floatingLabelBehavior:
                                  //     FloatingLabelBehavior.always,
                                  labelText: Constant.HINT_MOBILE_NUMBER,
                                  labelStyle: TextStyle(
                                      color: Pallete.textColor,
                                      fontSize: Constant.HINT_TEXT_FONT)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return Constant.INVALID_MOBILE_NUMBER;
                                }
                                return null;
                              },
                              controller: phoneController,
                              cursorColor: Pallete.textCursorColor,
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        )
                      ),
                    ),
                    // TextWidget(
                    //   text: Constant.STANDARD_RATES_APPLY,
                    //   fontColor: Pallete.textSubTitle,
                    //   fontSize: 14,
                    // ),
                    TextWidget(
                      text: 'Press Continue to create Profile.',
                      fontColor: Pallete.textSubTitle,
                      fontSize: 14,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ButtonWidget(
                  text: Constant.CONTINUE,
                  fontSize: 18,
                  buttonColor: Pallete.secondaryButtonColor,
                  buttonShadowColor: Pallete.secondaryButtonColorShadow,
                  onPress: () async {
                    if (_formKey.currentState.validate()) {
                      var phone =  phoneController.text;
                      setState(() {
                        _isLoading = true;
                      });
                      SignIn otpObj = SignIn();
                      await otpObj.registrationOTP(phoneController.text);
                      setState(() {
                        pin = otpObj.statusMsg;
                      });
                      print(otpObj.responseData);
                      print(otpObj.statusType);
                      print(otpObj.statusMsg);

                      if (otpObj.statusType == 'success')
                      {
                        Navigator.of(context).pushNamed(Routers.OTP,arguments: {'phoneNumber': phoneController.text.toString() ,'otpCode': otpObj.otpCode.toString(), 'type':'signup','name':nameController.text.toString()});
                      }
                      else{
                        _showMaterialDialog(otpObj.statusType,otpObj.statusMsg);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showMaterialDialog(title,content) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            FlatButton(
                child: Text('Login !'),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routers.LOGIN,
                      arguments: ParamType(title: Constant.LOGIN));
                }),
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },

            )
          ],
        ));
  }
}


