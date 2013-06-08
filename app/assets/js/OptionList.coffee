class OptionList

  constructor: (options) ->
    @options = []
    for obj in options
      if obj.children?
        obj.children = new OptionList(obj.children)
      @options.push obj

  makeOption: ->
    optStr  = ''
    for obj in @options
      optStr += "<option value='#{obj.value}'>#{obj.text}</option>"
    return optStr

  getChildByValue: (value) ->
    for obj in @options
      if obj.value is value
        return obj.children

window.OptionList = OptionList
