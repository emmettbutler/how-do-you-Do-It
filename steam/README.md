Steam setup
===========

These steps walk through the process of creating a new build for Steam on mac
and windows

First, build a swf for both distributions to use

    amxmlc src/ggj.as -o how-do-you-do-it.swf -compiler.include-libraries /opt/flex/frameworks/libs/air/airglobal.swc

Mac
---

Install the latest steamworks SDK

* Log in [here](https://partner.steamgames.com/home)
* Click "Download latest SDK"
* Extract archive to local storage

Build a captive runtime bundle for mac

    adt -certificate -cn SelfSign -ou QE -o "Freeman Butler Kittaka Coss" -c US 2048-RSA hdydicert.pfx AmanoJyakku!
    adt -package -storetype pkcs12 -keystore hdydicert.pfx -target bundle how\ do\ you\ Do\ It.app hdydi.xml how-do-you-do-it.swf

Prepare app for steam

    python steamworks_sdk/tools/ContentPrep.app/Contents/MacOS/contentprep.py --console --verbose --source how\ do\ you\ Do\ It\.app/ --dest steamworks_sdk/tools/ContentBuilder/content --appid 353360 --nowrap

Make necessary changes to app build script, like description

    cp mac_app_build_1000.vdf steamworks_sdk/tools/ContentBuilder/scripts
    # edit "desc" field to provide update on latest changes
    cp mac_depot_build_353362.vdf steamworks_sdk/tools/ContentBuilder/scripts

Upload build to steam

    cd steamworks_sdk/tools/ContentBuilder
    builder_osx/steamcmd +login <steamusername> <password> +run_app_build_http ../scripts/mac_app_build_1000.vdf +quit

Merge build in steam UI:

* App Admin, Builds tab
* Select the default branch for the just-uploaded build
* Click Preview Change and confirm the merge

Windows
-------

Install the latest steamworks SDK

* Log in [here](https://partner.steamgames.com/home)
* Click "Download latest SDK"
* Extract archive to local storage

Build a captive runtime bundle for windows

    adt -certificate -cn SelfSign -ou QE -o "Freeman Butler Kittaka Coss" -c US 2048-RSA hdydicert.pfx AmanoJyakku!
    adt -package -keystore hdydicert.pfx -storetype pkcs12 -target bundle steamworks_sdk\tools\ContentBuilder\content\how_do_you_Do_It hdydi.xml how-do-you-do-it.swf

Make necessary changes to app build script, like description

    # move windows_app_build_1000.vdf steamworks_sdk\tools\ContentBuilder\scripts
    # edit "desc" field to provide update on latest changes
    # move windows_depot_build_353363.vdf steamworks_sdk\tools\ContentBuilder\scripts

Upload build to steam

    cd steamworks_sdk\tools\ContentBuilder
    builder\steamcmd.exe +login <steamusername> <password> +run_app_build_http ..\scripts\windows_app_build_1000.vdf +quit

Merge build in steam UI:

* App Admin, Builds tab
* Select the default branch for the just-uploaded build
* Click Preview Change and confirm the merge

Publish changes to Steam

* Add depots to packages at this url: https://partner.steamgames.com/apps/associated/[AppId]
