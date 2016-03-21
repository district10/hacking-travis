% Hacking Travis
% TANG ZhiXiong
% 2016-03-21

Hacking Travis
==============

<div class="tzx-fright">

[![Build Status](https://travis-ci.org/district10/hacking-travis.svg?branch=master)](https://travis-ci.org/district10/hacking-travis)

</div>

**这个 repo 展示了如何用 travis 自动把本文件用 pandoc 转换，然后上载到自己的七牛云盘中。**

首先新建一个 `conf.json`:

```json
{
    "src": "publish",
    "dest":  "qiniu:access_key=QiNiuAK&secret_key=QiNiuSK&bucket=whudoc&key_prefix=travis/",
    "debug_level": 1
}
```

里面的 `QiNiuAK`，`QiNiuSK` 后面会被自动提换成自己的真实 key 值。

```yml
sudo: required

before_install:
  - cd ~
  - wget https://github.com/jgm/pandoc/releases/download/1.17/pandoc-1.17-1-amd64.deb
  - sudo dpkg -i pandoc*.deb
  - pandoc -v

script:
  - git clone https://github.com/district10/hacking-travis.git
  - wget http://devtools.qiniu.com/qiniu-devtools-linux_amd64-current.tar.gz
  - tar xfz qiniu-devtools-linux_amd64-current.tar.gz
  - cd hacking-travis
  - mkdir publish
  - pandoc -f markdown+east_asian_line_breaks README.md -o publish/index.html
  - sed -i "s/QiNiuAK/$QiNiuAK/" conf.json
  - sed -i "s/QiNiuSK/$QiNiuSK/" conf.json
  - ../qrsync conf.json
```

说明：

  - `pandoc` 要用 1.16+ 的版本，所以自己装。因为用了 [`east_asian_line_breaks`
    扩展](https://github.com/jgm/pandoc/issues/2586)。
  - 同步到七牛，所以下载 `qiniu-devtools-linux_amd64-amd64-current.tar.gz`，里
    面的 `$QiNiuAK`，`$QiNiuSK` 在 travis 里环境变量里设置，这两个值用 sed 来替换。

Pandoc 的参数，这也是我自己 [博客](http://tangzx.qiniudn.com) 的设置

```bash
pandoc -S -s --ascii -c http://tangzx.qiniudn.com/main.css \
        --highlight-style pygments \
        -f markdown+east_asian_line_breaks README.md \
        -o publish/index.html
```

---

感谢 [billryan](https://github.com/billryan)：[how did you sync to qiniu? · Issue #83 · billryan/algorithm-exercise](https://github.com/billryan/algorithm-exercise/issues/83)。
