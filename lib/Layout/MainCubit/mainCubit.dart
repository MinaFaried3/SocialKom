import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/network/cache_helper.dart';
import 'mainStates.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitMainState());
  static MainCubit get(context) => BlocProvider.of(context);

  bool? isDark = false;
  void Change_theme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ThemeMainState());
    } else {
      isDark = !isDark!;
      CacheHelper.putBool(key: 'isDark', value: isDark!).then((value) {
        emit(ThemeMainState());
      });
    }
  }

// bool? isLogin = false;
// void Change_login({bool? fromShared}) {
//   if (fromShared != null) {
//     isLogin = fromShared;
//     emit(LogInMainState());
//   } else {
//     isLogin = false;
//     CacheHelper.saveData(key: 'onBoarding', value: false).then((value) {
//       emit(LogInMainState());
//     });
//   }
// }
}
