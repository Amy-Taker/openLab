# `Python` SetUp

WSL および Linux, Unix へのPythonの環境構築について記録する．

## 概要

インタプリタ言語である `Python` は多様な `module` を `import` することにより，様々な場面で活用できる．
ただ，`M1 Mac` をはじめとする `Apple Sillicon` は `Intel CPU` と回路設計が異なるため，行列計算などを行う `numpy` などが不調になることがある[^numpy]．

以上の問題点を克服するために，動作する環境を移築しやすい `Python` の環境構築について記録する．
ここで，コンピュータの評価指標である`RASIS`も併記しておく．

> - Reliability:  信頼性
> - Availability: 可用性
> - Serviceability: 保守性
> - Integrity:  保全性
> - Security: 安全性, 機密性

まず，保守性の高い環境のために仮想環境を構築する．
`Python`の仮想環境は，大きく分けると以下の3つが主流かと思われる．

1. `pyenv` + `venv`
2. `pyenv` + `Poetry`
3. `Conda` + `conda-forge`

今回はこれの `1.` の実装について記録する．
いままでの環境は `Conda` を使用しており，`3.` の状態だったが，いくつか懸念点があったため，新たに環境を構築する．

- `Python` のバージョンはそれほど変更しない
- `Mac` と `Windows`, `Linux` で環境移築が面倒
  - `conda` の `module` を毎回インストールしなくてはならない
  - `conda` の環境によっては圧縮した環境を OS を超えて展開できない
- `conda` 環境で `pip` インストールしていたので崩壊の危険があった

代替案として，`venv` の導入を試行する．
`Poetry` を使用する案もあったが，新規ツールを増やすことで不安定要素を増やすことになるため保留する．

