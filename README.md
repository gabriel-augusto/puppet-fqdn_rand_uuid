# fqdn_rand_uuid

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with fqdn_rand_uuid](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

## Module Description

The fqdn_rand_uuid module provides the `fqdn_rand_uuid([$seed])`-function.
This function is used to generate UUIDs that are scoped to the node.

By providing different values for `$seed`, multiple UUIDs can be generated.

## Setup

Installing this module makes the `fqdn_rand_uuid([$seed])`-function available.

## Usage

This function is called with an optional seed value.
The FQDN of the node combined with the seed value is used to generate the UUID.
The returned UUID is in the form of a string, without curly braces.
(E.g. "1d839dea-5e10-5243-88eb-e66815bd7d5c").

Example:

    $uuid = fqdn_rand_uuid('test')
    notice($uuid) # Will print something like "1d839dea-5e10-5243-88eb-e66815bd7d5c".

## Reference

This module generates a [version 5 UUID](https://tools.ietf.org/html/rfc4122#section-4.3) in its own custom namespace.
The namespace used is `0b7a81ff-db8d-42fe-8d9f-768ea5b8ed1a`.

The input to the UUID generator is the FQDN followed by a null byte followed by the seed value.

The equivalent Python code to generate the UUID is:

```
import uuid
def fqdn_rand_uuid(fqdn, seed=None):
    namespace = uuid.UUID('0b7a81ff-db8d-42fe-8d9f-768ea5b8ed1a')
    name = fqdn
    if seed is not None:
        name += '\0' + seed
    return str(uuid.uuid5(namespace, name))
```
