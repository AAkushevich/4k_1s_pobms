import 'package:flutter/material.dart';
import 'package:spending_analytics/data/repository/ApiReposytory.dart';
import 'package:spending_analytics/data/repository/SharPrefRepositiry.dart';
import 'package:spending_analytics/ui/BaseSate/BaseState.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:toast/toast.dart';
import '../../main.dart';
import 'PinCodeBloc.dart';

class PinCodePage extends StatefulWidget {

  final PinState pinPageState;

  PinCodePage(this.pinPageState);

  @override
  State<StatefulWidget> createState() {
    return PinCodePageState();
  }
}

class PinCodePageState extends BaseState<PinCodePage, PinCodeBloc> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  BuildContext _context;
  final PageController _pageController = PageController(initialPage: 1);
  int _pageIndex = 0;

  @override
  BottomNavigationBar bottomBarWidget() {
    return null;
  }

  @override
  Widget buildFloatingActionButton() {
    return null;
  }

  @override
  Widget buildStateContent() {
    switch(widget.pinPageState) {
      case PinState.checkPin:
        return getCheckPinWidget();
        break;
      case PinState.newPin:
        return getApplyPinWidget();
        break;
      default:
        break;
    }  }

  Widget getApplyPinWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Введите пин-код",
             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 150),
            child: onlySelectedBorderPinPut(),
          ),
          FlatButton(
            child: Text('Сохранить'),
            onPressed: () async{
              bloc.savePinCode(_pinPutController.text);
              Navigator.pushReplacementNamed(context, mainPageRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget getCheckPinWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Введите пин-код",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 150),
            child: onlySelectedBorderPinPut(),
          ),
          FlatButton(
            child: Text('Ok'),
            onPressed: () async{
              bloc.checkPinCode(_pinPutController.text).then((value) {
                if(value) {
                  Navigator.pushReplacementNamed(context, mainPageRoute);
                } else {
                  Toast.show("Неверный ПИН-код", context, duration: Toast.LENGTH_LONG);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget buildTopToolbarTitleWidget() {
    return null;
  }

  @override
  void disposeExtra() {
    // TODO: implement disposeExtra
  }

  @override
  PinCodeBloc initBloC() {
    return PinCodeBloc(ApiRepository(), SharedPrefRepository());
  }

  @override
  void preInitState() {
    // TODO: implement preInitState
  }

  Widget onlySelectedBorderPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(5.0),
    );
    return Form(
      key: _formKey,
      child: GestureDetector(
        onLongPress: () {
          print(_formKey.currentState.validate());
        },
        child: PinPut(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          withCursor: true,
          fieldsCount: 4,
          fieldsAlignment: MainAxisAlignment.spaceAround,
          textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
          eachFieldMargin: EdgeInsets.all(0),
          eachFieldWidth: 45.0,
          eachFieldHeight: 55.0,
          onSubmit: (String pin) => _showSnackBar(pin),
          focusNode: _pinPutFocusNode,
          controller: _pinPutController,
          submittedFieldDecoration: pinPutDecoration,
          selectedFieldDecoration: pinPutDecoration.copyWith(
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: const Color.fromRGBO(160, 215, 220, 1),
            ),
          ),
          followingFieldDecoration: pinPutDecoration,
          pinAnimationType: PinAnimationType.scale,
        ),
      ),
    );
  }

  void _showSnackBar(String pin) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    Scaffold.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
enum PinState{
  checkPin,
  newPin
}