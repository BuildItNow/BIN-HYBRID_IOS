cordova.define("com.bin.cordova.nativebridge", function(require, exports, module) { 	
    var defSuccess = function()
    {

    }

    var defError = function()
    {

    }

    var defCB = function(error, data)
    {
        if(error)
        {
            console.log("nativebridge Error : ");
            console.log(data);
        }
    }

    var cbSuccessWrapper = function(cb)
    {
        cb = cb || defCB;
        return function(data)
        {
            cb(null, data);
        };
    }

    var cbErrorWrapper = function(cb)
    {
        cb = cb || defCB;
        return function(error)
        {
            cb(error, null);
        };
    }
    
    var exec = require('cordova/exec');
    module.exports = 
    {
       exec : function(key, name, data, cb) 
       {
            // data must be array
            data = bin.nativeManager.argsToNative(data);
            var ncb = function(error, data)
            {
                if(data)
                {
                    data = bin.nativeManager.argsFmNative(data);
                }

                cb(error, data);
            }
            exec(cbSuccessWrapper(ncb) , cbErrorWrapper(ncb), "BINNativeBridge", "exec", [key, name, data]);
       },

       doCB : function(cb, data)
       {
            // data must be array
            data = bin.nativeManager.argsToNative(data);
            exec(defSuccess, defError, "BINNativeBridge", "doCB", [cb, data]);
       },

       linkNativeWithScript : function(nKey, sKey)
       {
            exec(defSuccess, defError, "BINNativeBridge", "linkNativeWithScript", [nKey, sKey]);
       }
    };               
});