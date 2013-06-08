#= require options
#= require jsrender
#= require itemTemplate
#= require jquery.masonry.min
#= require jquery.imagesloaded.min

$ ->

  currentOption = {}
  $container = $('#item-container')

  ###
   ready evnet
  ###
  $(document).ready ->
    $('#site').change(changeOption)
    $('select#service').change(changeFloor)
    $('button#searchButton').click(submit)
    changeOption()
    $container.masonry
      itemSelector : ".item"
      isFitWidth   : true


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
    $('.item').remove()
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
    $itemHtml = $($.render.itemTemplate(items))
    $itemHtml.css display: "none"
    $container.append $itemHtml
    $itemHtml.imagesLoaded ->
      $container.masonry('reload')
      $itemHtml.fadeIn "slow"


  ###
   init jsrender template
  ###
  $.templates
    itemTemplate: itemTemplate


  ###
   init UI
  ###
  $("select[name='search[service]']").selectpicker({style: 'btn-default'})
  $("select[name='search[floor]']").selectpicker({style: 'btn-default'})
  $("[data-toggle='switch']").wrap('<div class="switch" />').parent().bootstrapSwitch()
