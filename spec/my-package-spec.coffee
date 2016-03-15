moment = require 'moment'

describe "InsertDate", ->
  # テスト内で使用する変数を定義する
  [textEditor, activationPromise, textEditorElement] = []

  beforeEach ->
    # パッケージをアクティベートする関数を変数に代入する
    activationPromise = atom.packages.activatePackage('insert-date')

    waitsForPromise ->
      # atom-workspaceを作成する
      atom.workspace.open().then (editor) ->
        # エディタを定義する
        textEditor = editor
        # atom-text-editor要素を定義する
        textEditorElement = atom.views.getView(textEditor)

    runs ->
      # コマンドを実行し、アクティベート可能にする
      atom.commands.dispatch textEditorElement, 'insert-date:current-editor'

    waitsForPromise ->
      # パッケージをアクティベートする
      activationPromise

  describe "insert-date:current-editor", ->
    beforeEach ->
      # バッファを空にする
      textEditor.setText("")

    it "runs", ->
      # 設定に値をセットする
      atom.config.set('insert-date.customFormat', 'D/MMM/YYYY')
      atom.config.set('insert-date.useCustomFormat', false)
      atom.config.set('insert-date.format', 'YYYY-MM-DD')
      # コマンドを実行する
      atom.commands.dispatch textEditorElement, 'insert-date:current-editor'
      # バッファ内のテキストを比較する
      expect(textEditor.getText()).toBe moment().format('YYYY-MM-DD')
      console.log textEditor.getText()

      # バッファを消去する
      textEditor.setText('')
      atom.config.set('insert-date.format', 'MM-DD-YYYY')
      atom.commands.dispatch textEditorElement, 'insert-date:current-editor'
      expect(textEditor.getText()).toBe moment().format('MM-DD-YYYY')
      console.log textEditor.getText()

      textEditor.setText('')
      atom.config.set('insert-date.format', 'MM/DD/YYYY')
      atom.commands.dispatch textEditorElement, 'insert-date:current-editor'
      expect(textEditor.getText()).toBe moment().format('MM/DD/YYYY')
      console.log textEditor.getText()

      textEditor.setText('')
      atom.config.set('insert-date.useCustomFormat', true)
      atom.commands.dispatch textEditorElement, 'insert-date:current-editor'
      expect(textEditor.getText()).toBe moment().format('D/MMM/YYYY')
      console.log textEditor.getText()
