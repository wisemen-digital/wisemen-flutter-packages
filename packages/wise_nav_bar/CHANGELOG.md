## 0.1.0

* **Breaking:** Uses the decoupled `material_ui` and `cupertino_ui` packages instead of `package:flutter/material.dart` and `package:flutter/cupertino.dart`. Apps should migrate their own imports as well (add the packages, then run `dart fix --apply`): `package:flutter/material.dart` and `material_ui` (and the Cupertino pair) are separate copies, so a theme or `ScaffoldMessenger` provided by one is not found by widgets built with the other
* Requires Flutter 3.47 or later, the minimum `material_ui` and `cupertino_ui` support

## 0.0.3

* Fixed Material floating bar's ink response by adding a clip path

## 0.0.2

* Floating bottom bars

## 0.0.1

* Base PlatformAppBar (with guidelines)
* Text AppBar
