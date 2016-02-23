cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/com.bin.cordova.eventemiter/www/eventemiter.js",
        "id": "com.bin.cordova.eventemiter",
        "clobbers": [
            "cordova.binPlugins.eventEmiter"
        ]
    },
    {
        "file": "plugins/com.bin.cordova.nativebridge/www/nativebridge.js",
        "id": "com.bin.cordova.nativebridge",
        "clobbers": [
            "cordova.binPlugins.nativeBridge"
        ]
    }
                  
];
module.exports.metadata = 
// TOP OF METADATA
{
    "com.bin.cordova.eventemiter":"1.0.0",
    "com.bin.cordova.nativebridge":"1.0.0"
}
// BOTTOM OF METADATA
});