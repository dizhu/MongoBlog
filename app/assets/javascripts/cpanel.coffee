#= require application
#= require_self

$ ->
  $(".destroies").click(
    ()-> 
      $("form.destroies-form").submit() 
      return false
  )
  $("#selected").select_all()