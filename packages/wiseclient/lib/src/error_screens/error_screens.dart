import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'base_client_error.dart';
import 'base_server_error.dart';

/// Final class [WiseErrorHandler] to push error routes on top of current navigator stack
final class WiseErrorHandler {
  /// Constructor for [WiseErrorHandler] with custom options for errors
  WiseErrorHandler({
    required this.navigatorKey,
    this.notFound,
    this.requestTimout,
    this.tooManyRequests,
    this.unavailableForLegalReasons,
    this.internalServerError,
    this.badGateway,
    this.serviceUnavailable,
    this.gatewayTimout,
    this.otherServerError,
    this.otherClientError,
    this.showAllErrors = false,
  });

  /// Required app navigation key [navigatorKey]
  final GlobalKey<NavigatorState> navigatorKey;

  /// [Widget] for error 404: Not found
  final Widget? notFound;

  /// [Widget] for error 408: Request timeout
  final Widget? requestTimout;

  /// [Widget] for error 429: Too many requests
  final Widget? tooManyRequests;

  /// [Widget] for error 451: Unavailable for legal reasons
  final Widget? unavailableForLegalReasons;

  /// [Widget] for error 500: Internal server error
  final Widget? internalServerError;

  /// [Widget] for error 502: Bad gateway
  final Widget? badGateway;

  /// [Widget] for error 503: Service unavailable
  final Widget? serviceUnavailable;

  /// [Widget] for error 504: Gateway timout
  final Widget? gatewayTimout;

  /// [Widget] for other server side errors, also used when the error code specific widget is not found
  final Widget? otherServerError;

  /// [Widget] for other client side errors, also used when the error code specific widget is not found
  final Widget? otherClientError;

  /// [bool] for other client side errors, also used when the error code specific widget is not found
  final bool showAllErrors;

  /// Function [pushErrorDetail] to push a route based on the error's status code
  Future<void> pushErrorDetail({required DioException exception}) async {
    if (navigatorKey.currentState != null) {
      final state = navigatorKey.currentState!;
      switch (exception.response?.statusCode) {
        /// Not found
        case 404:
          await state.push(
            getNonNullOrBaseWidget(
              exception: exception,
              codeWidget: notFound,
            ),
          );

        /// Request timeout
        case 408:
          await state.push(
            getNonNullOrBaseWidget(
              exception: exception,
              codeWidget: requestTimout,
            ),
          );

        /// Too many requests
        case 429:
          await state.push(
            getNonNullOrBaseWidget(
              exception: exception,
              codeWidget: tooManyRequests,
            ),
          );

        /// Unavailable for legal reasons
        case 451:
          await state.push(
            getNonNullOrBaseWidget(
              exception: exception,
              codeWidget: unavailableForLegalReasons,
            ),
          );

        /// Internal server error
        case 500:
          await state.push(
            getNonNullOrBaseWidget(
              exception: exception,
              codeWidget: internalServerError,
            ),
          );

        /// Bad gateway
        case 502:
          await state.push(
            getNonNullOrBaseWidget(
              exception: exception,
              codeWidget: badGateway,
            ),
          );

        /// Service unavailable
        case 503:
          await state.push(
            getNonNullOrBaseWidget(
              exception: exception,
              codeWidget: serviceUnavailable,
            ),
          );

        /// Gateway timout
        case 504:
          await state.push(
            getNonNullOrBaseWidget(
              exception: exception,
              codeWidget: gatewayTimout,
            ),
          );

        /// Other server side errors
        case 505:
        case 506:
        case 507:
        case 508:
        case 510:
        case 511:
          await state.push(
            getNonNullOrBaseWidget(
              exception: exception,
            ),
          );
        default:
          if (showAllErrors) {
            await state.push(
              getNonNullOrBaseWidget(
                exception: exception,
              ),
            );
          }
      }
    }
  }

  /// Function [getNonNullOrBaseWidget] to return detailed code widget or a base one
  MaterialPageRoute<Widget> getNonNullOrBaseWidget({
    required DioException exception,
    Widget? codeWidget,
  }) {
    if (codeWidget != null) {
      return MaterialPageRoute(
        builder: (context) => codeWidget,
      );
    } else {
      if (exception.response!.statusCode! >= 400 &&
          exception.response!.statusCode! < 500) {
        if (otherClientError != null) {
          return MaterialPageRoute(
            builder: (context) => otherClientError!,
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => BaseClientError(
              errorInformation: exception.message.toString(),
            ),
          );
        }
      } else {
        if (otherServerError != null) {
          return MaterialPageRoute(
            builder: (context) => otherServerError!,
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => BaseServerError(
              errorInformation: exception.message.toString(),
            ),
          );
        }
      }
    }
  }
}
