import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';
import 'package:CartOn/widgets/PrimaryAppBar.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:CartOn/models/signin.dart';
import 'package:flutter_icons/flutter_icons.dart';

class VerifyOTPPage extends StatefulWidget {
  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOTPPage> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  bool _isLoading = false;
  String otpStatus ="";
  String phone = "";
  var otp = "";
  String name = "";
  String type = "";

  resendOTP () async {
    SignIn otpObj = SignIn();
    await otpObj.getOTP(phone);
    print(otpObj.otpCode);
    setState(() {
      otp = otpObj.otpCode;
    });
  }

  @override
  void dispose(){
    otpController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      //if string data
      print(arguments['phoneNumber']);
      //if you passed object
      final String phoneNumber = arguments['phoneNumber'];
      final String cust_name = arguments['name'];
      final String parent_type = arguments['type'];
      final String otpCode = arguments['otpCode'];
      print(parent_type + " -> " +cust_name);
      setState(() {
        phone = phoneNumber;
        otp = otp!=""?otp:otpCode;
        name = cust_name;
        type = parent_type;
      });
    }

    return Scaffold(
      appBar: PrimaryAppBar(
        title:  Constant.VERIFY_OTP,
        context:context
      ),
      body: SafeArea(
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Padding(
            padding: const EdgeInsets.all(Constant.PADDING_VIEW),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                TextWidget(
                  text: Constant.VERIFY_NUMBER,
                  fontColor: Pallete.textColor,
                  fontSize: Constant.MEDIUM_TEXT_FONT,
                  fontFamily: Constant.ROBOTO_BOLD,
                ),
                SizedBox(
                  height: 30,
                ),
                TextWidget(
                  text: Constant.HINT_ENTER_CODE,
                  fontColor: Pallete.textSubTitle,
                  fontSize: Constant.TEXT_FONT,
                ),
                SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: phone + "-" + otp ,
                  fontColor: Pallete.textColor,
                  fontSize: Constant.TEXT_FONT,
                  fontFamily: Constant.ROBOTO_MEDIUM,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller:otpController,
                      maxLength: 4,
                      style: TextStyle(
                          fontSize: Constant.TEXT_FONT,
                          color: Pallete.textPrimaryColor),
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            MaterialCommunityIcons.textbox_password
                            ,
                            color: Pallete.textPrimaryColor,
                          ),
                          hintText: Constant.HINT_OTP_EXAMPLE,
                          hintStyle: TextStyle(
                            color: Pallete.textPrimaryColor,
                              fontSize: Constant.TEXT_FONT,
                              fontFamily: Constant.ROBOTO_REGULAR),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: Constant.HINT_OTP_NUMBER,
                          labelStyle: TextStyle(
                              color: Pallete.textColor,
                              fontSize: Constant.HINT_TEXT_FONT)),
                      validator: (value) {
                        if (value.isEmpty ) {
                          return Constant.INVALID_OTP_CODE;
                        }
                        return null;
                      },
                      cursorColor: Pallete.textCursorColor,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Constant.PADDING_VIEW),
                    child: OutlinedButton(
                        onPressed: () async{
                      await resendOTP();
                    },
                        child: TextWidget(
                          text: Constant.RESEND_CODE,
                          fontColor: Pallete.textPrimaryColor,
                          fontSize: Constant.TEXT_FONT,
                        )),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: GestureDetector(
                //     onTap: () async{
                //       await resendOTP();
                //     },
                //     child: Center(
                //       child: TextWidget(
                //         text: Constant.RESEND_CODE,
                //         fontColor: Pallete.primaryColor,
                //         fontSize: Constant.TEXT_FONT,
                //       ),
                //     ),),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, Constant.PADDING_VIEW),
            child: ButtonWidget(
              text: Constant.CONTINUE,
              fontSize: 18,
              buttonColor: Pallete.secondaryButtonColor,
              buttonShadowColor: Pallete.secondaryButtonColorShadow,
              onPress: () async {
                if (_formKey.currentState.validate()) {
                  // Navigator.of(context).pushNamed(Router.TABS);
                  setState(() {
                    otpStatus = "success";
                  });

                  SignIn otpObj = SignIn();

                  if (type == 'signin')
                    {
                      await otpObj.validateLogin(phone,otpController.text,name,type);

                    }
                  else{
                    await otpObj.validateRegistration(phone,otpController.text,name,type);
                  }

                  print(otpObj);

                  if (otpObj.statusType=='success')
                    {
                      if (otpObj.auth == true && otpObj.token!='')
                      {
                        //
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routers.TABS, ModalRoute.withName(Routers.TABS));
                      }
                    }
                  else
                    { _showMaterialDialog(otpObj.statusType,otpObj.statusMsg);
                      setState(() {
                      otpStatus = otpObj.statusType.toString();
                    });
                    }
                }
              },
            ),
          ),
        ]),
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
                child: Text('Resend OTP'),
                onPressed: () async {
                  await resendOTP();
                  Navigator.of(context).pop();
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
