#= require options
#= require jsrender
#= require itemTemplate
#= require jquery.masonry.min
#= require jquery.imagesloaded.min

$ ->

  GET_NUM = 30
  MIN_OFFSET = 1
  LOADING = "<img id='loading' src='/images/loader.gif'>"
  CREDIT = "<a href='https://affiliate.dmm.com/api/'><img src='http://pics.dmm.com/af/web_service/com_135_17.gif' width='135' height='17' alt='WEB SERVICE BY DMM.com' /></a>"
  CREDIT_R18 = "<a href='https://affiliate.dmm.com/api/'><img src='http://pics.dmm.com/af/web_service/r18_135_17.gif' width='135' height='17' alt='WEB SERVICE BY DMM.R18' /></a>"
  $container = $('#item-container')
  $loading = $('#item-loading')
  currentOption = {}
  lastQuery = {}
  loadingCount = 0
  req = null
  notappear = []


  ###
  # scroll evnet
  ###
  $(window).scroll ->
    requestNextItem()
    newlist = []
    for $elem, i in notappear
      imgY = $elem.offset().top - $(window).scrollTop()
      if imgY < screen.availHeight * 0.7
        $elem.removeClass('invisible')
        $elem.addClass('itemFadeIn')
      else
        newlist.push $elem
    notappear = newlist

  ###
   ready evnet
  ###
  $(document).ready ->
    $('#site').change(changeOption)
    $('select#service').change(changeFloor)
    $('button#searchButton').click(onClick)
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
   click event
  ###
  onClick = (e) ->
    req.abort() if req isnt null
    $('#loading').remove()
    $('.item').remove()
    $container.css height: '0px'
    submit(e)


  ###
   received event
  ###
  onReceived = (msg) ->
    loadingCount--
    renderResult(msg)
    requestNextItem()


  ###
   change select options of #service and #floor
  ###
  changeOption = () ->
    isR18 = $('#site').is(':checked')
    if isR18
      currentOption = options18
      $('#dmmcredit').html(CREDIT_R18)
    else
      currentOption = options
      $('#dmmcredit').html(CREDIT)
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
    lastQuery = getFormData()
    lastQuery.offset = MIN_OFFSET
    lastQuery.hits = GET_NUM
    loadingCount++
    $loading.append(LOADING)
    req = $.ajax
      type: "POST"
      url: "/search"
      data: search: lastQuery
      success: onReceived
    e.preventDefault()


  ###
   get data from search form
  ###
  getFormData = () ->
    site = ''
    isR18 = $('input#site').is(':checked')
    if isR18
      site = "DMM.co.jp"
    else
      site = "DMM.com"
    data =
      site: site
      service: $('select#service').val()
      floor: $("select#floor").val()
      keyword: $('input#keyword').val()


  ###
   render received data
  ###
  renderResult = (items) ->
    if items.length
      $itemHtml = $($.render.itemTemplate(items))
      $itemHtml.imagesLoaded ->
        $imgs = $(this).find('.img')
        for img in $imgs
          $img = $(img)
          $img.addClass('invisible')
          notappear.push $img
        $container.append this
        $container.masonry('reload')
      lastQuery.offset += GET_NUM
      $('#loading').remove()
    else
      $('#loading').remove()


  ###
   request item data if space remained
  ###
  requestNextItem = () ->
    heightRemain = $(document).height() - $(window).scrollTop()
    if loadingCount is 0 and heightRemain <= screen.availHeight * 2
      if lastQuery.hasOwnProperty('site')
        loadingCount++
        $loading.append(LOADING)
        req = $.ajax
          type: "POST"
          url: "/search"
          data: search: lastQuery
          success: onReceived


  ###
   init jsrender template
  ###
  $.templates
    itemTemplate: itemTemplate

