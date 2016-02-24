/**
 * 初始化树
 */
$.initTree = function(options){
   var treeOption = {};
   var treeID = options.id;
   treeOption = $.extend(treeOption,options);
   return $("#"+treeID).tree(treeOption);
}