## 2.0.0

* **Breaking:** Uses the decoupled `material_ui` and `cupertino_ui` packages instead of `package:flutter/material.dart` and `package:flutter/cupertino.dart`. `lightTheme`, `darkTheme` and the contrast themes now return the `material_ui` `ThemeData`, and `context.wiseTheme` reads the `material_ui` `Theme`, so pass them to a `MaterialApp` from `material_ui`. Apps should migrate their own imports as well (add the packages, then run `dart fix --apply`)
* Requires Flutter 3.47 or later, the minimum `material_ui` and `cupertino_ui` support

## 1.0.0

* Initial release
