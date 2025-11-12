## 2.1.3

* Added scrollDirection to the PagedList constructor

## 2.1.2

* Added invisibleItemsThreshold to the PagedList constructor

## 2.1.1

- Dependency update

## 2.1.0

* `PagedError` type
* `PaginationMeta` type
* `InfiniteScrollController` controller for paginated lists
* `PagedList<T>` and `SliverPagedList<T>` that consume `InfiniteScrollController`

## 2.0.4

* Added `PlatformButton2` (with the intention of removing current `PlatformButton`)

## 2.0.3

* Added `PlatformSliverRefreshControl`

## 2.0.2

* Dependency update

## 2.0.1

* Bugfix in `FullscreenImageCarousel`

## 2.0.0

* Updated PlatformDropdown
* Added documentation
* Removed all generation
* Removed unused widgets
* Removed localizations
* [Maintenance] Changed folder structure

## 1.0.26

* [BUGFIX] Make platform date picker work on iOS when 12hr clock is selected

## 1.0.25

* [BUGFIX] Pushed overlooked file from 1.0.24

## 1.0.24

* Improved UX for `FullscreenImageCarousel`. Made scrolling more smooth.
* Added clipBehavior parameter to `AnimatedClipRect`

## 1.0.23

* Fixed issue where imageCarousel would cause an `double can't be assigned to int` error for `FullscreenImageCarousel`

## 1.0.22

* Added close button to `FullscreenImageCarousel`
* Added page indicator to `FullscreenImageCarousel`
* Made it possible to add custom widgets to `FullscreenImageCarousel` overlay

## 1.0.21

* Updated basic child to accept and us initialPage if provided for `FullscreenImageCarousel`

## 1.0.20

* Fixed issue where not all parameters could be parsed to `FullscreenImageCarousel`
* Added two extra constructors for extra functionality options `FullscreenImageCarousel`

## 1.0.19

* Updated `FullscreenImageCarousel` to have swipe to dismiss functionality

## 1.0.18

* Changed `PlatformButton` to use `Material` instead of cupertinoButton. Button now has highlight instead of opacity.

## 1.0.17

* Changed `ValidatedTextFormField` to use `_defaultContextMenuBuilder` instead of null as default

## 1.0.16

* Added Arabic translations
* Changed `showPlatformDatePicker` to make use of the new iOS date picker style.

## 1.0.15

* Added a `PlatformSearchBar` and created a `SearchAppBarScaffold` for use when needing a large AppBar with search.

## 1.0.14

* passed all possible parameters from `ValidatedTextFormField`

## 1.0.13

* fixed keyboardType in `ValidatedTextFormField`

## 1.0.12

* fixed password toggle misaligned when error message is shown beneath `ValidatedTextFormField`
* set TextCapitalization to none when `isEmail` or `isPassword` in `ValidatedTextFormField`

## 1.0.11

* fixed labels not showing on Android in the `ValidatedTextFormField`
* fixed TextCapitalization bug in the `ValidatedTextFormField`

## 1.0.10

* added maxLines to 1 in constructor for `ValidatedTextFormField`

## 1.0.9

* added `minLines` and `maxLines` to `ValidatedTextFormField`

## 1.0.8

* updated packages

## 1.0.7

* updated `ValidatedTextFormField` to show correct label placement depending on Platform
* added `LabeledTextField` to show correct label placement depending on Platform

## 1.0.6

* added font size option to bottom nav bar

## 1.0.5

* updated packages

## 1.0.4

* added `cursorColor` and `iconSize` to `ValidatedTextFormField` 
* fixed bug where dialog was not popped when using the `showPlatformConfirmAlertDialog`

## 1.0.3

* Moved repo and updated packages

## 1.0.2

* Changed naming and formatting

## 1.0.0

* Initial version
