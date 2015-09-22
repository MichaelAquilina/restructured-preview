{CompositeDisposable} = require 'atom'

module.exports = RestructuredPreview =
  restructuredPreviewView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'restructured-preview:show-preview': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  toggle: ->
    editor = atom.workspace.getActiveTextEditor()
    path = editor.getPath()
    child = require('child_process').exec(
      "python #{__dirname}/rst2html.py #{path}", (error, stdout, stderr) ->
        atom.workspace.open("restructured-preview://editor/#{path}").then( (editor) ->
          editor.setText(stdout)
        )
    )
