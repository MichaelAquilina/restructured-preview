{TextEditorView} = require 'atom'
{ScrollView} = require 'atom-space-pen-views'

module.exports =
class RestructuredPreviewView extends ScrollView
    constructor: ({@editorId, @filePath}) ->
      super

    @content: ->
      @div()

    setText: (text) ->
      @html(text)

    getTitle: ->
      return "Restructured Preview"
