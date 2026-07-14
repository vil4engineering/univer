#!/usr/bin/env python3
"""Generate AIWorkspace.xcodeproj from Swift sources."""

import hashlib
import os
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PROJECT_NAME = "AIWorkspace"
BUNDLE_ID = "com.aiworkspace.app"

def uid(seed: str) -> str:
    return hashlib.md5(seed.encode()).hexdigest()[:24].upper()

def collect_files():
    sources = sorted((ROOT / PROJECT_NAME).rglob("*.swift"))
    resources = []
    for pattern in ["**/*.plist", "**/*.xcassets/**/Contents.json"]:
        resources.extend(sorted((ROOT / PROJECT_NAME / "Resources").glob(pattern.split("/")[-1])))
    assets = ROOT / PROJECT_NAME / "Resources" / "Assets.xcassets"
    plist = ROOT / PROJECT_NAME / "Resources" / "Info.plist"
    tests = sorted((ROOT / "AIWorkspaceTests").rglob("*.swift"))
    return sources, plist, assets, tests

def pbxproj_content(sources, plist, assets, tests):
    source_refs = []
    source_build = []
    test_refs = []
    test_build = []

    for path in sources:
        rel = path.relative_to(ROOT).as_posix()
        ref_id = uid(f"ref:{rel}")
        build_id = uid(f"build:{rel}")
        source_refs.append(f'\t\t{ref_id} /* {path.name} */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "{path.name}"; sourceTree = "<group>"; }};')
        source_build.append(f'\t\t{build_id} /* {path.name} in Sources */ = {{isa = PBXBuildFile; fileRef = {ref_id} /* {path.name} */; }};')

    for path in tests:
        rel = path.relative_to(ROOT).as_posix()
        ref_id = uid(f"ref:{rel}")
        build_id = uid(f"build:{rel}")
        test_refs.append(f'\t\t{ref_id} /* {path.name} */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = "{path.name}"; sourceTree = "<group>"; }};')
        test_build.append(f'\t\t{build_id} /* {path.name} in Sources */ = {{isa = PBXBuildFile; fileRef = {ref_id} /* {path.name} */; }};')

    plist_ref = uid("ref:plist")
    assets_ref = uid("ref:assets")
    app_target = uid("target:app")
    test_target = uid("target:test")
    app_sources_phase = uid("phase:app:sources")
    app_resources_phase = uid("phase:app:resources")
    test_sources_phase = uid("phase:test:sources")
    project_id = uid("project")
    main_group = uid("group:main")
    products_group = uid("group:products")
    app_product = uid("product:app")
    test_product = uid("product:test")
    config_list_project = uid("configlist:project")
    config_list_app = uid("configlist:app")
    config_list_test = uid("configlist:test")
    debug_project = uid("config:debug:project")
    release_project = uid("config:release:project")
    debug_app = uid("config:debug:app")
    release_app = uid("config:release:app")
    debug_test = uid("config:debug:test")
    release_test = uid("config:release:test")

    # Simplified flat group — Xcode resolves paths via recursive folder references in real projects;
    # for portfolio scaffold, use project.yml + XcodeGen on macOS for proper groups.
    source_build_entries = "\n".join(f"\t\t\t\t{uid(f'build:{p.relative_to(ROOT).as_posix()}')} /* {p.name} in Sources */," for p in sources)
    test_build_entries = "\n".join(f"\t\t\t\t{uid(f'build:{p.relative_to(ROOT).as_posix()}')} /* {p.name} in Sources */," for p in tests)

    all_file_refs = "\n".join(source_refs + test_refs)
    all_build_files = "\n".join(source_build + test_build)

    return f'''// !$*UTF8*$!
{{
\tarchiveVersion = 1;
\tclasses = {{
\t}};
\tobjectVersion = 56;
\tobjects = {{

/* Begin PBXBuildFile section */
{all_build_files}
\t\t{uid("build:assets")} /* Assets.xcassets in Resources */ = {{isa = PBXBuildFile; fileRef = {assets_ref} /* Assets.xcassets */; }};
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
\t\t{app_product} /* {PROJECT_NAME}.app */ = {{isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "{PROJECT_NAME}.app"; sourceTree = BUILT_PRODUCTS_DIR; }};
\t\t{test_product} /* {PROJECT_NAME}Tests.xctest */ = {{isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "{PROJECT_NAME}Tests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; }};
{all_file_refs}
\t\t{plist_ref} /* Info.plist */ = {{isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; }};
\t\t{assets_ref} /* Assets.xcassets */ = {{isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; }};
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
\t\t{uid("phase:app:frameworks")} /* Frameworks */ = {{
\t\t\tisa = PBXFrameworksBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t}};
\t\t{uid("phase:test:frameworks")} /* Frameworks */ = {{
\t\t\tisa = PBXFrameworksBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t}};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
\t\t{main_group} = {{
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
\t\t\t\t{uid("group:app")} /* {PROJECT_NAME} */,
\t\t\t\t{uid("group:tests")} /* {PROJECT_NAME}Tests */,
\t\t\t\t{products_group} /* Products */,
\t\t\t);
\t\t\tsourceTree = "<group>";
\t\t}};
\t\t{products_group} /* Products */ = {{
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
\t\t\t\t{app_product} /* {PROJECT_NAME}.app */,
\t\t\t\t{test_product} /* {PROJECT_NAME}Tests.xctest */,
\t\t\t);
\t\t\tname = Products;
\t\t\tsourceTree = "<group>";
\t\t}};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
\t\t{app_target} /* {PROJECT_NAME} */ = {{
\t\t\tisa = PBXNativeTarget;
\t\t\tbuildConfigurationList = {config_list_app} /* Build configuration list for PBXNativeTarget "{PROJECT_NAME}" */;
\t\t\tbuildPhases = (
\t\t\t\t{app_sources_phase} /* Sources */,
\t\t\t\t{uid("phase:app:frameworks")} /* Frameworks */,
\t\t\t\t{app_resources_phase} /* Resources */,
\t\t\t);
\t\t\tbuildRules = (
\t\t\t);
\t\t\tdependencies = (
\t\t\t);
\t\t\tname = "{PROJECT_NAME}";
\t\t\tproductName = "{PROJECT_NAME}";
\t\t\tproductReference = {app_product} /* {PROJECT_NAME}.app */;
\t\t\tproductType = "com.apple.product-type.application";
\t\t}};
\t\t{test_target} /* {PROJECT_NAME}Tests */ = {{
\t\t\tisa = PBXNativeTarget;
\t\t\tbuildConfigurationList = {config_list_test} /* Build configuration list for PBXNativeTarget "{PROJECT_NAME}Tests" */;
\t\t\tbuildPhases = (
\t\t\t\t{test_sources_phase} /* Sources */,
\t\t\t\t{uid("phase:test:frameworks")} /* Frameworks */,
\t\t\t);
\t\t\tbuildRules = (
\t\t\t);
\t\t\tdependencies = (
\t\t\t\t{uid("dep:test")} /* PBXTargetDependency */,
\t\t\t);
\t\t\tname = "{PROJECT_NAME}Tests";
\t\t\tproductName = "{PROJECT_NAME}Tests";
\t\t\tproductReference = {test_product} /* {PROJECT_NAME}Tests.xctest */;
\t\t\tproductType = "com.apple.product-type.bundle.unit-test";
\t\t}};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
\t\t{project_id} /* Project object */ = {{
\t\t\tisa = PBXProject;
\t\t\tattributes = {{
\t\t\t\tBuildIndependentTargetsInParallel = 1;
\t\t\t\tLastSwiftUpdateCheck = 1600;
\t\t\t\tLastUpgradeCheck = 1600;
\t\t\t}};
\t\t\tbuildConfigurationList = {config_list_project} /* Build configuration list for PBXProject "{PROJECT_NAME}" */;
\t\t\tcompatibilityVersion = "Xcode 14.0";
\t\t\tdevelopmentRegion = en;
\t\t\thasScannedForEncodings = 0;
\t\t\tknownRegions = (
\t\t\t\ten,
\t\t\t\tBase,
\t\t\t);
\t\t\tmainGroup = {main_group};
\t\t\tproductRefGroup = {products_group} /* Products */;
\t\t\tprojectDirPath = "";
\t\t\tprojectRoot = "";
\t\t\ttargets = (
\t\t\t\t{app_target} /* {PROJECT_NAME} */,
\t\t\t\t{test_target} /* {PROJECT_NAME}Tests */,
\t\t\t);
\t\t}};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
\t\t{app_resources_phase} /* Resources */ = {{
\t\t\tisa = PBXResourcesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
\t\t\t\t{uid("build:assets")} /* Assets.xcassets in Resources */,
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t}};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
\t\t{app_sources_phase} /* Sources */ = {{
\t\t\tisa = PBXSourcesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
{source_build_entries}
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t}};
\t\t{test_sources_phase} /* Sources */ = {{
\t\t\tisa = PBXSourcesBuildPhase;
\t\t\tbuildActionMask = 2147483647;
\t\t\tfiles = (
{test_build_entries}
\t\t\t);
\t\t\trunOnlyForDeploymentPostprocessing = 0;
\t\t}};
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
\t\t{uid("dep:test")} /* PBXTargetDependency */ = {{
\t\t\tisa = PBXTargetDependency;
\t\t\ttarget = {app_target} /* {PROJECT_NAME} */;
\t\t\ttargetProxy = {uid("proxy:test")} /* PBXContainerItemProxy */;
\t\t}};
/* End PBXTargetDependency section */

/* Begin XCBuildConfiguration section */
\t\t{debug_project} /* Debug */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tALWAYS_SEARCH_USER_PATHS = NO;
\t\t\t\tCLANG_ENABLE_MODULES = YES;
\t\t\t\tDEBUG_INFORMATION_FORMAT = dwarf;
\t\t\t\tENABLE_TESTABILITY = YES;
\t\t\t\tGCC_DYNAMIC_NO_PIC = NO;
\t\t\t\tGCC_OPTIMIZATION_LEVEL = 0;
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 18.0;
\t\t\t\tONLY_ACTIVE_ARCH = YES;
\t\t\t\tSDKROOT = iphoneos;
\t\t\t\tSWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
\t\t\t\tSWIFT_OPTIMIZATION_LEVEL = "-Onone";
\t\t\t\tSWIFT_STRICT_CONCURRENCY = complete;
\t\t\t\tSWIFT_VERSION = 6.0;
\t\t\t}};
\t\t\tname = Debug;
\t\t}};
\t\t{release_project} /* Release */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tALWAYS_SEARCH_USER_PATHS = NO;
\t\t\t\tCLANG_ENABLE_MODULES = YES;
\t\t\t\tDEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 18.0;
\t\t\t\tSDKROOT = iphoneos;
\t\t\t\tSWIFT_COMPILATION_MODE = wholemodule;
\t\t\t\tSWIFT_STRICT_CONCURRENCY = complete;
\t\t\t\tSWIFT_VERSION = 6.0;
\t\t\t\tVALIDATE_PRODUCT = YES;
\t\t\t}};
\t\t\tname = Release;
\t\t}};
\t\t{debug_app} /* Debug */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
\t\t\t\tCODE_SIGN_STYLE = Automatic;
\t\t\t\tCURRENT_PROJECT_VERSION = 1;
\t\t\t\tGENERATE_INFOPLIST_FILE = NO;
\t\t\t\tINFOPLIST_FILE = {PROJECT_NAME}/Resources/Info.plist;
\t\t\t\tLD_RUNPATH_SEARCH_PATHS = (
\t\t\t\t\t"$(inherited)",
\t\t\t\t\t"@executable_path/Frameworks",
\t\t\t\t);
\t\t\t\tMARKETING_VERSION = 1.0;
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = {BUNDLE_ID};
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tTARGETED_DEVICE_FAMILY = "1,2";
\t\t\t}};
\t\t\tname = Debug;
\t\t}};
\t\t{release_app} /* Release */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
\t\t\t\tCODE_SIGN_STYLE = Automatic;
\t\t\t\tCURRENT_PROJECT_VERSION = 1;
\t\t\t\tGENERATE_INFOPLIST_FILE = NO;
\t\t\t\tINFOPLIST_FILE = {PROJECT_NAME}/Resources/Info.plist;
\t\t\t\tLD_RUNPATH_SEARCH_PATHS = (
\t\t\t\t\t"$(inherited)",
\t\t\t\t\t"@executable_path/Frameworks",
\t\t\t\t);
\t\t\t\tMARKETING_VERSION = 1.0;
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = {BUNDLE_ID};
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tTARGETED_DEVICE_FAMILY = "1,2";
\t\t\t}};
\t\t\tname = Release;
\t\t}};
\t\t{debug_test} /* Debug */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tBUNDLE_LOADER = "$(TEST_HOST)";
\t\t\t\tCODE_SIGN_STYLE = Automatic;
\t\t\t\tCURRENT_PROJECT_VERSION = 1;
\t\t\t\tGENERATE_INFOPLIST_FILE = YES;
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 18.0;
\t\t\t\tMARKETING_VERSION = 1.0;
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = {BUNDLE_ID}.tests;
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tSWIFT_EMIT_LOC_STRINGS = NO;
\t\t\t\tTARGETED_DEVICE_FAMILY = "1,2";
\t\t\t\tTEST_HOST = "$(BUILT_PRODUCTS_DIR)/{PROJECT_NAME}.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/{PROJECT_NAME}";
\t\t\t}};
\t\t\tname = Debug;
\t\t}};
\t\t{release_test} /* Release */ = {{
\t\t\tisa = XCBuildConfiguration;
\t\t\tbuildSettings = {{
\t\t\t\tBUNDLE_LOADER = "$(TEST_HOST)";
\t\t\t\tCODE_SIGN_STYLE = Automatic;
\t\t\t\tCURRENT_PROJECT_VERSION = 1;
\t\t\t\tGENERATE_INFOPLIST_FILE = YES;
\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 18.0;
\t\t\t\tMARKETING_VERSION = 1.0;
\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = {BUNDLE_ID}.tests;
\t\t\t\tPRODUCT_NAME = "$(TARGET_NAME)";
\t\t\t\tSWIFT_EMIT_LOC_STRINGS = NO;
\t\t\t\tTARGETED_DEVICE_FAMILY = "1,2";
\t\t\t\tTEST_HOST = "$(BUILT_PRODUCTS_DIR)/{PROJECT_NAME}.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/{PROJECT_NAME}";
\t\t\t}};
\t\t\tname = Release;
\t\t}};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
\t\t{config_list_project} /* Build configuration list for PBXProject "{PROJECT_NAME}" */ = {{
\t\t\tisa = XCConfigurationList;
\t\t\tbuildConfigurations = (
\t\t\t\t{debug_project} /* Debug */,
\t\t\t\t{release_project} /* Release */,
\t\t\t);
\t\t\tdefaultConfigurationIsVisible = 0;
\t\t\tdefaultConfigurationName = Release;
\t\t}};
\t\t{config_list_app} /* Build configuration list for PBXNativeTarget "{PROJECT_NAME}" */ = {{
\t\t\tisa = XCConfigurationList;
\t\t\tbuildConfigurations = (
\t\t\t\t{debug_app} /* Debug */,
\t\t\t\t{release_app} /* Release */,
\t\t\t);
\t\t\tdefaultConfigurationIsVisible = 0;
\t\t\tdefaultConfigurationName = Release;
\t\t}};
\t\t{config_list_test} /* Build configuration list for PBXNativeTarget "{PROJECT_NAME}Tests" */ = {{
\t\t\tisa = XCConfigurationList;
\t\t\tbuildConfigurations = (
\t\t\t\t{debug_test} /* Debug */,
\t\t\t\t{release_test} /* Release */,
\t\t\t);
\t\t\tdefaultConfigurationIsVisible = 0;
\t\t\tdefaultConfigurationName = Release;
\t\t}};
/* End XCConfigurationList section */
\t}};
\trootObject = {project_id} /* Project object */;
}}
'''

def main():
    sources, plist, assets, tests = collect_files()
    content = pbxproj_content(sources, plist, assets, tests)
    proj_dir = ROOT / f"{PROJECT_NAME}.xcodeproj"
    proj_dir.mkdir(exist_ok=True)
    (proj_dir / "project.pbxproj").write_text(content)
    print(f"Generated {proj_dir / 'project.pbxproj'}")
    print(f"  Sources: {len(sources)}")
    print(f"  Tests: {len(tests)}")
    print("Note: For proper Xcode groups, prefer: xcodegen generate")

if __name__ == "__main__":
    main()
