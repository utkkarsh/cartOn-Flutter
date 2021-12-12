import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/callAPI.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:ionicons/ionicons.dart';

class ModifyProfile extends StatefulWidget {

  final String userName;
  final String userEmail;
  final String userPhone;
  ModifyProfile({this.userName,this.userEmail,this.userPhone});

  @override
  _ModifyProfileState createState() => _ModifyProfileState(userName,userEmail,userPhone);
}

class _ModifyProfileState extends State<ModifyProfile> {
  final String userName;
  final String userEmail;
  final String userPhone;
  _ModifyProfileState(this.userName,this.userEmail,this.userPhone);
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailIDController ;
  TextEditingController nameController;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    emailIDController = new TextEditingController(text: userEmail);
    nameController = new TextEditingController(text: userName);
  }

  @override
  void dispose(){
    emailIDController.dispose();
    nameController.dispose() ;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // height: 400,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        color: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Pallete.accountPageBottomSheetOverhead,
              child: Container(
                // color: Colors.green,
                height: 50,
                width: 500,
                margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: "Manage Profile",
                      fontSize: Constant.PRICE_TEXT_FONT,
                      fontColor: Colors.white,
                      fontFamily: Constant.ROBOTO_MEDIUM,
                    ),
                    // Container(
                    //   width: 150,
                    //   child: SizedBox(
                    //     height: Constant.BUTTON_HEIGHT,
                    //     child: RaisedButton.icon(
                    //       icon: Icon(
                    //         saved ? Ionicons.checkmark_done_outline : Ionicons.save_outline,
                    //         color:Colors.black,),
                    //       label: Text(
                    //         saved ? 'Saved' : 'Save',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize:  Constant.BUTTON_FONT,
                    //           fontFamily: Constant.ROBOTO_MEDIUM,
                    //         ),
                    //       ),
                    //       color: saved ? Colors.white12 : Colors.white70,
                    //       textColor: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10.0),
                    //           side: BorderSide(color:Colors.transparent)),
                    //       onPressed: () => {
                    //         // saved ? null : saveAddress(houseNoController.text,streetController.text,landmarkController.text,pinCodeController.text)
                    //       } ,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            SizedBox(height: 0),
            Container(
              padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW, 50, Constant.PADDING_VIEW, 15),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      maxLength: 100,
                      style:
                      TextStyle(fontSize: 18, color: Pallete.textColor),
                      decoration: InputDecoration(
                          hintText: Constant.HINT_NAME_EXAMPLE,
                          hintStyle: TextStyle(
                              fontSize: Constant.TEXT_FONT,
                              fontFamily: Constant.ROBOTO_REGULAR),
                          alignLabelWithHint: true,
                          // floatingLabelBehavior:
                          //     FloatingLabelBehavior.always,
                          labelText: Constant.HINT_NAME,
                          labelStyle: TextStyle(
                              color: Pallete.addItemButtonColor5,
                              fontSize: Constant.HINT_TEXT_FONT)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return Constant.INVALID_NAME;
                        }
                        return null;
                      },
                      controller: nameController,
                      cursorColor: Pallete.textColor,
                      // keyboardType: TextInputType.phone,
                    ),
                    TextFormField(
                      maxLength: 300,
                      style:
                      TextStyle(fontSize: 18, color: Pallete.textColor),
                      decoration: InputDecoration(
                          hintText: Constant.HINT_EMAIL_EXAMPLE,
                          hintStyle: TextStyle(
                              fontSize: Constant.TEXT_FONT,
                              fontFamily: Constant.ROBOTO_REGULAR),
                          alignLabelWithHint: true,
                          // floatingLabelBehavior:
                          //     FloatingLabelBehavior.always,
                          labelText: Constant.HINT_EMAIL,
                          labelStyle: TextStyle(
                              color: Pallete.addItemButtonColor5,
                              fontSize: Constant.HINT_TEXT_FONT)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return Constant.EMPTY_DATE;
                        }
                        return null;
                      },
                      controller: emailIDController,
                      cursorColor: Pallete.textColor,
                      // keyboardType: TextInputType.phone,
                    ),
                  ],)
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 200,
                //   child: ButtonWidget(
                //     text: 'Save',
                //     fontSize: Constant.BUTTON_FONT,
                //     fontColor: Pallete.textColor,
                //     buttonColor: Pallete.primaryColor,
                //     isBorder: false,
                //     onPress: () {
                //     },
                //   ),
                // ),
                SizedBox(
                    width: 150,
                    child: FlatButton(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Pallete.textColorWhite,
                            fontSize:  Constant.BUTTON_FONT,
                            fontFamily: Constant.ROBOTO_MEDIUM,
                          ),
                        ),
                        // highlightedBorderColor: Colors.green,
                        color: Pallete.addItemButtonColor2,
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),    side: BorderSide(color:Colors.transparent)),
                        onPressed: () {
                          modifyProfileData(userPhone, nameController.text.toString(), emailIDController.text.toString());
                        }
                    )
                ),

                SizedBox(
                    width: 150,
                    child: OutlineButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Pallete.addItemButtonColor2,
                            fontSize:  Constant.BUTTON_FONT,
                            fontFamily: Constant.ROBOTO_MEDIUM,
                          ),
                        ),
                        highlightedBorderColor: Colors.white12,
                        color: Colors.white24,
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),    side: BorderSide(color:Colors.transparent)),
                        onPressed: () {  Navigator.pop(context);     }
                        )
                ),

                // SizedBox(
                //   width: 200,
                //   child: ButtonWidget(
                //     text: 'Cancel',
                //     fontSize: Constant.BUTTON_FONT,
                //     fontColor: Pallete.textColor,
                //     buttonColor: Colors.white,
                //     isBorder: false,
                //
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
    }
}
