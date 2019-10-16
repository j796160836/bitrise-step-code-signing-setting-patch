# Code Signing Setting Patch

Patch xcode's automatic signing config into specific key and provisioning profile


## How to use this Step

Add the **Code Signing Setting Patch** step into your worflow before **Xcode Archive & Export for iOS** step.

Fill up the required values:

- Xcode project.xcodeproj Path
- Project Target
- Code Sign Style
- Development Team **(Debug)**               
- Code Sign Identity **(Debug)**              
- Provisioning Profile Specifier **(Debug)**  
- Development Team **(Release)**              
- Code Sign Identity **(Release)**            
- Provisioning Profile Specifier **(Release)**

#### Automatic Signing

- Code Sign Style use `Automatic`.
- Fill **Code Sign Identity** with `iPhone Developer`.
- Specify **Development Team** for both **(Debug)** and **(Release)** configurations.  
(Note that development team for debug and release configurations is different.)
- Leave **Provisioning Profile Specifier** remain empty.

```
Build Configuration: Debug
CODE_SIGN_STYLE: Automatic
DEVELOPMENT_TEAM: XXXXXXXXXX
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER:

Build Configuration: Release
CODE_SIGN_STYLE: Automatic
DEVELOPMENT_TEAM: AAAAAAAAAA
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER:
```

#### Manual Signing

Specify all the values.  
(Note that development team for debug and release configurations is different.)

```
Build Configuration: Debug
CODE_SIGN_STYLE: Manual
DEVELOPMENT_TEAM: ABCDEFGHIJ
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER: MyAwesomeProjectDEV_Development

Build Configuration: Release
CODE_SIGN_STYLE: Manual
DEVELOPMENT_TEAM: FGHIJABCDE
CODE_SIGN_IDENTITY: iPhone Distribution
PROVISIONING_PROFILE_SPECIFIER: MyAwesomeProjectDEV_store
```


## Demo

Here is part result of `bitrise run test` command with the [bitrise CLI](https://github.com/bitrise-io/bitrise).

```
# Original Settings:
-----------------------------
Target: MyAwesomeProjectDEV

Build Configuration: Debug
CODE_SIGN_STYLE: Automatic
DEVELOPMENT_TEAM: XXXXXXXXXX
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER:

Build Configuration: Release
CODE_SIGN_STYLE: Automatic
DEVELOPMENT_TEAM: XXXXXXXXXX
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER:
-----------------------------

# Changed Settings:
-----------------------------
Target: MyAwesomeProjectDEV

Build Configuration: Debug
CODE_SIGN_STYLE: Manual
DEVELOPMENT_TEAM: ABCDEFGHIJ
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER: MyAwesomeProjectDEV_Development

Build Configuration: Release
CODE_SIGN_STYLE: Manual
DEVELOPMENT_TEAM: FGHIJABCDE
CODE_SIGN_IDENTITY: iPhone Distribution
PROVISIONING_PROFILE_SPECIFIER: MyAwesomeProjectDEV_store
-----------------------------
```

## Contribution

Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be
added to your `.bitrise.secrets.yml` file!*

Step by step:

1. Open up your Terminal / Command Line
2. `git clone` the repository
3. `cd` into the directory of the step (the one you just `git clone`)
4. Once you have all the required secret parameters in your `.bitrise.secrets.yml` you can just run this step with the [bitrise CLI](https://github.com/bitrise-io/bitrise): `bitrise run test`

Pull Request is welcome.

## Reference

Inspired by

- Set iOS Info.plist - Bundle Identifier  
https://github.com/teference/steps-set-ios-bundle-identifier
- Set iOS Info.plist Values (unified)  
https://github.com/mapletonhillmedia/steps-set-ios-info-plist
