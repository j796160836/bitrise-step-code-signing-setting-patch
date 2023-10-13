#!/usr/bin/env ruby

require 'xcodeproj'

$xcode_xcodeproj_file = ENV['xcode_xcodeproj_file']
$project_target = ENV['project_target']
$code_sign_style = ENV['code_sign_style']
$release_configuration = ENV['release_development_configuration']
$release_development_team = ENV['release_development_team']
$release_code_sign_identity = ENV['release_code_sign_identity']
$release_provisioning_profile_specifier = ENV['release_provisioning_profile_specifier']
$debug_development_configuration = ENV['debug_development_configuration']
$debug_development_team = ENV['debug_development_team']
$debug_code_sign_identity = ENV['debug_code_sign_identity']
$debug_provisioning_profile_specifier = ENV['debug_provisioning_profile_specifier']
$dry_run = (ENV['dry_run'].to_s == "yes")

project = Xcodeproj::Project.open($xcode_xcodeproj_file)

$CONFIGURATION_NAMES = [$debug_development_configuration, $release_configuration]

def getTarget(project, name)
	project.targets.each do |target|
		if target.name == name
			return target
		end
	end
	return nil
end

def getBuildSettings(target, name)
	target.build_configurations.each do |build_configurations|
		if build_configurations.name == name
			return build_configurations.build_settings
		end
	end
	return nil
end

def getBuildSettingsStrings(project, target_name, configuration_name)

	target = getTarget(project, target_name)
	settings = getBuildSettings(target, configuration_name)

	result = ""
	result += "Build Configuration: " + configuration_name + "\n"
	result += "CODE_SIGN_STYLE: " + settings["CODE_SIGN_STYLE"].to_s + "\n"
	result += "DEVELOPMENT_TEAM: " + settings["DEVELOPMENT_TEAM"].to_s + "\n"
	result += "CODE_SIGN_IDENTITY: " + settings["CODE_SIGN_IDENTITY"].to_s + "\n"
	result += "PROVISIONING_PROFILE_SPECIFIER: " + settings["PROVISIONING_PROFILE_SPECIFIER"].to_s
	return result
end

def printAllBuildSettings(project, target_name)

	puts "-----------------------------"
	puts "Target: " + target_name
	$CONFIGURATION_NAMES.each do |configuration_name|
		puts
		puts getBuildSettingsStrings(project, target_name, configuration_name)
	end
	puts "-----------------------------"
end

puts "\# Original Settings:"

printAllBuildSettings(project, $project_target)


target = getTarget(project, $project_target)
debugSettings = getBuildSettings(target, $CONFIGURATION_NAMES[0])
debugSettings["CODE_SIGN_STYLE"] = $code_sign_style
debugSettings["DEVELOPMENT_TEAM"] = $debug_development_team
debugSettings["CODE_SIGN_IDENTITY"] = $debug_code_sign_identity
debugSettings["PROVISIONING_PROFILE_SPECIFIER"] = $debug_provisioning_profile_specifier

releaseSettings = getBuildSettings(target, $CONFIGURATION_NAMES[1])
releaseSettings["CODE_SIGN_STYLE"] = $code_sign_style
releaseSettings["DEVELOPMENT_TEAM"] = $release_development_team
releaseSettings["CODE_SIGN_IDENTITY"] = $release_code_sign_identity
releaseSettings["PROVISIONING_PROFILE_SPECIFIER"] = $release_provisioning_profile_specifier

puts
puts "\# Changed Settings" + ($dry_run ? " (Dry-run preview. setting not saved)" : "") + ":"

printAllBuildSettings(project, $project_target)

if !$dry_run
	project.save
end
