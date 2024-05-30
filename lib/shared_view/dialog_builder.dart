import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class DialogBuilder {
  final BuildContext context;

  DialogBuilder(this.context);

  void showDialogLoading(SimpleFontelicoProgressDialog dialog) {

    dialog.show(
      message: 'Loading...',
      type: SimpleFontelicoProgressDialogType.normal,
        indicatorColor: Color(0xffF26950)
    );
  }

  void hideDialogLoading(SimpleFontelicoProgressDialog dialog) {
    dialog.hide();
  }
}
