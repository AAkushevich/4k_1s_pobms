import 'package:rxdart/src/subjects/subject.dart';
import 'package:spending_analytics/data/repository/IApiRepository.dart';
import 'package:spending_analytics/data/repository/ISharedPrefRepository.dart';
import 'package:spending_analytics/ui/BaseSate/BaseBloc.dart';

class PinCodeBloc extends BaseBloC {

  PinCodeBloc(this._apiRepository, this._sharedPrefRepository);

  final ISharedPrefRepository _sharedPrefRepository;
  final IApiRepository _apiRepository;

  @override
  void initSubjects(List<Subject<dynamic>> subjects) {
    // TODO: implement initSubjects
  }

  void savePinCode(String pin) async{
    await _sharedPrefRepository.setPinCode(pin);
  }

  Future<bool> checkPinCode(String pin) async{
    String savedPin =  await _sharedPrefRepository.getPinCode();
    bool isRight = savedPin.compareTo(pin) == 0;
    return isRight;
  }
 }