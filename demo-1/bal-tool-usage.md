# `bal tool` Usage

This document goes through the usage of the `bal tool` command through the life-cycle of the `bal health` tool.

`bal tool` has a set of sub-commands that allows managing the tool life cycle.

## `bal tool search`

The `bal tool search` command is used to search for tool information in the Ballerina Central.

Let's do a `bal tool search` on the `health` tool. The health tool generates Ballerina library packages and Ballerina templates for developing healthcare integrations.

``` bash
% bal tool search health

Ballerina Central
=================

|ID                 |PACKAGE           |DESCRIPTION                               |DATE            |VERSION       |
|-------------------|------------------|------------------------------------------|----------------|--------------|
|health             |ballerinax/health |This project contains an extension imp... |2024-05-07-Tue  |2.1.2         |

1 tools found.
```

The latest version of the `health` tool is `2.1.2`.

## `bal tool pull`

Let's pull the `health` tool to the local machine.
``` bash
% bal tool pull health
ballerinax/health:2.1.2 [central.ballerina.io ->/Users/gayaldassanayake/.ballerina/repositories/central.ballerina.io/bala/ballerinax/health/2.1.2]  100% [=====================] 93313/93313 KB (0:00:08 / 0:00:00)
ballerinax/health:2.1.2 pulled from central successfully

tool 'health:2.1.2' pulled successfully.
tool 'health:2.1.2' successfully set as the active version.
```

Alternatively we can specify a version to pull a specific version of the tool.

``` bash
% bal tool pull health:2.1.1
ballerinax/health:2.1.1 [central.ballerina.io ->/Users/gayaldassanayake/.ballerina/repositories/central.ballerina.io/bala/ballerinax/health/2.1.1]  100% [=====================] 93539/93539 KB (0:00:13 / 0:00:00)
ballerinax/health:2.1.1 pulled from central successfully

tool 'health:2.1.1' pulled successfully.
tool 'health:2.1.1' successfully set as the active version.
```

## `bal tool list`

The `bal tool list` command lists the tools that are installed in the local machine.

``` bash
% bal tool list
|TOOL ID               |VERSION         |REPO       |
|----------------------|----------------|-----------|
|health                |  2.1.2         |central    |
|health                |* 2.1.1         |central    |

2 tools found.
```

## `bal help`

To make sure that the tool is installed, we can type `bal help`.

``` bash
% bal help
```

We can use `bal help health` to get more information about the `health` tool.

``` bash
% bal help health
```

## `bal tool use`

The `bal tool use` command is used to set the active version of the tool.

``` bash
bal tool use health:2.1.2
bal tool use health:2.1.1
```

## `bal tool remove`

The `bal tool remove` command is used to remove a tool from the local machine.

``` bash
% bal tool remove health:2.1.2
```

## `bal tool update`

The `bal tool update` command is used to update the tool to the latest version.

``` bash
% bal tool update health
```







