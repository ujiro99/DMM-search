#= require options
#= require jsrender
#= require itemTemplate
#= require jquery.masonry.min
#= require jquery.imagesloaded.min

$ ->

  GET_NUM = 30
  MIN_OFFSET = 1
  MIN_WIDTH = 767
  CREDIT = "<a href='https://affiliate.dmm.com/api/'><img src='http://pics.dmm.com/af/web_service/com_135_17.gif' width='135' height='17' alt='WEB SERVICE BY DMM.com' /></a>"
  CREDIT_R18 = "<a href='https://affiliate.dmm.com/api/'><img src='http://pics.dmm.com/af/web_service/r18_135_17.gif' width='135' height='17' alt='WEB SERVICE BY DMM.R18' /></a>"
  $container = $('#item-container')
  $loading = $('#loading')
  currentOption = {}
  lastQuery = {}
  requestEnable = true
  req = null
  notappear = []


  ###
  # scroll evnet
  ###
  $(window).scroll ->
    requestNextItem()
    newlist = []
    for $elem, i in notappear
      if not appear($elem)
        newlist.push $elem
    notappear = newlist


  ###
   ready evnet
  ###
  $(document).ready ->
    $('p-select.service').change(changeFloor)
    $('button#searchButton').click(startSearch)
    $(window).keydown(focusNextForm)
    changeOption()
    $container.masonry
      itemSelector : ".item"
      isFitWidth   : true


  ###
   click event of go top
  ###
  $("#toTop a").click ->
    $('html,body').animate({ scrollTop: $($(this).attr("href")).offset().top }, 'slow','swing')
    return false


  ###
   start search
  ###
  startSearch = (e) ->
    if not requestEnable
      requestCancel()
    $('.item').remove()
    $('#load-complete').hide()
    $container.css height: '0px'
    submit(e)


  ###
   if enter key clicked on keyword form, start searching.
  ###
  focusNextForm = (e) ->
    if e.keyCode == 13  # enter key
      id = e.target.id
      if id is 'keyword'
        $('#searchButton').focus()


  ###
   change select options of #service and #floor
  ###
  changeOption = () ->
    isR18 = $('#site').val() is "DMM.co.jp"
    if isR18
      currentOption = options18
      $('.dmm-credit').html(CREDIT_R18)
    else
      currentOption = options
      $('.dmm-credit').html(CREDIT)
    service = document.querySelector('p-select.service')
    service.items = currentOption.getOptions()
    changeFloor()


  ###
   change select options of #floor
  ###
  changeFloor = () ->
    selected = document.querySelector('p-select.service').selected
    newOption = currentOption.getChildrenByValue(selected)
    if newOption?
      floor = document.querySelector("p-select.floor")
      floor.items = newOption.getOptions()


  ###
   submit search query
  ###
  submit = (e) ->
    e.preventDefault()
    lastQuery = getFormData()
    lastQuery.offset = MIN_OFFSET
    lastQuery.hits = GET_NUM
    request()


  ###
   request to server
  ###
  request = () ->
    requestEnable = false
    $loading.show()
    req = $.ajax
      type: "POST"
      url: "/search"
      data: search: lastQuery
      success: requestSuccess


  ###
   received response, then render result
  ###
  requestSuccess = (msg) ->
    requestEnable = true
    req = null
    $loading.hide()
    renderResult(msg)
    requestNextItem()


  ###
   cancel request
  ###
  requestCancel = () ->
    requestEnable = true
    if req isnt null
      req.abort()
      req = null
    $loading.hide()


  ###
   get data from search form
  ###
  getFormData = () ->
    data =
      site: $('#site').val()
      service: $('select#service').val()
      floor: $("select#floor").val()
      keyword: $('input#keyword').val()


  ###
   render received data
  ###
  renderResult = (items) ->
    if items.length > 0
      $itemHtml = $($.render.itemTemplate(items))
      $itemHtml.imagesLoaded ->
        $container.append this
        $container.masonry('reload')
        # only on PC, fadein image
        if $(window).width() > MIN_WIDTH
          $imgs = $(this).find('.img')
          for img in $imgs
            $img = $(img)
            $img.addClass('invisible')
            if not appear($img)
              notappear.push $img
      lastQuery.offset += GET_NUM
    else
      requestEnable = false
      $('#load-complete').show()


  ###
   if element is on screen, make element visible
  ###
  appear = ($elem) ->
    imgY = $elem.offset().top - $(window).scrollTop()
    if imgY < screen.availHeight * 0.7
      $elem.removeClass('invisible')
      $elem.addClass('itemFadeIn')
      return true
    else
      return false


  ###
   request item data if space remained
  ###
  requestNextItem = () ->
    heightRemain = $(document).height() - $(window).scrollTop()
    if requestEnable and heightRemain <= screen.availHeight * 2
      if lastQuery.hasOwnProperty('site')
        request()


  ###
   init jsrender template
  ###
  $.templates
    itemTemplate: itemTemplate

