/*	Copyright 2015 Jacob Knaup
    This file is part of PSSW Installer.
    PSSW Installer is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    PSSW Installer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
    The author can be contacted on VEXFORUM.COM as Highwayman
*/

# include modern ui
!include MUI2.nsh

Var PROSINSTALLFOLDER
Function .onInit
	StrCpy $PROSINSTALLFOLDER '$PROGRAMFILES\PROS'
 FunctionEnd
 
!define MUI_ICON '${NSISDIR}\Contrib\Graphics\Icons\modern-install-colorful.ico'

!define MUI_PAGE_HEADER_TEXT 'PROS Sensors Setup Wizard'
!define MUI_FINISHPAGE_NOAUTOCLOSE

!define MUI_WELCOMEPAGE_TITLE 'Welcome to the PROS Sensors Setup Wizard Installer'
!define MUI_WELCOMEPAGE_TEXT 'This wizard will guide you through the installation of the PROS Sensors Setup Wizard (PSSW). You must have already installed PROS before installing PSSW.'
!insertmacro MUI_PAGE_WELCOME

!define MUI_LICENSEPAGE_TEXT_TOP 'All software included in this installer is licensed under the GNU General Public License.'
!define MUI_LICENSEPAGE_BUTTON 'I Agree'
!insertmacro MUI_PAGE_LICENSE 'data\license\License.txt'

!define MUI_DIRECTORYPAGE_TEXT_TOP 'Ensure the directory of the PROS installation is correct.'
!define MUI_DIRECTORYPAGE_TEXT_DESTINATION 'PROS Installation'
!define MUI_DIRECTORYPAGE_VARIABLE $PROSINSTALLFOLDER
!insertmacro MUI_PAGE_DIRECTORY

!define MUI_INSTFILESPAGE_ABORTHEADER_TEXT 'Aborted'
!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_TITLE 'PROS Sensors Setup Wizard Successfully Installed'
!define MUI_FINISHPAGE_TEXT 'To complete the installation of the PSSW launch PROS as administrator'
!define MUI_FINISHPAGE_RUN '$PROSINSTALLFOLDER\ccide.exe'
!define MUI_FINISHPAGE_RUN_TEXT 'Launch PROS as administrator'
!define MUI_FINISHPAGE_RUN_PARAMETERS 'Run as administrator'
!define MUI_FINISHPAGE_LINK 'README'
!define MUI_FINISHPAGE_LINK_LOCATION 'https://github.com/Highway-Man/PSSW-Installer/blob/master/README.md'
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!insertmacro MUI_PAGE_FINISH

!define MUI_WELCOMEPAGE_TITLE 'PSSW Uninstaller'
!define MUI_WELCOMEPAGE_TEXT 'This wizard will uninstall the PROS Sensors Setup Wizard.'
!insertMacro MUI_UNPAGE_WELCOME

!insertMacro MUI_UNPAGE_INSTFILES

!define MUI_FINISHPAGE_TITLE 'PSSW Uninstalled'
!define MUI_FINISHPAGE_TEXT 'The PROS Sensors Setup Wizard has been uninstalled'
!insertMacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE 'English'

# define installer name
Name 'PROS Sensors Setup Wizard'
OutFile "PSSW Setup.exe"
 
# set desktop as install directory
InstallDir '$DESKTOP'

RequestExecutionLevel highest

# default section start
Section

Delete $ProsInstallFolder\dropins\*

# change output path to PROS dropins folder
SetOutPath '$ProsInstallFolder\dropins'

#copy proper plugin
File 'data\plugin\*.*'
 
# define uninstaller name
WriteUninstaller "'$ProsInstallFolder\PSSW Uninstaller.exe'"
 
#-------
# default section end
SectionEnd
 
# create a section to define what the uninstaller does.
# the section will always be named "Uninstall"
Section "Uninstall"

# change path to user folder so we can delete install directory
SetOutPath '$PROFILE'
 
# Always delete uninstaller first
Delete "'$ProsInstallFolder\PSSW Uninstaller.exe'"

# remove the plugin
Delete '$ProsInstallFolder\dropins\tk.Knaup.prosSensorsSetupWizard_1.0.2'

SectionEnd