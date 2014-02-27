# File: init_and_run_atg_publishing.py
# Purpose: put deploymentTopology.xml into ATG BCC and run deployment (publishing) process.
# Author: anton.panasenko@gmail.com https://github.com/dieu
# 
# Changes:
#  some refactoring: devide code on few functions
#  add tar check and repeat uploading if not number
 
from HTMLParser import HTMLParser
import requests
import argparse
import time
 
def login():
	r = requests.get("http://%s/atg/bcc/" % host)
 
	class SessionParser(HTMLParser):
	    def handle_starttag(self, tag, attrs):
	        if tag == "input":
	        	if filter(lambda value: value == (u"name", u"_dynSessConf"), attrs):
	        		for k,v in attrs:
	        			if k == "value":
	        				global session
	        				session = v
	       	return
	    
	SessionParser().feed(r.text)
 
	cookies = {
		"JSESSIONID": r.cookies['JSESSIONID']
	}
 
	r = requests.post(
		"http://%s/atg/bcc/home?_DARGS=/atg/user/html/login.jsp" % host,
		data={
			"_dyncharset": "UTF-8",
			"_dynSessConf": session,
			"/atg/userprofiling/InternalProfileFormHandler.loginSuccessURL": "/atg/bcc/home",
			"/atg/userprofiling/InternalProfileFormHandler.loginErrorURL": "/atg/bcc/home?paf_portalId=default&paf_communityId=100001&paf_pageId=100001&paf_dm=shared",
			"login": user,
			"/atg/userprofiling/InternalProfileFormHandler.login": "Log In",
			"/atg/userprofiling/InternalProfileFormHandler.value.password": password,
			"_D:/atg/userprofiling/InternalProfileFormHandler.loginSuccessURL": " ",
			"_D:/atg/userprofiling/InternalProfileFormHandler.loginErrorUR": " ",
			"_D:login": " ",
			"_D:/atg/userprofiling/InternalProfileFormHandler.value.password": " ",
			"_D:/atg/userprofiling/InternalProfileFormHandler.login": " ",
			"_DARGS": "/atg/user/html/login.jsp",
		},
		headers={
			"Origin": "http://%s" % host,
			"Accept-Encoding": "gzip,deflate,sdch",
			"Connection": "keep-alive",
			"Cache-Control": "max-age=0",
		},
		cookies=cookies,
		allow_redirects=True,
	)
 
	print r.status_code
 
	return session, cookies
 
 
def upload_deployment_topology(session, cookies, topology):
	data = {
		"_dyncharset": "UTF-8",
		"_dynSessConf": session,
		"importFormSubmitted": "true",
		"/atg/epub/deployment/TopologyEditFormHandler.importIncremental": "foo",
		"_D:/atg/epub/deployment/TopologyEditFormHandler.importIncremental": " ",
		"_D:/atg/epub/deployment/TopologyEditFormHandler.uploadedDefinitionFile": " ",	
		"_DARGS": "/PubPortlets/html/DeploymentPortlet/config/iframes/action_import.jsp.importFormFrame",
	}
 
	files = {"/atg/epub/deployment/TopologyEditFormHandler.uploadedDefinitionFile": open(topology, "rb")}
 
	#Upload deployment topology
	r = requests.post(
		"http://%s/PubPortlets/html/DeploymentPortlet/config/iframes/action_import.jsp?_DARGS=/PubPortlets/html/DeploymentPortlet/config/iframes/action_import.jsp.importFormFrame" % host,
		data=data,
		files=files,
		cookies=cookies,
		headers={
			"Referer": "http://%s/PubPortlets/html/DeploymentPortlet/config/iframes/action_import.jsp" % host,
			"Origin": "http://%s" % host,
			"Accept-Encoding": "gzip,deflate,sdch",
			"Connection": "keep-alive",
			"Cache-Control": "max-age=0",
		},
		allow_redirects=True
	)
	return r.status_code
 
 
#menu is configuration or overview
#key is D1_tar 
def get_tar_id(menu="configuration", key="D1_tar"):
	r = requests.get(
		"http://" + host + "/atg/atgadmin/home",
		params={
			"paf_portalId": "default",
			"paf_communityId": 100002,
			"paf_pageId": 100002,
			"paf_dm": "shared",
			"paf_gear_id": 1100007,
			"paf_gm": "content",
			"atg_admin_menu_group": "deployment",
			"atg_admin_menu_1": menu,
			"from_menu": "true",
		},
		headers={
			"Origin": "http://%s" % host,
			"Accept-Encoding": "gzip,deflate,sdch",
			"Connection": "keep-alive",
			"Cache-Control": "max-age=0",
		},
		cookies=cookies,
 
	)
 
	shift = len(key)
	index = r.text.find(key)
	tar = r.text[index+shift:index+shift+3]
	return tar, r.text
 
 
