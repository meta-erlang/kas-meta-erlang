
# kas setup for meta-erlang

[kas](https://github.com/siemens/kas) is a setup tool for bitbake based projects. This repository has a set of kas configuration files aim to help [meta-erlang](https://github.com/meta-erlang/meta-erlang) tests.

In order to use, kas tool need to be installed on your system. Check the [kas user guide](https://kas.readthedocs.io/en/latest/userguide.html#).

The following canned kas files exist in order to test the combinations between Yocto Project, Erlang and Elixir versions:

default configuration:
* base

releases:
* master
* dunfell
* gatesgarth

targets:
* meta-erlang
* meta-erlang-sdk

erlang versions:

* erlang-maint-23
* erlang-maint-22
* erlang-maint-21
* erlang-maint-20
  
elixir versions:

* elixir-1.11
* elixir-1.10
* elixir-1.9

machines:
* qemux86
* qemux86-64
* qemuarm
* qemuarm64

So, to use the above files the usual kas command line could be like one of the following:

```bash
KAS_WORK_DIR=$(pwd)/dunfell kas build erlang-maint-23.yml:elixir-1.11.yml:dunfell.yml:meta-erlang.yml:base.yml:qemuarm.yml

KAS_WORK_DIR=$(pwd)/gatesgarth kas build erlang-maint-23.yml:elixir-1.11.yml:gatesgarth.yml:meta-erlang.yml:base.yml:qemuarm64.yml

KAS_WORK_DIR=$(pwd)/master kas build erlang-maint-23.yml:elixir-1.11.yml:master.yml:meta-erlang.yml:base.yml:qemux86.yml

KAS_WORK_DIR=$(pwd)/dunfell kas build erlang-maint-23.yml:elixir-1.11.yml:dunfell.yml:meta-erlang.yml:base.yml:qemux86-64.yml
```

Where, the environment variable _KAS\_WORK\_DIR_ points to a local directory where kas will clone the repositories and build.

Using kas and the canned configuration files, we can cover most of the combinations provide by meta-erlang layer.

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