今回導入する環境の案は以下の通り - [参考](https://qiita.com/c60evaporator/items/b6a7394231d1e768ce64#%E5%86%92%E9%A0%AD%E3%81%A7%E7%B4%B9%E4%BB%8B%E3%81%97%E3%81%9F3%E6%96%B9%E6%B3%95%E3%81%A7%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%83%84%E3%83%BC%E3%83%AB)

- A.インタープリタ切替
  - `Conda` -> `pyenv`
- B.パッケージ切替
  - (`Conda` & `pip`) -> `venv`
- C.パッケージインストール
  - (`Conda` & `pip`) -> `pip`
- D.リポジトリ
  - `Conda` -> `PyPI`

これで，`.py` ファイルの保管ディレクトリにある `module` 情報を実行時に読み出し，実行に最適な環境を逐次よみだせるようになる．

[^numpy]: 経験則的に言うと `Apple Sillicon` を使うなら，`Python 3.9` 以上を使うことを強く勧める．参考: [M1 Mac にnumpy, matplotlibなどが入らない問題の解消法 - Qitta](https://qiita.com/ketaro-m/items/ebae35c49d55aa86dfcf#c-python39%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B--%E3%81%93%E3%82%8C%E3%81%8C%E6%9C%AC%E5%91%BD)

## 目次

1. `anyenv` のインストール
2. `pyenv` のインストール
3. `Python` のインストール
4. `venv` のインストール

## `anyenv`のインストール

`pyenv` をそのままインストールしても問題はないのだが，`Node.js` や `Go` などの他の環境も立てやすい `anyenv` を入れ，そこから `pyenv` をインストールする．
パスを通すのがわりと面倒なので，`anyenv` でパスを通して， `anyenv` を用いて `pyenv` を入れるのもある．

まず，[anyenv - GitHub](https://github.com/anyenv/) からクローン

```bash
$ git clone https://github.com/anyenv/anyenv ~/.anyenv
Cloning into '/home/take/.anyenv'...
remote: Enumerating objects: 505, done.
remote: Counting objects: 100% (109/109), done.
remote: Compressing objects: 100% (66/66), done.
remote: Total 505 (delta 54), reused 77 (delta 36), pack-reused 396
Receiving objects: 100% (505/505), 89.55 KiB | 2.98 MiB/s, done.
Resolving deltas: 100% (234/234), done.
```

次に，`anyenv` のPATHを通す

```bash
$ echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(anyenv init -)"' >> ~/.bash_profile
```

`.bash_profile` に書き込んだので，リフレッシュ

```bash
$ source .bash_profile 
ANYENV_DEFINITION_ROOT(/home/take/.config/anyenv/anyenv-install) doesn't exist. You can initialize it by:
> anyenv install --init
$ ~/.anyenv/bin/anyenv init
# Load anyenv automatically by adding
# the following to ~/.bash_profile:

eval "$(anyenv init -)"
```

[本当に正しい .bashrc と .bash_profile の使ひ分け - Qitta](https://qiita.com/magicant/items/d3bb7ea1192e63fba850) を参考にすると，ログイン時に読み込むのが，`.bash_profile` なので，一度 shell を再起動する．

WSLのshell 再起動は，Windows 側から一度 `$ wsl --shutdown` を行わないといけない

これで PATH が通ったので，`anyenv` のインストール

```bash
$ anyenv install --init
Manifest directory doesn't exist: /home/take/.config/anyenv/anyenv-install
Do you want to checkout https://github.com/anyenv/anyenv-install.git? [y/N]: y
Cloning https://github.com/anyenv/anyenv-install.git master to /home/take/.config/anyenv/anyenv-install...
Cloning into '/home/take/.config/anyenv/anyenv-install'...
remote: Enumerating objects: 71, done.
remote: Counting objects: 100% (14/14), done.
remote: Compressing objects: 100% (13/13), done.
remote: Total 71 (delta 4), reused 4 (delta 1), pack-reused 57
Receiving objects: 100% (71/71), 13.15 KiB | 1.20 MiB/s, done.
Resolving deltas: 100% (11/11), done.

Completed!
$ anyenv --version
anyenv 1.1.5-1-g5c58783
$ 
```

できたので確認

```bash
$ anyenv install -l
  Renv
  crenv
  denv
  erlenv
  exenv
  goenv
  hsenv
  jenv
  jlenv
  kubectlenv
  luaenv
  nodenv
  phpenv
  plenv
  pyenv
  rbenv
  sbtenv
  scalaenv
  swiftenv
  tfenv
$ 
```

多くの環境が `anyenv` で構築できることがわかる．

## `pyenv`のインストール

`anyenv` があるので，

```bash
$ anyenv install pyenv
```

だけでサクッと終了

```bash
$ anyenv install pyenv
/tmp/pyenv.20230406161623.3277 ~
Cloning https://github.com/pyenv/pyenv.git master to pyenv...
Cloning into 'pyenv'...
remote: Enumerating objects: 22989, done.
remote: Counting objects: 100% (536/536), done.
remote: Compressing objects: 100% (183/183), done.
remote: Total 22989 (delta 419), reused 398 (delta 343), pack-reused 22453
Receiving objects: 100% (22989/22989), 4.67 MiB | 6.82 MiB/s, done.
Resolving deltas: 100% (15557/15557), done.
Updating files: 100% (1071/1071), done.
~

Install pyenv succeeded!
Please reload your profile (exec $SHELL -l) or open a new session.
$ anyenv --version
anyenv 1.1.5-1-g5c58783
$ pyenv --version
pyenv 2.3.17
$ 
```

`anyenv` と `pyenv` が動作していることがわかる

## `Python`のインストール

[pyenv - GitHub](https://github.com/pyenv/pyenv/wiki) のwikiにある通り，`pyenv`が`Python` を Build するためのインストールを済ませる．

```bash
$ sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

`pyenv` がインストールできる `Python` の一覧が表示できる．

```bash
$ pyenv install -l
Available versions:
  2.1.3
  2.2.3
  2.3.7
  2.4.0
  (中略)
  stackless-3.4.2
  stackless-3.4.7
  stackless-3.5.4
  stackless-3.7.5
$
```

`3.9` 系で最新のものを入れたい場合は，省略するといい

```bash
$ pyenv install 3.9
Downloading Python-3.9.16.tar.xz...
-> https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tar.xz
Installing Python-3.9.16...
Installed Python-3.9.16 to /home/take/.anyenv/envs/pyenv/versions/3.9.16
$ pyenv versions
* system (set by /home/take/.anyenv/envs/pyenv/version)
  3.9.16
$
```

この状態では `pyenv` が `Python` を保持しているので，環境に導入する．

`$ pyenv global` だと環境全体に適応されるが，`$ pyenv local` だと特定のディレクトリ配下のみ利用するバージョンの設定になる． - [pyenv 利用のまとめ - Qitta](https://qiita.com/m3y/items/45c7be319e401b24fca8)

```bash
$ pyenv global 3.9
$ python --version
Python 3.9.16
$ pip --version
pip 22.0.4 from /home/take/.anyenv/envs/pyenv/versions/3.9.16/lib/python3.9/site-packages/pip (python 3.9)
$
```

`Python` と同時に `pip` もダウンロードされて環境に適応されていることがわかる．

## `venv`の環境適応

`venv` は `module` のバージョンなどの情報を記録，適応できる `Python` の標準機能である．

- [venv: Python 仮想環境管理 - Qitta](https://qiita.com/fiftystorm36/items/b2fd47cf32c7694adc2e)
- [venvで仮想環境作成 - Qitta](https://qiita.com/c60evaporator/items/b6a7394231d1e768ce64#venv%E3%81%A7%E4%BB%AE%E6%83%B3%E7%92%B0%E5%A2%83%E4%BD%9C%E6%88%90)


### 環境の構築

```bash
$ cd [プロジェクト用フォルダのパス]
$ python -m venv [新しい環境名]
```

### 環境の起動

```bash
$ source [環境名]/bin/activate
```

## `anyenv` のアップデート

- [anyenv-update - GitHub](https://github.com/znz/anyenv-update)
- [anyenvの*envたちを一括でアップデートする](https://qiita.com/sawadashota/items/825002d84088c0129c4b)

一応，`anyenv` の [GitHub](https://github.com/anyenv/anyenv) にもリンクがあるので，メンテナンスはされているのではなかろうか．
以下，GitHub と同様．

```bash
$ mkdir -p $(anyenv root)/plugins
$ git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
Cloning into '/home/take/.anyenv/plugins/anyenv-update'...
remote: Enumerating objects: 87, done.
remote: Total 87 (delta 0), reused 0 (delta 0), pack-reused 87
Receiving objects: 100% (87/87), 13.33 KiB | 1.67 MiB/s, done.
Resolving deltas: 100% (33/33), done.
$ anyenv update
Updating 'anyenv'...
Updating 'anyenv/anyenv-update'...
Updating 'pyenv'...
 |  From https://github.com/pyenv/pyenv
 |  9a4f9c25..20189ff0  master     -> origin/master
Skipping 'pyenv/python-build'; not git repo
Updating 'anyenv manifest directory'...
$ 
```

普通にアプデ出来ているので適宜活用していきたい．

## 不具合集

#### 不具合(1)

```bash
$ pyenv install 3.9.0
Downloading Python-3.9.0.tar.xz...
-> https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tar.xz
Installing Python-3.9.0...
patching file Misc/NEWS.d/next/Build/2021-10-11-16-27-38.bpo-45405.iSfdW5.rst
patching file configure
patching file configure.ac

BUILD FAILED (Ubuntu 22.04 using python-build 2.3.17)

Inspect or clean up the working tree at /tmp/python-build.20230406165646.1409
Results logged to /tmp/python-build.20230406165646.1409.log

Last 10 log lines:
checking for python3... python3
checking for --enable-universalsdk... no
checking for --with-universal-archs... no
checking MACHDEP... "linux"
checking for gcc... no
checking for cc... no
checking for cl.exe... no
configure: error: in `/tmp/python-build.20230406165646.1409/Python-3.9.0':
configure: error: no acceptable C compiler found in $PATH
See `config.log' for more details
$
```

`BUILD FAILED (Ubuntu 22.04 using python-build 2.3.17)`ってなって失敗したが，[コレ](https://pouhon.net/pyenv-error/2009/)と同じエラーで

```bash
configure: error: no acceptable C compiler found in $PATH
```

Cのコンパイラのエラーっぽいので，ビルドツールをインストール

```bash
$ sudo apt install build-essential
```

再びエラー

```bash
$ pyenv install 3.9.0
Downloading Python-3.9.0.tar.xz...
-> https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tar.xz
Installing Python-3.9.0...
patching file Misc/NEWS.d/next/Build/2021-10-11-16-27-38.bpo-45405.iSfdW5.rst
patching file configure
patching file configure.ac

BUILD FAILED (Ubuntu 22.04 using python-build 2.3.17)

Inspect or clean up the working tree at /tmp/python-build.20230406170837.3553
Results logged to /tmp/python-build.20230406170837.3553.log

Last 10 log lines:
  File "/tmp/python-build.20230406170837.3553/Python-3.9.0/Lib/ensurepip/__init__.py", line 210, in _main
    return _bootstrap(
  File "/tmp/python-build.20230406170837.3553/Python-3.9.0/Lib/ensurepip/__init__.py", line 129, in _bootstrap
    return _run_pip(args + [p[0] for p in _PROJECTS], additional_paths)
  File "/tmp/python-build.20230406170837.3553/Python-3.9.0/Lib/ensurepip/__init__.py", line 38, in _run_pip
    return subprocess.run([sys.executable, "-c", code], check=True).returncode
  File "/tmp/python-build.20230406170837.3553/Python-3.9.0/Lib/subprocess.py", line 524, in run
    raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command '['/tmp/python-build.20230406170837.3553/Python-3.9.0/python', '-c', '\nimport runpy\nimport sys\nsys.path = [\'/tmp/tmptfco8p_m/setuptools-49.2.1-py3-none-any.whl\', \'/tmp/tmptfco8p_m/pip-20.2.3-py2.py3-none-any.whl\'] + sys.path\nsys.argv[1:] = [\'install\', \'--no-cache-dir\', \'--no-index\', \'--find-links\', \'/tmp/tmptfco8p_m\', \'--root\', \'/\', \'--upgrade\', \'setuptools\', \'pip\']\nrunpy.run_module("pip", run_name="__main__", alter_sys=True)\n']' returned non-zero exit status 1.
make: *** [Makefile:1254: install] Error 1
$ 
```

エラーの原因がよくわからなかったが，wiki をよく読んでいないためだった．
インストールに必要な基本パッケージを入れて解決．

#### 不具合(2)

環境変数への理解不足 `.bash_profile`, `.bashrc` の違いをちゃんと理解すべし．

```bash 
$ pyenv --version
Command 'pyenv' not found, did you mean:
  command 'p7env' from deb libnss3-tools (2:3.68.2-0ubuntu1.2)
Try: sudo apt install <deb name>
$ anyenv --version
anyenv: command not found
$ source .bash_profile 
$ anyenv --version
anyenv 1.1.5-1-g5c58783
$ pyenv --version
pyenv 2.3.17
$ 
```

## 参考 URL 各種

- [Pythonの仮想環境構築](https://zenn.dev/mook_jp/articles/1d915a0aef83a7)
- [Python環境構築[Pyenv+Poetry]](https://zenn.dev/zenizeni/books/a64578f98450c2/viewer/c6af80)
- [その実験、再現できますか？pyenvとpoetryによる “そんなに頑張らない” 再現可能な実験環境構築](https://data.gunosy.io/entry/can-you-reproduce-the-experiment-pyenv-poetry)
- [Pythonのパッケージ管理ベストプラクティス - Qitta](https://qiita.com/c60evaporator/items/b6a7394231d1e768ce64)

***

- [anyenvとpyenvでPythonをインストールする - Qitta](https://qiita.com/suke_masa/items/f4db76408b4739de11e3)
- [WSL2 + VScode + nodenv(anyenv)の環境構築方法まとめ - Qitta](https://qiita.com/masako5121/items/2afa847cab1a67be1f47)
- [オールインワンな開発環境をanyenvで構築する](https://zenn.dev/ryuu/articles/use-anyversions)
