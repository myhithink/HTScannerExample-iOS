rm -rf Payload
rm -rf $1"/ScannerHDSDkDemo".ipa

mkdir Payload
cp -r $1"/ScannerHDSDkDemo".app ./Payload
zip -r9 $1"/ScannerHDSDkDemo".ipa Payload

rm -rf Payload
