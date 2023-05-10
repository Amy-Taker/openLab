# $\Latex$ SetUp

実際に動作する [環境](./00_LaTeXtestEnv) を添えておく

## `TeXLive` のインストール

```bash
$ sudo apt -y install texlive #ノーマル版
# $ sudo apt -y install texlive-full #完全体
```

時折，学会のファイルをコンパイルするとスタイルファイルがないと言われることがある．
完全体を入れることで不足分が充足され解決することがあるが，容量をとるので，ノーマル版で十分だと思う．

## `TeXLive` の追加インストール

```bash
$ sudo apt -y install texlive-luatex # これがないと luaLaTeX が動かない
$ sudo apt -y install texlive-lang-japanese # これがないと日本語環境が動かない
$ sudo apt -y install texlive-latex-extra # これがないと追加分の style が無いと言われる
```

## `latexmk` のインストール

```bash
$ sudo apt -y install latexmk
```

`BiBTeX` や `\cite` のパッケージは，コンパイルを複数回行うことで，リンカを作成する．
このコマンドをまとめる `Makefile` のようなものが `latexmk` である．
コンパイルディレクトリにある `.latexmkrc`(`Perl`) を読み込んで動作する．
色々便利なのでいれておいて損はない．

## `Pygments` のインストール

このプログラムは，PDF にコードを貼り付けたりしたときに，行番号やシンタックスハイライトを行う．
`Pygments` はその名の通り，`Python` で動作するため，$\Latex$ コンパイルの際に，`-shell-escape` オプションを付けることで，外部コマンドの実行を許可しなければレンダリング出来ないが，上述した `.latexmkrc` ファイルに既に加筆してあるため，備忘録として記載する．

インストールは以下のように，`pip(Packeage Installer for Python)` を使用する[^python]．

[^python]: [Python](./PythonSetUp.md) のセットアップは済んでいるものとする

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

## PDF ビューアーについて

`Acroreader(Adobe Acrobat Reader)` はアンインストールすること

このソフトウェアは，PDFのプレビュー中にそのファイルの書き込みを禁止する．
つまり， $\Latex$ による更新を行えない状態になる．

以下は， [`$latexmk` - CTAN](https://www.ctan.org/pkg/latexmk/?lang=en)[^ctan] の Manual であるが，Windowsであれば，[SumatraPDF](https://www.sumatrapdfreader.org/free-pdf-reader) などをオススメする．

尚，前述の `.latexmkrc` ファイルで `$pdf_previewer = ` で Path などを指定しているため，適宜調整のこと．

[^ctan]: Comprehensive TeX Archive Network

```Markdown
WARNING:  Problem under MS-Windows: if acroread is used as the pdf previewer, and it is actually viewing a pdf file, the pdf file cannot be updated.  Thus makes acroread a bad choice of previewer if you use latexmk's previous-continuous mode (option -pvc) under MS-windows.  This problem does not occur if, for example, SumatraPDF or gsview is used to view pdf files.

> 警告：MS-Windowsでの問題：acroreadがpdfプレビューアとして使用され、実際にpdfファイルを表示している場合、pdfファイルを更新することはできません。 このため、MS-Windowsでlatexmkのprevious-continuous mode (option -pvc)を使用する場合、acroreadはプレビューアとして不適切な選択肢になります。 この問題は、例えば、SumatraPDFやgsviewを使用してpdfファイルを表示する場合には発生しません。
```