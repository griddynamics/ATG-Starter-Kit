#### Previous Step: [Launch the Application](docs/step-4-launch-guide.md)

#(Optional) Modify and Update Custom CRS with ATG Starter Kit

##Steps

1. Create a git repo based on the folder "CommerceReferenceStore/Store," which is located in the ATG root directory ($DYNAMO_ROOT) of the launched instance.
2. To create a module and add it to the CRS, perform the following steps:

	A. Create a new module folder in root of git repo.
	
	B. Create a META-INF/MANIFEST.MF file describing the module similarly to the ATG module manifest (see FAQ 1).
	
	C. Create src/Java and src/config (see FAQ 2) folders in them module's root. All code must be in src/Java folder; however, it doesn't need to be compiled (see FAQ 1).
	
	D. Create file build.xml in module's root folder (see Appendix A).
	
	E. Create file build.properties in module's root folder (see Appendix B and FAQ 1).
	
	F. Add to modules.build.order of build.properties (in root of git repo) the path to your module's build.xml (e.g. modules.build.order=...,CUSTOM_MODULE_PATH/build.xml).
	
	G. Add your module to ATG-Required of Storefront/META-INF/MANIFEST.MF to include it in ear assembly (e.g., ATG-Required: ... Store.CUSTOM_MODULE_NAME).
	
	H. To generate JavaDoc for your module, add element <pathelement path="${basedir}/CUSTOM_MODULE_PATH/${relative.src.dir}"/> to <path id="javadoc.sourcepath"> of build.xml file (in root of git repo).
	
3. Update the application instance.

##FAQ

1. Why is the existence of ATG-Class-Path (with at least one jar) mandatory in the module's manifest? 

When we tried to deploy an instance without an empty jar added to ATG-Class-Path (e.g. ATG-Class-Path: lib/classes.jar, where classes.jar is empty archive), Nucleus didn't create our components. The same problem occurs in the build.properties file of module with property classpath. If it isn't specified or doesn't point to at least an empty jar, then the components will not be created. All the instance's sources are compiled from src/Java, so ATG-Class-Path and own compiling/packaging of code are redundant.

2. What is the purpose of folder src/config for configuration files? 

The properties of components are loaded by Nucleus from ATG-Config-Path.

##Appendix A. build.xml example

	<project name="CUSTOM_MODULE_NAME" default="all" basedir=".">
		<property name="global.dir" value="${basedir}/.."/>
		<import file="${global.dir}/buildtools/common.xml"/>
	</project>

##Appendix B. build.properties

	# @version $Id: //hosting-blueprint/B2CBlueprint/version/10.2/Recommendations/build-base.properties#1 $$Change: 788278 $
	# ---------------------------------------------------------------------------------
	# Note: The property global.dir is specified in this module's build.xml.  Make sure
	# this is set properly, especially if you are building a nested module structure
	#

	# ---------------------------------------------------------------------------------
	# This properties file is used to identify the name of this module and any
	# specific values for tasks unique to this module
	#
	# These identify the module tree structure of this deployed submodule
	#
	module.parent=${module.root.parent}
	module.name=CUSTOM_MODULE_NAME

	# Installation directory
	install.dir=${dynamo.root.dir}/${install.unit}/${module.parent}/${module.name}

	# Define a classpath that needs to be included in addition to common dynamo.classpath
	# to compile this module.
	# We need to do this since this module depends on classes in EStore module.
	classpath=${dynamo.root.dir}/${install.unit}/${module.parent}/CUSTOM_MODULE_PATH/lib/classes.jar

##Appendix C. Nomenclature

	CUSTOM_MODULE_NAME - name of your module
	CUSTOM_MODULE_PATH - relative path to your module starting from git repo root

