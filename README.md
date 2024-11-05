# physical_note

A new Flutter project.

# 배포

## 내부 배포

### Android

1. APK 추출

- `flutter build apk --release --flavor prod -t lib/app/config/env/prod.dart`

2. Firebase App Distribution 배포
****
### iOS

deploy_dev 브랜치에 머지 -> Xcode Cloud 배포

## 외부 배포

### Android

1. App Bundle 추출

- `flutter build appbundle --release --flavor prod -t lib/app/config/env/prod.dart`

### iOS

2. 아카이브

- 아카이브 전 빌드를 통해 빌드 버전 최신화
- `flutter build ios --release --flavor prod -t lib/app/config/env/prod.dart`

### Actions
* Github Actions + Fastlane
* `main` 브랜치로 PR 올리고 merge 하면 Github Actions 동작
* Android 설정
* git clone 직후라면, `fastlane supply init` 으로 메타데이터 받기
* iOS 설정

# Android 키 해시 추출.

[키 해시 문서](android/app/keystore/keyhash.md)

# Json Serializable
` flutter pub run build_runner build`
