// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

//import 'package:basic/src/widgets/game_app.dart';
import '/src/widgets/game_app.dart';
import 'package:flutter/material.dart';


void main() async {
  // Basic logging setup.
  // Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  // Logger.root.onRecord.listen((record) {
  //   dev.log(
  //     record.message,
  //     time: record.time,
  //     level: record.level.value,
  //     name: record.loggerName,
  //   );
  // });

  // WidgetsFlutterBinding.ensureInitialized();
  // // Put game into full screen mode on mobile devices.
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // // Lock the game to portrait mode on mobile devices.
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(const GameApp());
}


