# mruby/c 自動テスト

## 実行方法

以下のものが必要です。

- Ruby (2.3.1で動作確認しています。)
- rake (gem install rake)
- mruby (git cloneしてコンパイル)
- mruby/c (git cloneしてmake)

### 設定ファイルの用意

    $ cp config.yml.example config.yml
    $ vi config.yml (mrubyとmrubycのパスを設定)

### テストの実行

    $ rake

個別に実行する場合は以下

    $ rake basictest
    $ rake bootstraptest
    $ rake mrubytest

## テストについて

TESTS.mdを参照してください。
