cordova.define("com.yezhiming.cordova.appinfo.AppInfo", function(require, exports, module) { 
var exec = require('cordova/exec');

module.exports = {

    getAppInfo: function(success, fail){
        exec(success, fail, 'AppInfo', 'getAppInfo', []);
    },

    /**
     * Returns the version name (or "unknown" if it fails)
     *
     * @param {Function} callback       The message to accept the version name.
     */
    getVersion: function(callback) {
        exec(callback, function(err) {
        	callback('Unknown');
    	}, 'AppInfo', 'getVersion', []);
    },
    
    getIdentifier: function(callback){
        exec(callback, function(err){
            callback('Unknown');
        }, 'AppInfo', 'getIdentifier', []);
    },
    
    share:function(shareObject, success, error){
        exec(success, error, 'AppInfo', 'share', [shareObject.destId, shareObject.myId]);
    },
               
    baiduPilot: function(callback){
        exec(callback, function(err){
            callback('Unknown');
        }, 'AppInfo', 'baiduPilot', []);
    },
               
    getDeviceInfo:function(success, error){
        exec(success, error, 'AppInfo', 'getDeviceInfo',[]);
    },
               
    shareMyWall:function(shareObject, success, error)
    {
               var url = "http://incall.changan.com.cn/static/Test.html?rank="+shareObject.destId+"&describe="+shareObject.myId;

               var data = {};
               //data.SSOEnable = "false";
               data.title = "长安车管家";
               data.url   = url;
               data.imageUrl = "http://www.changan.com.cn/statics/images/changan/logo.png";
               data.content  = "来自好友的荣誉墙";
               data.defaultContent = "来自好友的荣誉墙";
               data.mediaType = "2";
               data.desc = "点击此链接打开您的应用";
               this.shareCommon(data, success, error);
    },
    shareCommon:function(shareData, success, error)
    {
               //typedef enum
               //{
               //SSPublishContentMediaTypeText = 0, /**< 文本 */
               //SSPublishContentMediaTypeImage = 1, /**< 图片 */
               //SSPublishContentMediaTypeNews = 2, /**< 新闻 */
               //SSPublishContentMediaTypeMusic = 3, /**< 音乐 */
               //SSPublishContentMediaTypeVideo = 4, /**< 视频 */
               //SSPublishContentMediaTypeApp = 5, /**< 应用,仅供微信使用 */
               //SSPublishContentMediaTypeNonGif = 6, /**< 非Gif消息,仅供微信使用 */
               //SSPublishContentMediaTypeGif = 7 /**< Gif消息,仅供微信使用 */
               //}
        exec(success, error, 'AppInfo', 'shareCommon', [JSON.stringify(shareData)]);
    },
               openCarLocationView:function(data, success, error)
               {
               exec(success || function(){}, error || function(){}, 'AppInfo', 'openCarLocationView', [data]);

               },
               refreshCarLocationView:function(data, success, error)
               {
                exec(success || function(){}, error || function(){}, 'AppInfo', 'refreshCarLocationView', [data]);
               
               },
               updateStateCarLocationView:function(data, success, error)
               {
               exec(success || function(){}, error || function(){}, 'AppInfo', 'updateStateCarLocationView', [data]);
               
               },
               showCarLocationViewLoading:function()
               {
                    exec(function(){}, function(){}, 'AppInfo', 'showCarLocationViewLoading', []);
               },
               stopCarLocationViewLoading:function()
               {
               exec(function(){}, function(){}, 'AppInfo', 'stopCarLocationViewLoading', []);
               },
               startCarLocationViewPassword:function()
               {
               exec(function(){}, function(){}, 'AppInfo', 'startCarLocationViewPassword', []);
               },
               stopCarLocationViewPassword:function()
               {
               exec(function(){}, function(){}, 'AppInfo', 'stopCarLocationViewPassword', []);
               },
               showStatus:function(type, message)
               {
               var args = [type];
               if(typeof message == "string")
               {
                    args.push(message);
               }
               exec(function(){}, function(){}, 'AppInfo', 'showStatus', args);
               }

};

});
