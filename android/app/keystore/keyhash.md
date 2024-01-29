# 키해시
안드로이드는 카카오톡 Api 를 이용하려면 키해시를 등록해야 한다.

## Release Key
keytool -exportcert -alias key -keystore ./android/app/keystore/key.jks | openssl sha1 -binary | openssl base64

## Debug Key
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64