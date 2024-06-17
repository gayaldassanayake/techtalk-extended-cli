# `bal tool` Usage

This document goes through the usage of the `bal tool` command through the life-cycle of the `bal health` tool.

`bal tool` has a set of sub-commands that allows managing the tool life cycle.

## `bal tool search`

The `bal tool search` command is used to search for tool information in the Ballerina Central.

Let's do a `bal tool search` on the `health` tool. The health tool generates Ballerina library packages and Ballerina templates for developing healthcare integrations.

```
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
```
% bal tool pull health
ballerinax/health:2.1.2 [central.ballerina.io ->/Users/gayaldassanayake/.ballerina/repositories/central.ballerina.io/bala/ballerinax/health/2.1.2]  100% [=====================] 93313/93313 KB (0:00:08 / 0:00:00)
ballerinax/health:2.1.2 pulled from central successfully

tool 'health:2.1.2' pulled successfully.
tool 'health:2.1.2' successfully set as the active version.
```

Alternatively we can specify a version to pull a specific version of the tool.

```
% bal tool pull health:2.1.1
ballerinax/health:2.1.1 [central.ballerina.io ->/Users/gayaldassanayake/.ballerina/repositories/central.ballerina.io/bala/ballerinax/health/2.1.1]  100% [=====================] 93539/93539 KB (0:00:13 / 0:00:00)
ballerinax/health:2.1.1 pulled from central successfully

tool 'health:2.1.1' pulled successfully.
tool 'health:2.1.1' successfully set as the active version.
```

## `bal tool list`

The `bal tool list` command lists the tools that are installed in the local machine.

```
% bal tool list
|TOOL ID               |VERSION         |REPO       |
|----------------------|----------------|-----------|
|health                |  2.1.2         |central    |
|health                |* 2.1.1         |central    |

2 tools found.
```

## `bal help`

To make sure that the tool is installed, we can type `bal help`.

```
% bal help
NAME
       The build system and package manager of Ballerina

SYNOPSIS
       bal <command> [args]
       bal [OPTIONS]


OPTIONS
       -v, --version
           Print version information.

       -h, --help
           Print the usage details of a command.


COMMANDS
        The available subcommands are:

   Core Commands:
        build           Compile the current package
        run             Compile and run the current package
        test            Run package tests
        doc             Generate current package's documentation
        pack            Create distribution format of the current package

   Package Commands:
        new             Create a new Ballerina package
        add             Add a new Ballerina module to the current package
        pull            Pull a package from Ballerina Central
        push            Publish a package to Ballerina Central
        search          Search Ballerina Central for packages
        semver          Show SemVer compatibility and local package changes against
                        published packages in Ballerina Central
        graph           Print the dependency graph in the console
        deprecate       Deprecate a package in Ballerina Central

   Other Commands:
        clean           Clean the artifacts generated during the build
        format          Format Ballerina source files
        grpc            Generate the Ballerina sources for a given Protocol
                        Buffer definition
        graphql         Generate the GraphQL schema for a Ballerina GraphQL service,
                        generate the Ballerina GraphQL service for a GraphQL schema,
                        and generate the Ballerina client sources for a GraphQL config
                        file [Experimental]
        openapi         Generate the Ballerina sources for a given OpenAPI
                        definition and vice versa
        asyncapi        Generate the Ballerina sources for a given AsyncAPI definition
        persist         Manage data persistence
        bindgen         Generate the Ballerina bindings for Java APIs
        shell           Run Ballerina interactive REPL [Experimental]
        tool            Manage Ballerina CLI tools
        version         Print the Ballerina version
        profile         Start Ballerina Profiler [Experimental]

   Tool Commands:
        health          Ballerina Health Artifact Generator Tool

   Update Commands:
        dist            Manage Ballerina distributions
        update          Update the Ballerina tool

Use 'bal help <command>' for more information on a specific command.
```

We can use `bal help health` to get more information about the `health` tool.

```
% bal help health
NAME
        ballerina-health - Generate a Ballerina package or template for a
        given health specification (eg.:FHIR implementation guides) files.

SYNOPSIS
        bal health fhir [-m | --mode] package --package-name <package-name> \
                        <FHIR-specification-directory-path>
                        [-m | --mode] template --dependent-package <dependent-package> \
                        <FHIR-specification-directory-path>

