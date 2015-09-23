{TextEditorView} = require 'atom'
{ScrollView} = require 'atom-space-pen-views'
url = require 'url'

module.exports =
class RestructuredPreviewView extends ScrollView
    constructor: ({@editorId, @filePath}) ->
      super
      result = url.parse(@filePath)
      child = require('child_process').exec(
        "python #{__dirname}/rst2html.py #{result.pathname}", (error, stdout, stderr) =>
          @setText(stdout)
      )

    setText: (text) ->
      @html(text)

    @content: ->
      @div()

    getTitle: ->
      return "Restructured Preview"
