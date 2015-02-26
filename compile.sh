amxmlc src/ggj.as -o src/how-do-you-do-it.swf -compiler.include-libraries /opt/flex/frameworks/libs/air/airglobal.swc
adt -certificate -cn SelfSign -ou QE -o "Freeman Butler Kittaka Coss" -c US 2048-RSA hdydicert.pfx AmanoJyakku!
adt -package -storetype pkcs12 -keystore hdydicert.pfx -target bundle how\ do\ you\ Do\ It?.app hdydi.xml how-do-you-do-it.swf assets
