#!/bin/bash
# $0 is app name $1 is dir $2 is scheme $3 is conf (default: release) $4 decides to build at ../ or ./
set -e

WORKING_LOCATION="$(pwd)"
APPLICATION_NAME=$0

if [ $4 -eq 1]
then
	cd ..
fi

if [ ! -d "build" ]; then
    mkdir build
fi

cd build

xcodebuild -workspace "$1" \
    -scheme $2 \
    -configuration $3 \
    -derivedDataPath "$WORKING_LOCATION/build/DerivedDataApp" \
    -destination 'generic/platform=iOS' \
    clean build \
    ONLY_ACTIVE_ARCH="NO" \
    CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGN_ENTITLEMENTS="" CODE_SIGNING_ALLOWED="NO" \

DD_APP_PATH="$WORKING_LOCATION/build/DerivedDataApp/Build/Products/Release-iphoneos/$APPLICATION_NAME.app"
TARGET_APP="$WORKING_LOCATION/build/$APPLICATION_NAME.app"
cp -r "$DD_APP_PATH" "$TARGET_APP"

# codesign --remove "$TARGET_APP"
#if [ -e "$TARGET_APP/_CodeSignature" ]; then
 #   rm -rf "$TARGET_APP/_CodeSignature"
#fi
#if [ -e "$TARGET_APP/embedded.mobileprovision" ]; then
#    rm -rf "$TARGET_APP/embedded.mobileprovision"
#fi

# Add entitlements
#echo "Adding entitlements"
#chmod a+x $WORKING_LOCATION/bin/ldid
#$WORKING_LOCATION/bin/ldid -S"$WORKING_LOCATION/entitlements.plist" "$TARGET_APP/$APPLICATION_NAME"
echo Building iPA
mkdir Payload
cp -r $APPLICATION_NAME.app Payload/$APPLICATION_NAME.app
zip -vr $APPLICATION_NAME.ipa Payload
rm -rf $APPLICATION_NAME.app
rm -rf Payload
rm -rf DerivedDataApp
