import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wise_sentry/wise_sentry.dart';

void main() async {
  // Initialize Wise Sentry with configuration
  await WiseSentry.init(
    dsn: 'YOUR_SENTRY_DSN_HERE', // Replace with your actual Sentry DSN
    environment: 'development', // Set the environment
    sampleRate: 1.0, // Log all errors in development
    tracesSampleRate: 0.2, // Sample 20% of performance traces
    logInDebugMode: true, // Enable logging in debug mode for testing
    appRunner: () => const MyApp(),
  );
}
