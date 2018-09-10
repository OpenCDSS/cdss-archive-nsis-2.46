# cdss-archive-nsis-2.46 #

This is an archive of NSIS 2.46 software environment that has been used with
Colorado's Decision Support System (CDSS) Java software installers
including TSTool, StateDMI, StateView, and StateMod GUI.

The repository was created by copying the `C:\Program Files (x86)\NSIS` folder from a CDSS Windows 7
development computer to this repository,
so as to archive a working copy of the NSIS version 2.46 software.

This archive is needed because NSIS 2.46 is several years old and it is unclear where all the user contributor and plugin
files came from.  The archive files can be copied and used until NSIS software is updated to the latest version.
See the following online resources:

* [CDSS](http://cdss.state.co.us)
* [OpenCDSS](http://learn.openwaterfoundation.org/cdss-website-opencdss)
* [TSTool Developer Documentation](http://learn.openwaterfoundation.org/cdss-app-tstool-doc-dev/) - example of a program that uses NSIS to create the software installer
* [NSIS](http://nsis.sourceforge.net/Download)

See the following sections in this page:

* [Repository Folder Structure](#repository-folder-structure)
* [Repository Dependencies](#repository-dependencies)
* [Current Use](#current-use)

-------------------------

## Repository Folder Structure ##

The following are the main folders and files in this repository, listed alphabetically.

```
cdss-archive-nsis-2.46/       Archive of NSIS 2.46.
  .git/                       Git repository folder (DO NOT MODIFY THIS except with Git tools).
  .gitattributes              Git configuration file for repository.
  .gitignore                  Git configuration file for repository.
  NSIS/                       Files from C:\Program Files (x86)\NSIS
  README.md                   This file.
```

## Repository Dependencies ##

Repository dependencies fall into two categories as indicated below.

### Dependencies for this Repository ###

The NSIS software does not have any other repository dependencies.

### Repositories that Depend on NSIS Repository ###

The following repositories are known to depend on NSIS being installed.
See the [Current Use](#current-use) section for current practices.

|**Repository**|**Description**|
|-------------------------------------------------------------------------------------------------|----------------------------------------------------|
|[`cdss-app-statedmi-main`](https://github.com/OpenWaterFoundation/cdss-app-statedmi-main)            |StateDMI main application code.|
|[`cdss-app-tstool-main`](https://github.com/OpenWaterFoundation/cdss-app-tstool-main)          |TSTool main application code.|
|Stateview - repo needs to be finalized                                                           |HydroBase viewing application.|
|StateMod GUI - repo needs to be finalized                                                        |StateMod Graphical User Interface.|

## Current Use ##

To simplify NSIS environment setup for current CDSS software developers,
current NSIS files needed for the development environment are saved in the
[cdss-util-buildtools repository](https://github.com/OpenWaterFoundation/cdss-util-buildtools).
The files, such as contributed files, can be copied into NSIS 3.x installation.