def change_live():
	#Chage live
	r = requests.get(
		"http://" + host + "/atg/atgadmin/home",
		params={
			"paf_portalId": "default",
			"paf_communityId": 100002,
			"paf_pageId": 100002,
			"paf_dm": "shared",
			"paf_gear_id": 1000006,
			"paf_gm": "content",
			"paf_ps": "_rp_1000006_make_changes_live=1_true&_rp_1000006_atg_admin_menu_group=1_deployment&_rp_1000006_atg_admin_menu_1=1_configuration&_pid=1000006"
		},
		headers={
			"Origin": "http://%s" % host,
			"Accept-Encoding": "gzip,deflate,sdch",
			"Connection": "keep-alive",
			"Cache-Control": "max-age=0",
		},
		cookies=cookies,
 
	)
 
	print r.status_code
 
	r = requests.post(
		"http://" + host + "/atg/atgadmin/home?paf_portalId=default&paf_communityId=100002&paf_pageId=100002&paf_dm=shared&paf_gear_id=1000006&paf_gm=content&paf_ps=_rp_1000006_make_changes_live%3D1_true%26_rp_1000006_atg_admin_menu_group%3D1_deployment%26_rp_1000006_atg_admin_menu_1%3D1_configuration%26_pid%3D1000006&_DARGS=/PubPortlets/html/DeploymentPortlet/config/config_make_live.jsp",
		data={
			"_dyncharset": "UTF-8",
			"_dynSessConf": session,
			"/atg/epub/deployment/TopologyEditFormHandler.surrogateTargetIDToInitOptionMap.tar" + tar: "true",
			"_D:/atg/epub/deployment/TopologyEditFormHandler.surrogateTargetIDToInitOptionMap.tar" + tar: " ",
			"_DARGS": "/PubPortlets/html/DeploymentPortlet/config/config_make_live.jsp",
			"/atg/epub/deployment/TopologyEditFormHandler.successURL": "/atg/atgadmin/home?paf_portalId=default&paf_communityId=100002&paf_pageId=100002&paf_dm=shared&paf_gear_id=1000006&paf_gm=content&paf_ps=_rp_1000006_atg_admin_menu_group%3D1_deployment%26_rp_1000006_from_menu%3D1_true%26_rp_1000006_atg_admin_menu_1%3D1_configuration%26_rp_1000006_topology_changed%3D1_true%26_pid%3D1000006",
			"_D:/atg/epub/deployment/TopologyEditFormHandler.successURL": " ",
			"/atg/epub/deployment/TopologyEditFormHandler.failureURL": "/atg/atgadmin/home?paf_portalId=default&paf_communityId=100002&paf_pageId=100002&paf_dm=shared&paf_gear_id=1000006&paf_gm=content&paf_ps=_rp_1000006_make_changes_live%3D1_true%26_rp_1000006_atg_admin_menu_group%3D1_deployment%26_rp_1000006_atg_admin_menu_1%3D1_configuration%26_pid%3D1000006",
			"_D:/atg/epub/deployment/TopologyEditFormHandler.failureURL": " ",
			"/atg/epub/deployment/TopologyEditFormHandler.initializeTopology": "foo",
			"_D:/atg/epub/deployment/TopologyEditFormHandler.initializeTopology": " ",
		},
		headers={
			"Origin": "http://%s" % host,
			"Accept-Encoding": "gzip,deflate,sdch",
			"Connection": "keep-alive",
			"Cache-Control": "max-age=0",
		},
		cookies=cookies
	)
	return r.status_code
 
 
