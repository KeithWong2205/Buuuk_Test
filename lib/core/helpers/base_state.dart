import 'package:buuk_test/core/helpers/resume_base_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends ResumeState<T> with Diagnosticable {
  @override
  Widget build(BuildContext context) {
    initContent();
    return const SizedBox();
  }

  void initContent() {}
}
