import 'package:flutter/material.dart';
import 'package:note_keeper/screen/scoped_model_wrapper.dart';
import 'package:note_keeper/utils/StorageUtils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  runApp(new ScopeModelWrapper());
}



