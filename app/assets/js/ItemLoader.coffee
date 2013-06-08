#= require itemBuilder

###*
# For load item's data from server.
# @class ItemLoader
###
class ItemLoader

  LOADING_ANIMATION = "
    <div class='circleG' id='loading'>
      <div id='circleG_1'></div>
      <div id='circleG_2'></div>
      <div id='circleG_3'></div>
      <div id='circleG_4'></div>
      <div id='circleG_5'></div>
    </div>"

  _$container = null
  _builder = new ItemBuilder()

  ###*
  # @constructor
  ###
  constructor: ->
    _$container = $("#item-container")

  ###*
  # Loads item from server with ajax
  # @method loadItems
  # @public
  # @param {String} uri  server's uri to request.
  # @param {Number} from num of item's range start.
  # @param {Number} to   num of item's range end.
  ###
  loadItems: (uri, from, to) ->
    _onStartLoading()
    $.getJSON(uri + "/" + from + "-" + to)
    .done (itemJsons) ->
      _apendItems(itemJsons)
    .fail ->
      _deleteLoadingAnimation()

  ###*
  # append all loaded item data
  # @method _apendItems
  # @private
  ###
  _apendItems = (itemJsons) ->
    jQuery.each itemJsons, ->
      $item = $(_builder.buildFromJson(this))
      $item.css display: "none"
      _$container.append $item
      $item.imagesLoaded ->
        _deleteLoadingAnimation()
        _$container.masonry "appended", $item, true
        $item.fadeIn "slow"
        _onFinishLoading()

  ###*
  # on start loading evnet
  # @method _onStartLoading
  # @private
  ###
  _onStartLoading = ->
    window.isLoading = true
    _$container.append LOADING_ANIMATION
    $('#footer').fadeOut('fast')

  ###*
  # on finish loading evnet
  # @method _onFinishLoading
  # @private
  ###
  _onFinishLoading = ->
    window.isLoading = false

  ###*
  # delete loading animattion
  # @method _deleteLoadingAnimation
  # @private
  ###
  _deleteLoadingAnimation = ->
    $('#loading').remove()
    $('#footer').fadeIn('fast')

window.ItemLoader = ItemLoader
