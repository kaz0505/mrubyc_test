# mruby/c 自動テスト

## 構成

### basictest

[CRuby](https://github.com/ruby/ruby/tree/13e474f035aa7cc2ee8a1da177137d05eeec5e3b)のbasictest/test.rbを移植したものです。

以下の機能はmruby/cではサポートされないものと仮定し、移植を
スキップしています。

- 言語機能
  - 例外
  - Bignum
  - `trace_var`
  - `defined?`
  - `alias`
  - GC
- ライブラリ
  - Kernel#eval
  - Object#clone
  - Array#pack
  - Signal
  - Math
  - Marshal
  - Struct
  - File(basename等)

### mrubytest

mruby (https://github.com/mruby/mruby) のtest/t/\*.rbを
移植したものです。

1ファイルが長いため、assert do ... end で包まれたブロック単位で
切り出してmruby/cに与えるようにしています。この処理はRakefileにあります。

### bootstraptest(未実装)

CRuby(git hashはbasictestと同一)のbootstraptest/test\_\*.rbを
コピーしたものですが、mruby/cで動作させるには至っていません。evalと
ブロックが使われているため、mruby/cに渡す前にテストを加工する必要が
あると思われます。

## レポートの見方

report/index.htmlを開いてください。

- 左のメニューからbasictestおよびmrubytestを選択できます。
- テストファイル名(例：test_array.rb)をクリックすると実行結果が開きます。
  - テストファイル名が緑色＝テスト成功、赤色＝テスト失敗、黄色＝SEGV という分類です。
  - 実行結果欄は、左から入力したスクリプト(ヘッダ除く)、mruby/cでの出力、mrubyでの出力です。
