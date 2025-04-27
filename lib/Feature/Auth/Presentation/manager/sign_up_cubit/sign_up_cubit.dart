

import 'package:bloc/bloc.dart';
import 'package:chat_gpt_app_updated/Feature/Auth/Presentation/manager/sign_up_cubit/sign_up_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Data/repo/auth_repo_impl.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInit());

  Future<void> signUp(email, password,  name,) async {
    try {
      emit(SignUpLoading());

      var userCredential = await AuthRepoImpl()
          .signUp(name, email, password);
      if (userCredential.user!.emailVerified) {
        emit(SignUpFailure(errorMessage: "Verification email sent to you"));
      } else {
        emit(SignUpSuccess(
            successMessage: "تم تسيجل حسابك بنجاح تحقق من بريدك الالكتروني"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure(errorMessage: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailure(errorMessage: "هذا الحساب مستخدم بالفعل !!"));
      }
    } catch (e) {
      emit(SignUpFailure(errorMessage: "Something want wrong !!"));
    }
  }
}
