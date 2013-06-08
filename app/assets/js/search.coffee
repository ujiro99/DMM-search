#= require options

$ ->

  ###
  # ready evnet
  ###
  $(document).ready ->
    options = window.options
    $service = $("select#service")
    $service.append(options.makeOption())
    $service.change(changeFloor)

  changeFloor = (e) ->
    service = e.target.value
    newOption = options.getChildByValue(service).makeOption()
    $floor = $("select#floor")
    $floor.html(newOption)

