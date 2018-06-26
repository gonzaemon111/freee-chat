# README

This README would normally document whatever steps are necessary to get the
application up and running.

*Version
 - Ruby ver2.3.1
 - Rails ver5.1.6

* 環境構築
``
git clone https://github.com/gonzaemon111/freee-chat.git
``

``
bundle install  (bundle update)
``

``
bundle exec rails db:migrate  (できない場合は、dbをcreate してください)
``

``
bundle exec rails s -b 0.0.0.0
``

*作った感想
RailsのVersionが5.0.0以降から、WebAPIが自由自在になったことだと思っております！
その先陣を切って出されたActionCableを利用しました。
そうすることで、controllerやviewなどを最小限に抑えました。
MessageテーブルのImageカラムを一度作り、画像を送信できるようにも考えましたが、
時間が足らず、間に合いませんでした。
また、HerokuやAWSを利用したインフラ構築までの時間も足らず、間に合いませんでした。
今後は、まず、Rspecを用いて、テストからやっていきたいですね！
