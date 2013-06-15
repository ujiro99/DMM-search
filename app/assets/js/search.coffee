#= require options
#= require jsrender
#= require itemTemplate
#= require jquery.masonry.min
#= require jquery.imagesloaded.min

$ ->

  GET_NUM = 10
  MIN_OFFSET = 1
  currentOption = {}
  $container = $('#item-container')
  $loading = $('#item-loading')
  lastQuery = {}
  # 複数読み込みを抑止するためのフラグ
  isLoading = false
  LOADING = "<img id='loading' src='/images/loader.gif'>"
  CREDIT = "<a href='https://affiliate.dmm.com/api/'><img src='http://pics.dmm.com/af/web_service/com_135_17.gif' width='135' height='17' alt='WEB SERVICE BY DMM.com' /></a>"
  CREDIT_R18 = "<a href='https://affiliate.dmm.com/api/'><img src='http://pics.dmm.com/af/web_service/r18_135_17.gif' width='135' height='17' alt='WEB SERVICE BY DMM.R18' /></a>"
  req = null


  ###
  # scroll evnet
  ###
  $(window).scroll ->
    requestNextItem()


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
    isLoading = true
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
      itemHtml = $.render.itemTemplate(items)
      arr = itemHtml.split('#')
      for elem in arr
        if elem.length is 0 then continue
        $elem = $(elem)
        $elem.find('.img').css display: 'none'
        $elem.imagesLoaded ->
          $container.append this
          $container.masonry('reload')
          this.find('.img').fadeTo 'slow', 1
      lastQuery.offset += GET_NUM
      isLoading = false
      $('#loading').remove()
    else
      $('#loading').remove()


  ###
   request item data if space remained
  ###
  requestNextItem = () ->
    heightRemain = $(document).height() - $(window).scrollTop()
    if not isLoading and heightRemain <= screen.availHeight * 2
      if lastQuery.hasOwnProperty('site')
        isLoading = true
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


  ###
   init UI
  ###
  $("select[name='search[service]']").selectpicker({style: 'btn-default'})
  $("select[name='search[floor]']").selectpicker({style: 'btn-default'})
  $("[data-toggle='switch']").wrap('<div class="switch" />').parent().bootstrapSwitch()