def deploy():
	#Deploy
	r = requests.get(
		"http://" + host + "/atg/atgadmin/home",
		params={
			"paf_portalId": "default",
			"paf_communityId": 100002,
			"paf_pageId": 100002,
			"paf_dm": "shared",
			"paf_gear_id": 1000006,
			"paf_gm": "content",
			"paf_ps": "_rp_1000006_atg_admin_menu_group=1_deployment&_rp_1000006_atg_admin_menu_1=1_overview&_rp_1000006_goto_details_tabs=1_true&_rp_1000006_target_id=1_tar" + tar + "&_pid=1000006"
		},
		headers={
			"Origin": "http://%s" % host,
			"Accept-Encoding": "gzip,deflate,sdch",
			"Connection": "keep-alive",
			"Cache-Control": "max-age=0",
		},
		cookies=cookies,
 
	)
 
	print r.status_code
 
	r = requests.post(
		"http://" + host + "/atg/atgadmin/home?paf_portalId=default&paf_communityId=100002&paf_pageId=100002&paf_dm=shared&paf_gear_id=1000006&paf_gm=content&paf_ps=_rp_1000006_atg_admin_menu_group%3D1_deployment%26_rp_1000006_site_tab_name%3D1_details%26_rp_1000006_atg_admin_menu_1%3D1_overview%26_rp_1000006_target_id%3D1_tar"+ tar + "%26_pid%3D1000006%26_rp_1000006_details_tabs%3D1_true&_DARGS=/PubPortlets/html/DeploymentPortlet/site/site_detail.jsp.fullSiteForm",
		data={
			"_dyncharset": "UTF-8",
			"_dynSessConf": session,
			"/atg/epub/deployment/DeploymentFormHandler.successURL": "/atg/atgadmin/home?paf_portalId=default&paf_communityId=100002&paf_pageId=100002&paf_dm=shared&paf_gear_id=1000006&paf_gm=content&paf_ps=_rp_1000006_atg_admin_menu_group%3D1_deployment%26_rp_1000006_site_tab_name%3D1_details%26_rp_1000006_atg_admin_menu_1%3D1_overview%26_rp_1000006_target_id%3D1_tar103%26_pid%3D1000006%26_rp_1000006_details_tabs%3D1_true",
			"_D:/atg/epub/deployment/DeploymentFormHandler.successURL": " ", 
			"/atg/epub/deployment/DeploymentFormHandler.failureURL": "/atg/atgadmin/home?paf_portalId=default&paf_communityId=100002&paf_pageId=100002&paf_dm=shared&paf_gear_id=1000006&paf_gm=content&paf_ps=_rp_1000006_atg_admin_menu_group%3D1_deployment%26_rp_1000006_site_tab_name%3D1_details%26_rp_1000006_atg_admin_menu_1%3D1_overview%26_rp_1000006_target_id%3D1_tar103%26_pid%3D1000006%26_rp_1000006_details_tabs%3D1_true",
			"_D:/atg/epub/deployment/DeploymentFormHandler.failureURL": " ", 
			"_DARGS": "/PubPortlets/html/DeploymentPortlet/site/site_detail.jsp.fullSiteForm",
			"/atg/epub/deployment/DeploymentFormHandler.fullDeployTarget": "tar" + tar, #TODO parametrazie
			"_D:/atg/epub/deployment/DeploymentFormHandler.fullDeployTarget": " " 
		},
		cookies=cookies,
		headers={
			"Referer": "http://" + host + "/atg/atgadmin?activity=adminConsole",
			"Origin": "http://%s" % host,
			"Accept-Encoding": "gzip,deflate,sdch",
			"Connection": "keep-alive",
			"Cache-Control": "max-age=0",	
			"Content-Type": "application/x-www-form-urlencoded",
		},
		allow_redirects=True
	)
	return r.status_code
 
 
def get_deployId():
	#Get index for progress bar
	r = requests.get(
		"http://" + host + "/atg/atgadmin/home",
		params={
			"paf_portalId": "default",
			"paf_communityId": 100002,
			"paf_pageId": 100002,
			"paf_dm": "shared",
			"paf_gear_id": 1000006,
			"paf_gm": "content",
			"paf_ps": "_rp_1000006_atg_admin_menu_group=1_deployment&_rp_1000006_atg_admin_menu_1=1_overview&_rp_1000006_goto_details_tabs=1_true&_rp_1000006_target_id=1_tar" + tar + "&_pid=1000006", #TODO param
		},
		cookies=cookies,
	)
 
	index = r.text.find("deployId")
	id = r.text[index+9:index+9+6]
	return id
 
 
parser = argparse.ArgumentParser(description='Deploy topology to ATG')
parser.add_argument('-host', type=str, dest="host", required=True,
                   help='atg host')
parser.add_argument('-port', type=str, dest="port", default="7103",
                   help='atg port')
parser.add_argument('-user', type=str, dest="user", required=True,
                   help='atg user')
parser.add_argument('-pass', type=str, dest="password", required=True,
                   help='atg password')
parser.add_argument('-f', type=str, dest="topology", default=None,
                   help='atg deployment topology')
 
 
 
args = parser.parse_args()
 
print "start"
 
host = args.host + ":" + args.port
user = args.user
password = args.password
topology = args.topology or "/tmp/deploymentTopologyExample.xml"
session = 1
tar = None
 
session, cookies = login()
 
while type(tar) is not int:	
	print upload_deployment_topology(session=session, cookies=cookies, topology=topology)
 
	print "trying get tar id"
	tar, response = get_tar_id()
	try: 
		tar = int(tar)		
	except ValueError: 
		print "error tar: "  + tar
		with open('/tmp/atg_output', 'w+') as httpResponseFile:
			httpResponseFile.write(response)
		time.sleep(1 * 30)
 
tar = str(tar)
print "tar: " + tar
 
status_code = change_live()
 
print status_code
 
time.sleep(1 * 30)
 
while type(tar) is not int:	
	print "trying get tar id"
	tar, response = get_tar_id("overview")
	try: 
		tar = int(tar)
	except ValueError:
		print "error tar: "  + tar 
		with open('/tmp/atg_output', 'w+') as httpResponseFile:
			httpResponseFile.write(response)
		time.sleep(1 * 30)
		
 
tar = str(tar)
print "tar: " + tar
 
print deploy()
 
time.sleep(1 * 15)
 
id = get_deployId()
 
procente = 0
while procente != "100" and procente != "GIN":
	
	time.sleep(1 * 30)
 
	#Get progress
	r = requests.get(
		"http://" + host + "/PubPortlets/html/DeploymentPortlet/site/site_progress_bar.jsp",
		params={
			"deployId": id,
		},
		cookies=cookies,
	)
 
	index = r.text.find("<strong>")
	procente = r.text[index+8:index+8+3]
	print procente
 
print "end"