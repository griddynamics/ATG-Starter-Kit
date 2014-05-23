import os

from test_runner import BaseComponentTestCase
from qubell.api.private.testing import environment, instance, workflow, values

@environment({
    "default": {},
    #"AmazonEC2_Centos_6.4": {
    #    "policies": [{
    #        "action": "provisionVms",
    #        "parameter": "imageId",
    #        "value": "us-east-1/ami-ee698586"
    #    }, {
    #        "action": "provisionVms",
    #        "parameter": "vmIdentity",
    #        "value": "root"
    #    }]
    #}
})
class ATGTestCase(BaseComponentTestCase):
    name = "ATG-Starter-Kit"
    apps = [{
        "name": name,
        "file": os.path.realpath(os.path.join(os.path.dirname(__file__), '../%s.yml' % name))
    },{
        "name": "Database",
        "url": "https://raw.github.com/qubell-bazaar/component-oracle-db-xe/master/component-oracle-db-xe.yml",
        "launch": False
    },{
        "name": "Application Server",
        "url": "https://raw.github.com/qubell-bazaar/component-oracle-weblogic/master/component-oracle-weblogic.yml", 
        "launch": False
    }]

    @instance(byApplication=name)
    @values({"endpoints.atg-store-prod": "url"})
    def test_url(self, instance, url):
      import requests

      response = requests.get(url, timeout=60)
      assert response.status_code==200
