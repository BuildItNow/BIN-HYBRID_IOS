cordova.define("com.ichangan.plugins.reset-webview.ResetWebview", function(require, exports, module) {
    var exec = require('cordova/exec');

        module.exports = {

        reset: function(success, fail){
            exec(success, fail, 'ResetWebview', 'reset', []);
        }
    };
       
});
