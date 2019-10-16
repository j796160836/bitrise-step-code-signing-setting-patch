#!/bin/bash

# exit if a command fails
set -e

#
# Required parameters
if [ -z "${xcode_pbxproj_file}" ] ; then
  echo " [!] Missing required input: xcode_pbxproj_file"
  exit 1
fi
if [ ! -f "${xcode_pbxproj_file}" ] ; then
  echo " [!] File project.pbxproj doesn't exist at specified path: ${xcode_pbxproj_file}"
  exit 1
fi

if [ -z "${project_target}" ] ; then
  echo " [!] Missing required input: project_target"
  exit 1
fi

if [ -z "${code_sign_style}" ] ; then
  echo " [!] Missing required input: code_sign_style"
  exit 1
fi

if [ -z "${release_development_team}" ] ; then
  echo " [!] Missing required input: release_development_team"
  exit 1
fi

if [ -z "${release_code_sign_identity}" ] ; then
  echo " [!] Missing required input: release_code_sign_identity"
  exit 1
fi

if [ -z "${release_provisioning_profile_specifier}" ] ; then
  echo " [!] Missing required input: release_provisioning_profile_specifier"
  exit 1
fi

if [ -z "${debug_development_team}" ] ; then
  echo " [!] Missing required input: debug_development_team"
  exit 1
fi

if [ -z "${debug_code_sign_identity}" ] ; then
  echo " [!] Missing required input: debug_code_sign_identity"
  exit 1
fi

if [ -z "${debug_provisioning_profile_specifier}" ] ; then
  echo " [!] Missing required input: debug_provisioning_profile_specifier"
  exit 1
fi


# ---------------------
# --- Configs:

echo " (i) Provided project.pbxproj Path                     : ${xcode_pbxproj_file}"
echo " (i) Provided Project Target                           : ${project_target}"
echo " (i) Provided Code Sign Style                          : ${code_sign_style}"
echo " (i) Provided Development Team (Release)               : ${release_development_team}"
echo " (i) Provided Code Sign Identity (Release)             : ${release_code_sign_identity}"
echo " (i) Provided Provisioning Profile Specifier (Release) : ${release_provisioning_profile_specifier}"
echo " (i) Provided Development Team (Debug)                 : ${debug_development_team}"
echo " (i) Provided Code Sign Identity (Debug)               : ${debug_code_sign_identity}"
echo " (i) Provided Provisioning Profile Specifier (Debug)   : ${debug_provisioning_profile_specifier}"
