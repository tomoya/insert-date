{CompositeDisposable} = require 'atom'
moment = require 'moment'

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
    if atom.config.get('insert-date.useCustomFormat')
      format = atom.config.get('insert-date.customFormat')
    else
      format = atom.config.get('insert-date.format')
    editor.insertText(moment().format(format))
