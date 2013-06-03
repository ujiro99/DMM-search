$ ->

  MIN_WIDTH_PC = 768
  ITEM_WIDTH_PC = 200
  ITEM_WIDTH_MOBILE = 200

  $container = $("#item-container")


  ###
  # check html width, then update item width
  ###
  checkColumnWidth = ->
    if $('html').width() >= MIN_WIDTH_PC
      $container.masonry columnWidth: ITEM_WIDTH_PC
    else
      $container.masonry columnWidth: ITEM_WIDTH_MOBILE


  ###
  # ready evnet
  ###
  $(document).ready ->
    $container.css display: "none"
    $container.fadeTo "fast", 0.01


  ###
  # resize evnet
  ###
  $(window).resize ->
    checkColumnWidth()


  ###
  # image loaded evnet
  ###
  $container.imagesLoaded ->
    $container.masonry
      itemSelector: ".item"
      isFitWidth  : true
    checkColumnWidth()
    $container.fadeTo "slow", 1

