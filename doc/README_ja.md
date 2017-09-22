# vagrant-devstack

## これは何？

[VirtualBox](https://www.virtualbox.org/)環境に
devstackをインストールするためのVagrantfileです。
libvirtなど他のハイパーバイザーにも対応する予定です。

以下のようにして使用します。

```sh
$ vagrant up
# Launching a VM ...
$ vagrant ssh
$ /vagrant/installer/all.sh
$ cd devstack
$ cp samples/local.conf .
# Edit local.conf
$ ./stack.sh
```


## 使い方

このツールは
[DevStack Quick Start](https://docs.openstack.org/devstack/latest/).
にある手順の`Create local.conf`の前までを自動的に実行します。
local.confの作成と`stack.sh`の実行は自身で別途行います。

### VirtualBoxとVagrantのインストール

まず始めに
[ここ](https://www.virtualbox.org/)
からVirtualBoxをダウンロードしてインストールを実行します。

次に
[vagrant](https://www.vagrantup.com/)
をインストールします。
またプロキシ環境下にいるのであれば、
以下のようにして`vagrant-proxyconf`プラグインもインストールします。

```sh
$ vagrant plugin install vagrant-proxyconf
```

このツールではデフォルトでUbuntuオフィシャルの
xenial64をダウンロードして使用します。
もし他のboxを用いる場合はVagrantfileを編集してください。

これでVagrantfileを実行するための準備は完了です。

### Vagrantfileの実行

VagrantfileはVMのパラメータ(cpu, memory, etc.)や
パッケージのインストール手順が記述されたファイルです。

パラメータはあなたのマシン環境に合わせて適切に設定する必要があります。
一方、Vagrantfileの最後にあるprovisionのセクションについては
編集の必要はありません。

```ruby
# Vagrantfile

# VM params
NOF_CPU = 2
MEMSIZE = 6  # MB

# Define hypervisor.
# Currently, "virtualbox" or "libvirt" is supported as default.
hv_type = "virtualbox"
```

以下の様にVagrantfileを実行すると、VMが起動され、
パッケージのインストールやstackユーザーの作成が行われます。

```sh
vagrant up
```

### DevStackの取得

VMが起動したら、ログインしてdevstackをインストールします。

このツールではdevstackとその他のツールをインストールするための
`all.sh`スクリプトが用意されています。

```sh
$ vagrant ssh
$ /vagrant/installer/all.sh # run all of support scripts
```

そのほかにもサポートスクリプトが用意されており、3つのカテゴリに分類されます。
これらのスクリプトはログインしたVMの
`/vagrant/`ディレクトリに配置されています。
もし`all.sh`を用いるのではなく個別にインストールする場合は、
`/vagrant/installer/`以下のファイルをそれぞれ実行します。

1. helper: 環境をクリアするために、stackユーザーの削除と追加を行います
1. install: インストールのための環境設定およびインストールを実行します
  * all.sh: 以下の全てのスクリプトを実行
  * devstack.sh: devstackの取得とセットアップを実行(インストールはしない)
  * dein.sh: vimのパッケージマネージャであるdeinのインストール
1. util: bashのユーティリティ関数を追加(`.bashrc`に追記されます)
  * wf.sh: 任意の単語を含むwfコマンドを追加

```
/vagrant
├── helper
│   ├── add_stack_user.sh
│   └── del_user.sh
├── installer
│   ├── all.sh
│   ├── dein.sh
│   ├── devstack.sh
│   └── vimrc_sample.txt
└── util
    └── wf.sh
```

### DevStackのインストール

最後に`local.conf`を編集し、`stack.sh`を実行してdevstackをインストールします。

```sh
$ cd devstack
$ cp samples/local.conf .
$ vim local.conf  # edit it with your favorite editor
$ ./stack.sh
```

もし`stack.sh`にバグがなければ、これでdevstackが無事インストールは完了です。
