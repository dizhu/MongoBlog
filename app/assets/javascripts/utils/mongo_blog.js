Namespace.register("MongoBlog");
MongoBlog.utils = function() {
  return {
    log: function(object) {
      console.log("type is '" + typeof(object) + "';");
      console.log(object);
    },
    stringFormat: function(src) {
      if (arguments.length == 0) return null;
      var args = Array.prototype.slice.call(arguments, 1);
      return src.replace(/\{(\d+)\}/g, function(m, i){
        return args[i];
      });
    },
    alertHtml: function(message, class_name) {
      class_name = typeof(class_name) !== 'undefined' ? class_name : "";
      var html = "<div class=\"alert " + class_name + "\">";
      html += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button>";
      html += message;
      html += "</div>";
      return html;
    }
  };
}();




