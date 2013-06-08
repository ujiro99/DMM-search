#= require options
#= require jsrender
#= require itemTemplate

$ ->

  currentOption = {}

  ###
   ready evnet
  ###
  $(document).ready ->
    $('#site').change(changeOption)
    $('select#service').change(changeFloor)
    $('button#searchButton').click(submit)
    changeOption()


  ###
   change select options of #service and #floor
  ###
  changeOption = () ->
    isR18 = $('#site').is(':checked')
    if isR18
      currentOption = options18
    else
      currentOption = options
    $service = $('select#service')
    $service.html(currentOption.makeOption())
    changeFloor()


  ###
   change select options of #floor
  ###
  changeFloor = () ->
    service = $('select#service').val()
    newOption = currentOption.getChildByValue(service).makeOption()
    $floor = $("select#floor")
    $floor.html(newOption)


  ###
   submit search query
  ###
  submit = (e) ->
    data = $('form#search').serialize()
    $.ajax
      type: "POST"
      url: "/search"
      data: data
      success: (msg) -> renderResult(msg)
    e.preventDefault()


  ###
   render received data
  ###
  renderResult = (items) ->
    $('#item-container').html $.render.itemTemplate(items)


  ###
   jsrender template
  ###
  $.templates
    itemTemplate: itemTemplate


  ###
   init UI
  ###
  $("select[name='search[service]']").selectpicker({style: 'btn-default'})
  $("select[name='search[floor]']").selectpicker({style: 'btn-default'})
  $("[data-toggle='switch']").wrap('<div class="switch" />').parent().bootstrapSwitch()
