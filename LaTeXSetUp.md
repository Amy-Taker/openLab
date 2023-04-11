# `LaTeX` SetUp

## `teXLive` のインストール

```bash
$ sudo apt -y install texlive #ノーマル版
# $ sudo apt -y install texlive-full #完全体
```

## `teXLive` の追加インストール

```bash
$ sudo apt -y install texlive-luatex # これがないと luaLaTeX が動かない
$ sudo apt -y install texlive-lang-japanese # これがないと日本語環境が動かない
$ sudo apt -y install texlive-latex-extra # これがないと追加分の style が無いと言われる
```

## `latexmk` のインストール

```bash
$ sudo apt -y install latexmk
```

## `Pygments` のインストール

```bash
$ pip install Pygments
```

> ```bash
> $ python -m venv 00_pyg
> $ source 00_pyg/bin/activate
> (00_pyg) $ pip install Pygments
> Collecting Pygments
>   Downloading Pygments-2.15.0-py3-none-any.whl (1.1 MB)
>      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.1/1.1 MB 7.3 MB/s eta 0:00:00
> Installing collected packages: Pygments
> Successfully installed Pygments-2.15.0
> WARNING: You are using pip version 22.0.4; however, version 23.0.1 is available.
> You should consider upgrading via the '/mnt/c/Users/Takeru/OneDrive - Shizuoka University/00_lab/20230403/00_pyg/bin/python -m pip install --upgrade pip' command.
> (00_pyg) $ latexmk zentai_template.tex 
> (以下略，成功)
> ```
