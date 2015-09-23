{CompositeDisposable} = require 'atom'
RestructuredPreviewView = require './restructured-preview-view'
url = require 'url'

module.exports = RestructuredPreview =
  restructuredPreviewView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'restructured-preview:show-preview': => @toggle()

    atom.workspace.addOpener( (uri) ->
      if /^restructured-preview:.*.rst$/.test(uri)
        view = new RestructuredPreviewView(uri)
        result = url.parse(uri)
        child = require('child_process').exec(
          "python #{__dirname}/rst2html.py #{result.pathname}", (error, stdout, stderr) ->
            view.setText(stdout)
        )

        console.log "#{view}"
        return view
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
