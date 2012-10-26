#= require application
#= require jquery/redactor_zh-CN
#= require jquery/redactor
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
  return