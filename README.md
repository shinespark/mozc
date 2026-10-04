# yuzKey

[Mozc](https://github.com/google/mozc) をフォークした、自分用の macOS 向け日本語 IME。upstream への還元は考えていない。

## Mozc との違い

- Dvorak のホーム段（aoeuidhtn）で候補を選べる（設定画面の「A -- N (Dvorak)」）
- [Mozc UT 辞書](https://github.com/utuhiro78/merge-ut-dictionaries)を取り込める

## ビルド

手順は [docs/build_mozc_in_osx.md](docs/build_mozc_in_osx.md) を参照。UT 辞書を入れるときは、先に `scripts/fetch_ut_dictionary.sh` を実行する。

```sh
cd src
bazelisk build package --config release_build
open bazel-bin/mac/Mozc.pkg
```

## ブランチ

- `master`: upstream（google/mozc）の追跡用
- `main`: 自分の変更を 1 機能 1 コミットで積み、upstream に rebase する

## ライセンス

Mozc と同じく [BSD 3-Clause License](LICENSE)。`src/third_party` や辞書データなど、サードパーティのものはそれぞれのライセンスに従う。
