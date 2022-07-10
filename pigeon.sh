flutter pub run pigeon \
  --input pigeons/app_usage_api.dart \
  --dart_out lib/app_usage_api.dart \
  --java_package "dev.dartling.app_usage" \
  --java_out android/src/main/java/dev/dartling/app_usage/AppUsage.java \
  --experimental_swift_out ios/Classes/AppUsage.swift