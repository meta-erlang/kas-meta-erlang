
# kas setup for meta-erlang

[kas](https://github.com/siemens/kas) is a setup tool for bitbake based projects. This repository has a set of kas configuration files aim to help [meta-erlang](https://github.com/meta-erlang/meta-erlang) tests.

In order to use, kas tool need to be installed on your system. Check the [kas user guide](https://kas.readthedocs.io/en/latest/userguide.html#).

The following canned kas files exist in order to test the combinations between Yocto Project, Erlang and Elixir versions:

default configuration:
* base

releases:
* master
* mickledore
* langdale
* dunfell
* gatesgarth
* hardknott
* honister

targets:
* meta-erlang
* meta-erlang-sdk

erlang versions:

* erlang-maint-24
* erlang-maint-23
* erlang-maint-22
* erlang-maint-21
* erlang-maint-20

elixir versions:

* elixir-1.12
* elixir-1.11
* elixir-1.10
* elixir-1.9

machines:
* qemux86
* qemux86-64
* qemuarm
* qemuarm64

With so many kas fragment files it's hard to combine each file to make configurations. The best approach is to use kas with Kconfig menu.

A makefile called _menu_ exists to select what to build:

```
make menu
```

After, run:

```
make shell
```

To enter in a new shell configured with the respective build configuration. After that it's only need to call the usual bitbake commands.

## Testing

In the folder _lux/tests_ there are some [Lux](https://github.com/hawk/lux/tree/master) test cases with specific build configurations. These
tests are pretty automatic. Run `make test` in order to run all lux test cases. Or select specific ones and run:

```
make test LUX_FILES=livebook.lux
```

## development

When developing meta-erlang, an additional file is created locally to hold all local configuration:

```
header:
  version: 10
repos:
  meta-erlang:
    path: /home/joaohf/work/opensource/meta-erlang
  poky:
    path: /home/joaohf/work/opensource/poky
    layers:
      meta:
      meta-poky:
      meta-yocto-bsp:

local_conf_header:
  local: |
    DL_DIR = "/home/joaohf/work/yocto/downloads"
    SSTATE_DIR = "/home/joaohf/work/yocto/sstate-cache"
    CONNECTIVITY_CHECK_URIS = "https://www.google.com/"
```

A typical kas command line for development purposes is like this:

```
KAS_WORK_DIR=$(pwd)/devel kas shell local-dev.yml:meta-erlang.yml:base.yml:qemuarm.yml
```