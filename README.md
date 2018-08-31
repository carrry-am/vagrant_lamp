# vagrant_lamp

## 環境

接続IPアドレス：`192.168.33.11`

* CentOS 7
* PHP 7.2
  * Xdebug
* Composer
* PHPUnit
* FuelPHP(oilコマンド)
* Apache
* Git
* MySQL 5.6

## マウントしているディレクトリ

ホストOS：`../`
ゲストOS：`/mnt/project`

## その他設定

* 日本時間設定
* SELinuxを無効に
* ファイアウォールを無効に
* `php.ini`と`httpd.conf`は用意したものを使用。デフォルトのものは`/mnt/project/backup`にコピーしている。

## How to use

vagrant-vbguestプラグインをインストールしていない場合のみ以下を行う
```bash
vagrant plugin install vagrant-vbguest
```

立ち上げ
```bash
vagrant up

# プロビジョニングでSELinuxの設定を変更しており、反映させるためのリロードが必要
vagrant reload
```

## 立ち上げ後の確認

動作確認のため、以下ファイルを作成してある。
* `http://192.168.33.11`にアクセス。phpinfoが表示できていることを確認
* `http://192.168.33.11/lesson/`にアクセス。hellolessonと表示されることを確認

## プロジェクト作成時は、ドキュメントルートにシンボリックリンクを張る

```bash
ln -fs /mnt/project/＜プロジェクト名＞ /var/www/html/＜プロジェクト名＞
```

FuelPHPの場合

```bash
ln -fs /mnt/project/＜プロジェクト名＞/public /var/www/html/＜プロジェクト名＞
```
