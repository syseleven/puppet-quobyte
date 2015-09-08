puppet-quobyte
===============

# Puppet recipes for setting up Quobyte

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

### Overview

This module sets up Quobyte. It follows the profile/role pattern, i.e. it
contains profile classes for services and other atomic pieces of configuration
such as provisioning the quobyte repo. These profiles are aggregated into roles to be
assigned to machines in an OpenStack cloud.


### Sample Usage with hiera

```
quobyte::profile::server::config::dir_service: 'node1.tld:7861,node2.tld:7861,node3.tld:7861'
quobyte::profile::server::config::api_service: 'http://node1.tld:7860'
quobyte::profile::common::repo::repo_url: 'https://support.quobyte.com/repo/[...]/xUbuntu_14.04'
quobyte::profile::common::repo::repo_key: '[...]'
quobyte::profile::common::repo::repo_key_source: 'https://support.quobyte.com/repo/[...]/xUbuntu_14.04/Release.key'

# Which block devices to turn into Quobyte Data Devices.
# This will partition and format the device, potentially destroying existing data!
quobyte::profile::disks::diskroles:
  /dev/sdb: REGISTRY
  /dev/sdc: METADATA
  /dev/sdd: DATA
  /dev/sde: DATA
```
