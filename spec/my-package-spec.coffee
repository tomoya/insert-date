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
      # コマンドを実行する
      atom.commands.dispatch textEditorElement, 'insert-date:current-editor'
      # バッファ内のテキストを比較する
      console.log(textEditor)
      expect(textEditor.getText()).toBe new Date().toLocaleString()
