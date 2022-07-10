flutter pub run pigeon \
  --input pigeons/app_usage_api.dart \
  --dart_out lib/app_usage_api.dart \
  --java_package "dev.dartling.app_usage" \
  --java_out android/src/main/java/dev/dartling/app_usage/AppUsage.java \
  --objc_header_out ios/Classes/AppUsageApi.h \
  --objc_source_out ios/Classes/AppUsageApi.m \
  --objc_prefix FLT