DESCRIPTION
        Generate a Ballerina package or template with relevant records and types
        from a given health specification (eg.:FHIR implementation guides) files.

        The generated Ballerina sources will be written into the provided
        output location. Make sure to add the directory path which contains
        FHIR specification, as the last argument.

        You can download FHIR specification files from the respective
        Implementation Guide's official website. (Published list of
        Implementation Guides can be found in http://fhir.org/guides/registry/)

        The ballerina-health tool is compatible with Ballerina
        version 2201.8.1 (Swan Lake Update 8) onwards.

OPTIONS
       -v, --version
            Print version information.

       -h, --help
            Print the usage details of a command.

COMMANDS
        fhir
            Refer to the FHIR specification when generating the Ballerina artifacts.

            OPTIONS
                    -m, --mode <mode-type>
                        Mode can be 'package' or 'template'. If the mode is set to
                        'package', a Ballerina package will be generated including all the
                        records and types. If the mode is set to ?template?, tool will
                        generate Ballerina templates for each FHIR resource definition
                        available in the specified path. This is a MANDATORY input for fhir
                        command.

                    --package-name <name-of-package>
                        Only applicable in ?package? mode. Name of the Ballerina package
                        to be generated. This is a MANDATORY input in ?package? mode.
                        Refer https://ballerina.io/learn/package-references/#the-name-field

                    --dependent-package <qualified-ballerina-package-name>
                        Only applicable in ?template? mode. Fully qualified name of the
                        published Ballerina package containing IG resources
                        [eg: <org>/<package>]. This option can be used to generate
                        templates specifically for the resources in the given IG. The
                        package name part of this value will be added as a prefix to the
                        template name. This is a MANDATORY input in ?template? mode.

                    -o, --output <output>
                        Location of the generated Ballerina artifacts. If this
                        path is not specified, the output will be written to
                        the same directory from which the command is run.

                    --org-name <org-name-of-the-package>
                        Organization name of the Ballerina package/template to be generated.
                        Refer https://ballerina.io/learn/package-references/#the-org-field

                    --package-version <version-of-the-package>
                        Version of the Ballerina package/template to be generated.
                        Refer https://semver.org/

                    --included-profile <profiles-to-included>
                        Only applicable in ?template? mode. If only a specific profile/s
                        needs to be generated as templates, specify the profile URL as the
                        value of this parameter. This argument can be used more than once.

                    --excluded-profile <profiles-to-excluded>
                        Only applicable in ?template? mode. If only a specific profile/s
                        needs to be skipped when generating templates, specify the
                        profile URL as the value of this parameter. This argument
                        can be used more than once.

            EXAMPLES
                    Generate a Ballerina package for the FHIR artifacts of USCore
                    implementation guide.
                        $ bal health fhir -m package --package-name uscore401 \
                        ./path_to_uscore_definitions

                    Generate a Ballerina package for the FHIR artifacts of
                    USCore implementation guide and write the output
                    to the given directory.
                        $ bal health fhir -m package --package-name uscore401 \
                        -o ./output_path ./path_to_uscore_definitions

                    Generate Ballerina templates for all the FHIR resource profiles
                    of USCore implementation guide.
                        $ bal health fhir -m template \
                        --dependent-package ballerinax/health.fhir.r4.uscore501 \
                        ./path_to_uscore_definitions
```

## `bal tool use`

The `bal tool use` command is used to set the active version of the tool.

```
% bal tool use health:2.1.2
tool 'health:2.1.2' successfully set as the active version.
bal tool use health:2.1.1
% bal tool use health:2.1.1
tool 'health:2.1.1' successfully set as the active version.
```

## `bal tool remove`

The `bal tool remove` command is used to remove a tool from the local machine.

```
% bal tool remove health:2.1.2
tool 'health:2.1.2' successfully removed.
```

## `bal tool update`

The `bal tool update` command is used to update the tool to the latest version.

```
% bal tool update health
ballerinax/health:2.1.2 [central.ballerina.io ->/Users/gayaldassanayake/.ballerina/repositories/central.ballerina.io/bala/ballerinax/health/2.1.2]  100% [=====================] 94018/94018 KB (0:00:52 / 0:00:00)
ballerinax/health:2.1.2 pulled from central successfully

tool 'health:2.1.2' pulled successfully.
tool 'health:2.1.2' successfully set as the active version.
```







