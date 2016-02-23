cordova.define("com.bin.cordova.eventemiter", function(require, exports, module) { 	
    var defSuccess = function()
    {

    }

    var defError = function()
    {
    
    }
    
    var exec = require('cordova/exec');
    module.exports = 
    {
       fire : function(name, data) 
       {
            exec(defSuccess, defError, "BINEventEmiter", "fire", [name, data]);
       }
    };               
});