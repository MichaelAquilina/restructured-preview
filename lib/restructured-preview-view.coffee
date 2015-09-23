{TextEditorView} = require 'atom'
{ScrollView} = require 'atom-space-pen-views'
url = require 'url'
path = require 'path'

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
      title = url.parse(@filePath)
      title = path.basename(title.pathname)
      "Restructured Preview - #{title}"
