{CompositeDisposable} = require 'atom'
moment = require 'moment'

module.exports = InsertDate =
  subscriptions: null
  config:
    format:
      order: 1
      type: 'string'
      default: 'YYYY-MM-DD'
      enum: ['YYYY-MM-DD', 'MM-DD-YYYY', 'MM/DD/YYYY']
      description: 'Insert format'
    useCustomFormat:
      order: 2
      type: 'boolean'
      default: false
      description: 'Enable it if you want to use custom format.'
    customFormat:
      order: 3
      type: 'string'
      default: 'D/MMM/YYYY'
      description: '''
        Custom date format string.
        See ref: http://momentjs.com/docs/#/displaying/format/
        '''

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
