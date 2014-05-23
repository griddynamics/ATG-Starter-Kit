#!/usr/bin/python
# Copyright (c) 2013 Qubell Inc., http://qubell.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import logging
import os
import unittest

from qubell.api.private.platform import QubellPlatform, Context
from qubell.api.private.testing import BaseTestCase


parameters = {
    'organization': os.getenv('QUBELL_ORGANIZATION', None),
    'user': os.environ['QUBELL_USER'],
    'pass': os.environ['QUBELL_PASS'],
    'tenant': os.environ['QUBELL_TENANT'],
    'provider_name': os.getenv('PROVIDER_NAME', "test-provider"),
    'provider_type': os.environ['PROVIDER_TYPE'],
    'provider_identity': os.environ['PROVIDER_IDENTITY'],
    'provider_credential': os.environ['PROVIDER_CREDENTIAL'],
    'provider_region': os.environ['PROVIDER_REGION']
}

context = Context(user=parameters['user'], password=parameters['pass'], api=parameters['tenant'])
platform = QubellPlatform(context=context)
assert platform.authenticate()


class BaseComponentTestCase(BaseTestCase):
    platform = platform
    parameters = parameters
    apps = []

    @classmethod
    def timeout(cls):
      return 40

    @classmethod
    def environment(cls, organization):
        base_env = super(BaseComponentTestCase, cls).environment(organization)

        base_env['applications'] = cls.apps

        return base_env

if __name__ == '__main__':
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)

    unittest.main(argv=["qubell-test-runner", "discover", "--pattern=test*.py", "-v"])
