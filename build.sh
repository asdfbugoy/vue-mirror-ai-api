
#!/bin/bash

ROOT_DIR=$(pwd);
echo 'ROOT_DIR=' $ROOT_DIR

clean=false
run=false
mode=production
env=uat
app_version=2.3.035

for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            clean)          clean=${VALUE} ;;
            run)          run=${VALUE} ;;
            mode)    		mode=${VALUE} ;;	     
            env)    		env=${VALUE} ;;
            app_version)	app_version=${VALUE};;
            *)   
    esac    
done


echo 'start(build): process...'

if [ $clean == full ]
then
    echo 'running(clean): deleting files....' 
    find . -name 'node_modules' -o -name 'yarn.lock' -o -name 'package-lock.json' | xargs rm -Rf
    cd src-cordova 
    rm -Rf hooks platforms plugins www node_modules

    cd ..

    echo 'running(yarn): installing ...'
    yarn 
    yarn build
    mv dist src-cordova/www

    echo 'running(cordova): building ...'
    cd src-cordova 
    cordova prepare

elif [ $clean == cordova ]
then
    echo 'running(clean): deleting files....' 
    cd src-cordova 
    rm -Rf hooks platforms plugins www node_modules

    cd ..

    echo 'running(yarn): installing ...'
    yarn 
    yarn build
    mv dist src-cordova/www

    echo 'running(cordova): building ...'
    cd src-cordova 
    cordova prepare
elif [ $clean == www ]
then
    echo 'running(clean): deleting files....' 
    cd src-cordova 
    rm -Rf www 

    cd ..

    echo 'running(yarn): installing ...'
    yarn 
    yarn build
    mv dist src-cordova/www

    echo 'running(cordova): building ...'
    cd src-cordova 
    cordova prepare
elif [ $clean == false ]
then
    cd src-cordova 
fi

if [ $run == android-device ]
then
    echo 'running(app): launch android device'
    cordova run android --device
elif [ $run == android ]
then
    echo 'running(app): launch android emulator'
    cordova emulate android
elif [ $run == ios ]
then
    echo 'running(app): launch ios emulator'
    cordova emulate ios
elif [ $run == ios-device ]
then
    echo 'running(app): launch ios device'
    cordova run ios --device
elif [ $run == ios-wifi ]
then
    echo 'running(app): launch ios device'
    cordova run ios --device --target=7e2f68dfd23fbb6f5a859ac492cd59d79eed7dd9
fi

# if [ $option == 'full' ]
# then
#     echo 'running(CLEAN): deleting files....' 
#     find . -name 'node_modules' -o -name 'yarn.lock' -o -name 'package-lock.json' | xargs rm -Rf
#     cd packages/gc-app 
#     rm -Rf apps platforms plugins www config.xml node_modules GoogleService-Info.plist 

#     cd ../..

#     echo 'running(YARN): installing ...'
#     yarn 
#     yarn prepare env=$env mode=$mode

#     echo 'running(CORDOVA): building ...'
#     cd packages/gc-app 
#     yarn add cordova-plugin-firebasex@11.0.1-cli
#     yarn prepare env=$env mode=$mode app_version=$app_version
#     cordova prepare
#     echo 'end full'

# elif [ $option == 'cordova' ]
# then
#     echo 'running(CLEAN): deleting files....' 
#     cd packages/gc-app 
#     rm -Rf apps platforms plugins www config.xml node_modules GoogleService-Info.plist 

#     cd ../..

#     echo 'running(YARN): installing ...'
#     yarn
#     yarn prepare env=$env mode=$mode

#     echo 'running(CORDOVA): building ...'
#     cd packages/gc-app 
#     yarn add cordova-plugin-firebasex@11.0.1-cli
#     yarn prepare env=$env mode=$mode app_version=$app_version
#     cordova prepare
#     echo 'end cordova'

# elif [ $option == 'test' ]
# then
#     echo 'running(CLEAN): deleting files....' 
#     cd packages/gc-app 
#     rm -Rf www 

#     cd ../..

#     echo 'running(CORDOVA): building ...'
#     cd packages/gc-app 
#     yarn prepare env=$env mode=$mode app_version=$app_version
#     echo 'end test'
# fi

# if [ $run == 'both' ]
# then
#     cordova run ios --device --target=7e2f68dfd23fbb6f5a859ac492cd59d79eed7dd9 --buildConfig
#     cordova run android --device

# elif [ $run == 'android' ]
# then
#     echo 'running android build ...' 
#     cordova run android --device
#     echo 'end android build'

# elif [ $run == 'ios' ]
# then
#     echo 'running ios build ...' 
#     cordova emulate ios
#     echo 'end ios build ...' 
# elif [ $run == 'ios-device' ]
# then
#     echo 'running ios-device build ...' 
#     cordova run ios --device --target=7e2f68dfd23fbb6f5a859ac492cd59d79eed7dd9 --buildConfig
#     echo 'end ios-device build ...' 

# elif [ $run == 'ios-wifi' ]
# then
#     echo 'running ios-wifi build ...' 
#     cordova run ios --device --target=7e2f68dfd23fbb6f5a859ac492cd59d79eed7dd9 --buildConfig
#     echo 'end ios-wifi build ...' 
# fi