cordova.define("com.ichangan.plugins.InterfacePlugin", function(require, exports, module) { 	var exec = require('cordova/exec');
       module.exports = {
               login : function(param, success, error){
               exec(success, error, "InterfacePlugin", "login", [param.username, param.password]);
               },
               regist : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "regist", [param.mobile, param.userName, param.password,
                                                                  param.gender, param.birthday, param.imgPath, param.authcode, param.email]);
               },
               sendAuthCode : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "sendAuthCode", [param.contact, param.usage]);
               },
               checkAuthCode : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "checkAuthCode", [param.contact, param.type, param.authcode, param.usage]);
               },
               findPassword : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "findPassword", [param.phone, param.password, param.authCode]);
               },
               validatePassword : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "validatePassword", [param.password, param.authCode, param.contact, param.token]);
               },
               updatePassword : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "updatePassword", [param.newPassword, param.token,param.password]);
               },
               updatePhone : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "updatePhone", [param.newPhoneNum, param.checkNum, param.password, param.token]);
               },
               carCreate : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "carCreate", [param.vin, param.token]);
               },
               addDevice : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "addDevice", [param.carId, param.deviceNumber, param.typeId, param.authCode, param.token]);
               },
               unbind : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "unbind", [param.tuid, param.carId, param.authcode, param.phone, param.token]);
               },
               unbindCar : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "unbindCar", [param.carId, param.authcode, param.phone, param.token]);
               },
               setPin : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "setPin", [param.carId, param.pin, param.password, param.authCode, param.token]);
               },
               getControlStatus : function(param,success, error) {
               exec(success, error, "InterfacePlugin", "getControlStatus", [param.carId, param.token]);
               },
               carControl : function(param,success, error) {
               if(param.temperature == null || param.temperature == '')
               {
                   param.temperature = '0';
               }
               
               exec(success, error, "InterfacePlugin", "carControl", [param.carId, param.phoneId, param.phoneType, param.cmd, param.pin, param.temperature, param.token]);
               }

   };
               
});
