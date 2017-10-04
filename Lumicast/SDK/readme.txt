
Instructions on how to extract static libraries from the Framework files.

1. Copy the iOS distribution to a Mac.
2. Goto the iOS/SDK/Framework directory.
3. Unzip the LumicastSdk.framework.zip file.

4. Open a terminal on the Mac.
5. cd to the location of the iOS/SDK directory.
This directory contains the script extractStaticLibs.sh.
6. Run the command ./extractStaticLibs.sh
This will create a libs and include sub-directories inside iOS/SDK.
The libs directory will contain the static libraries:
libs/iphoneos/libLumicastSdk.a
libs/iphonesimulator/libLumicast.a
