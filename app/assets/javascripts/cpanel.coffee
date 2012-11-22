#= require application
#= require jquery/redactor_zh-CN
#= require jquery/redactor
#= require jquery/uploadify
#= require_self

$ ->
  $(".destroies").click(
    ()-> 
      $("form.destroies-form").submit() 
      return false
  )
  $("#selected").select_all()
  $(".redactor").redactor(
    lang: 'zh-CN'
    autoresize: false
  )
  
  $(".albums")
    .find("li").live(
      mouseenter:()->
        $(this).find(".info").find("h3").hide().end().find(".action").show()
      mouseleave:()->
        $(this).find(".info").find("h3").show().end().find(".action").hide()
    )
  
  $(".photos")
    .find("li").live(
      mouseenter:()->
        $(this).find(".action").show()
      mouseleave:()->
        $(this).find(".action").hide()
    )
  
  return