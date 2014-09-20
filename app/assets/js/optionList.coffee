class OptionList

  constructor: (options) ->
    @options = []
    for obj in options
      if obj.children?
        obj.children = new OptionList(obj.children)
      @options.push obj

  getOptions: () ->
    return @options

  getChildrenByValue: (value) ->
    for obj in @options
      if obj.value is value
        return obj.children

window.OptionList = OptionList
