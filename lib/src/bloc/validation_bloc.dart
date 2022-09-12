
import 'dart:async';


class Validator {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(data)) {
        sink.add(data);
      } else {
        sink.addError('El correo electrónico no es válido');
      }
    },
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 5) {
        sink.add(data);
      } else {
        sink.addError('La contraseña debe tener al menos 5 caracteres');
      }
    },
  );

  final usernameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 3) {
        sink.add(data);
      } else {
        sink.addError('El usuario debe tener al menos 10 caracteres');
      }
    },
  );
}

  String? nameValidation(String? usernameUsr) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (usernameUsr!.isEmpty) {
      return "Ingrese alguna letra para continuar";
    } else if (!regExp.hasMatch(usernameUsr)) {
      return 'Por favor solo ingrese letras';
    }
    return null;
  }

  String? emailValidation(String? emailUsr) {
    String patttern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(patttern);
    if (emailUsr!.isEmpty) {
      return "Email es Requerido para continuar";
    } else if (!regExp.hasMatch(emailUsr)) {
      return "Email necesita un @ y un dominio";
    }
    return null;
  }

  String? passwordValidation(String? passwordUsr) {
    if (passwordUsr!.length < 3) {
      return "Mínimo 3 carácteres para el módelo";
    }
    return null;
  }

  String? idValidation(String? cedula) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (cedula!.isEmpty) {
      return "Cédula Requerida para continuar";
    } else if (!regExp.hasMatch(cedula)) {
      return "Cédula requiere caracteres numéricos";
    } else if (cedula.length != 10) {
      return "Cédula requiere 10 caracteres";
    }
    return null;
  }

  String? ageValidation(String? age) {
    String patttern = r'(^[0-9]*$)'; 
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(age!)) {
      return "Edad requiere caracteres numéricos para continuar";
    } else if (age.isNotEmpty && age.length <= 3) {
      return null;
    } else {
      return "Edad no validad";
    }
  }
