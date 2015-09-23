{CompositeDisposable} = require 'atom'
RestructuredPreviewView = require './restructured-preview-view'

module.exports = RestructuredPreview =
  restructuredPreviewView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'restructured-preview:show-preview': => @toggle()

    atom.workspace.addOpener( (uri) ->
      if /^restructured-preview:.*.rst$/.test(uri)
        return new RestructuredPreviewView(filePath: uri)
    )

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  toggle: ->
    editor = atom.workspace.getActiveTextEditor()
    path = editor.getPath()
    options =
      split: 'right'
      searchAllPanes: true
    atom.workspace.open("restructured-preview://#{path}", options)
