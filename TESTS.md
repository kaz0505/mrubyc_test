# mruby/c 自動テスト

## basictest

[CRuby](https://github.com/ruby/ruby/tree/13e474f035aa7cc2ee8a1da177137d05eeec5e3b)のbasictest/test.rbを移植したものです。

以下の機能はmruby/cではサポートされないものと仮定し、移植を
スキップしています。

- 言語機能
  - 例外
  - Bignum
  - `trace_var`
  - `defined?`
  - `alias`
- ライブラリ
  - Kernel#eval
  - Object#clone
  - Array#pack
  - Signal
  - Math
  - Marshal
  - Struct
  - File(basename等)
