# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import re
import yaml


def test_defaults(plan_summary):
  "Test defalt configuration."
  # _, output = apply_runner(mysql_password='foo')
  summary = plan_summary('modules/cloud-config-container/mysql/',
                         mysql_password='foo')
  cloud_config = summary.outputs['cloud_config']['value']
  yaml.safe_load(cloud_config)
  assert cloud_config.startswith('#cloud-config')
  assert re.findall(r'(?m)^\s+\-\s*path:\s*(\S+)', cloud_config) == [
      '/var/lib/docker/daemon.json', '/run/mysql/secrets/mysql-passwd.txt',
      '/etc/systemd/system/mysql.service'
  ]
  assert 'gcloud' not in cloud_config


def test_kms(plan_summary):
  "Test KMS configuration."
  kms_config = (
      '{project_id="my-project", keyring="my-keyring", location="eu", key="foo"}'
  )
  summary = plan_summary('modules/cloud-config-container/mysql/',
                         mysql_password='foo', kms_config=kms_config)
  cloud_config = summary.outputs['cloud_config']['value']
  yaml.safe_load(cloud_config)
  assert cloud_config.startswith('#cloud-config')
  assert re.findall(r'(?m)^\s+\-\s*path:\s*(\S+)', cloud_config) == [
      '/var/lib/docker/daemon.json',
      '/run/mysql/secrets/mysql-passwd-cipher.txt', '/run/mysql/passwd.sh',
      '/etc/systemd/system/mysql.service'
  ]
  assert 'gcloud' in cloud_config
