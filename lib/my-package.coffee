{CompositeDisposable} = require 'atom'

module.exports = InsertDate =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'insert-date:current-editor': => @insertDate()

  deactivate: ->
    @subscriptions.dispose()

  insertDate: ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText(new Date().toLocaleString())
