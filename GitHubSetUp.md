# `GitHub` SetUp

`WSL(Windows Subsystem for Linux)` を使用しているため，`Windows` 側と `WSL` 側の２つの場所に `Git` のインストールが可能．
`VS code(Virtual Studio Code)` から `Git` を `commit` するなら，`VS Code` を開く場所にインストールすべし．

> 自分は，
> 
> 1. エクスプローラー で `OneDrive` の作業ディレクトリを開く
> 2. 左クリニックの `ターミナルから開く` を選択
> 3. `Windows Terminal` (デフォルトを `WSL` に変更) から `$ code .` で WSL の VS Code を開いて作業をしている

## `Git` SetUp

入っているとは思うけど，一応インストール．

```bash
$ sudo apt-get install git
```

- [Linux 用 Windows サブシステムで Git の使用を開始する - Microsoft](https://learn.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-git)
- [WSL2(Ubuntu)でGitHubを使用する - Qiita](https://qiita.com/Michi1090/items/094a13cad3133e97d202)

### `Git` ユーザー登録

`Git` の `commit` にユーザー名と連絡先を書き残すための入力事項．必須．

```bash
$ git config --global user.name "PCName"
$ git config --global user.email "type.your@email.com"
```

## `SSH` SetUp

`GitHub` に `SSH` 接続して運用する．

### `$ ssh-keygen`

- [新しい SSH キーを生成して ssh-agent に追加する - GitHub Docs](https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [GitHub アカウントへの新しい SSH キーの追加 - GitHub Docs](https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account?platform=linux)

```bash
$ ssh-keygen -t ed25519 -C "type.your@email.com"
```

## `Git` コマンド集

接続テスト

- [SSH 接続をテストする - GitHub Docs](https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection?platform=linux)

```bash
$ ssh -T git@github.com # 接続テスト
Hi Amy-Taker! You've successfully authenticated, but GitHub does not provide shell access.
$
```

ブランチ表示，名称変更

```bash
$ git branch -l # branch 表示
* SetUp
$ git branch -M main  # branch Rename
$ git branch -l
* main
$ 
```

リモートレポジトリ追加

```bash
$ git remote add origin git@github.com:Amy-Taker/repository.git # リモートレポジトリ追加 (RemoteRepositoryName: origin)
```

Push 作業

- `--set-upstream` コマンド: 上流ブランチとして設定
  - 「上流ブランチ（Upstream branch）」とは、あるローカルブランチが、履歴を追跡するように設定したリモートブランチの事を指します - [参考](https://www-creators.com/archives/4931)

```bash
$ git push --set-upstream origin SetUp # origin というリモートレポジトリの SetUp というブランチを上流ブランチとして規定し Push
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 8 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 5.73 KiB | 837.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
remote: 
remote: Create a pull request for 'SetUp' on GitHub by visiting:
remote:      https://github.com/Amy-Taker/openLab/pull/new/SetUp
remote: 
To github.com:Amy-Taker/repository.git
 * [new branch]      SetUp -> SetUp
Branch 'SetUp' set up to track remote branch 'SetUp' from 'origin'.
$ git push
Everything up-to-date
$ 
```

現在のリモートレポジトリを確認する．

```bash
$ git remote -v
origin  git@github.com:Amy-Taker/repository.git (fetch)
origin  git@github.com:Amy-Taker/repository.git (push)
$ 
```

## 不具合集

```bash
$ ssh -T git@github.com
The authenticity of host 'github.com (20.27.177.113)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
Hi Amy-Taker! You've successfully authenticated, but GitHub does not provide shell access.
$ ssh -T git@github.com
Hi Amy-Taker! You've successfully authenticated, but GitHub does not provide shell access.
$
```

`but GitHub does not provide shell access.` と言われたので，[新しい SSH キーを生成して ssh-agent に追加する - GithubDocs](https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) を参考にSSHエージェントの再起動を試す

```bash
$ eval "$(ssh-agent -s)" # バックグラウンドでssh-agentを開始します
Agent pid 2534
$ ssh-add ~/.ssh/id_ed25519 # SSH プライベートキーを ssh-agent に追加します
Identity added: /home/take/.ssh/id_ed25519 (take@AmyDynabook)
$ ssh -T git@github.com # 接続テスト
Hi Amy-Taker! You've successfully authenticated, but GitHub does not provide shell access.
$ 
```

結局変わらなかった．
[SSH 接続をテストする - GitHub Docs](https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection?platform=linux) を参考にすると，どうやらこれでOKらしい

## URL

- [[初心者向け]Gitの理解/Githubの初pushまで - Qiita](https://qiita.com/A__Matsuda/items/f71a935612a55d6e674e)
- [WSL2(Ubuntu)でGitHubを使用する - Qiita](https://qiita.com/Michi1090/items/094a13cad3133e97d202)
