#= require options

$ ->


  ###
   ready evnet
  ###
  $(document).ready ->
    options = window.options
    $service = $("select#service")
    $service.append(options.makeOption())
    $service.change(changeFloor)


  ###
   on change evnet of select#service
  ###
  changeFloor = (e) ->
    service = e.target.value
    newOption = options.getChildByValue(service).makeOption()
    $floor = $("select#floor")
    $floor.html(newOption)

