Namespace.register("MongoBlog");
MongoBlog.utils = function() {
  return {
    log: function(object) {
      console.log("type is '" + typeof(object) + "';");
      console.log(object);
    }
  };
}();




