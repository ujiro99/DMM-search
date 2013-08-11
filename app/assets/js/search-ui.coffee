#= require bootstrap-select
#= require bootstrap-switch

$ ->

  ###
   init UI
  ###
  $("select[name='search[service]']").selectpicker({style: 'btn-default'})
  $("select[name='search[floor]']").selectpicker({style: 'btn-default'})
