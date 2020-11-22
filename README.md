
# kas setup for meta-erlang

[kas](https://github.com/siemens/kas) is a setup tool for bitbake based projects. This repository has a set of kas configuration files aim to help [meta-erlang](https://github.com/meta-erlang/meta-erlang) tests.

In order to use, kas tool need to be installed on your system. Check the [kas user guide](https://kas.readthedocs.io/en/latest/userguide.html#).

The following canned kas files exist in order to test the combinations between Yocto Project, Erlang and Elixir versions:

default configuration:
* base

releases:
* dunfell
* gatesgarth

targets:
* meta-erlang
* meta-erlang-sdk

erlang versions:

* erlang-maint-23

elixir versions:

* elixir-1.11
* elixir-1.10
* elixir-1.9

machines:
* qemux86
* qemux86-64
* qemuarm
* qemuarm64

So, to use the above files the usual kas command line could be like this:

```bash
KAS_WORK_DIR=dunfell kas build erlang-maint-23.yml:elixir-1.11.yml:dunfell.yml:local-dev.yml:meta-erlang.yml:base.yml:qemuarm.yml
```

Where:

* the environment variable _KAS\_WORK\_DIR_ points to a local directory where kas will clone the repositories and build.

* _local-dev.yml_ is a special local file not present in this repository. And allows you to setup any other variables or override exist ones. Example:
```
header:
  version: 10  
local_conf_header:
  local: |
    DL_DIR = "/home/joaohf/work/yocto/downloads"
    SSTATE_DIR = "/home/joaohf/work/yocto/sstate-cache"
    CONNECTIVITY_CHECK_URIS = "https://www.google.com/"
```

So, using kas and the canned configuration files, we can cover most of the combinations provide by meta-erlang layer.