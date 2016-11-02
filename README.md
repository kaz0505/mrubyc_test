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

### stdoutのバッファリングをオフにする(オプショナル)

デフォルトのmruby/cだとテスト中にSEGVした場合にstdoutへの出力が
行われないため、sample_c/main.cに以下の1行を足すことを推奨します。

    setvbuf(stdout, NULL, _IONBF, 0);

### テストの実行

    $ rake

個別に実行する場合は以下

    $ rake basictest
    $ rake bootstraptest
    $ rake mrubytest

## テストについて

TESTS.mdを参照してください。
