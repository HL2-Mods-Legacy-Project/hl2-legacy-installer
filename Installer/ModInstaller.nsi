!include "MUI2.nsh"

!ifdef ADDITIONAL_MOD_FOLDERS_COUNT
!if ${ADDITIONAL_MOD_FOLDERS_COUNT} > 10
  !error "ADDITIONAL_MOD_FOLDERS_COUNT = ${ADDITIONAL_MOD_FOLDERS_COUNT} | Maximum is 10"
!endif
!endif

Name "${NAME}"
OutFile "${OUTPUTFILE}"
Caption "${CAPTION}"
Unicode true
RequestExecutionLevel admin
SetCompress force
ManifestDPIAware true
ShowInstDetails show

!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_LICENSE ".\licenses\LICENSE.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!ifdef MOD_README_PATH
  !define MUI_FINISHPAGE_SHOWREADME
  !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
  !define MUI_FINISHPAGE_SHOWREADME_TEXT "Show release notes"
  !define MUI_FINISHPAGE_SHOWREADME_FUNCTION ShowReleaseNotes
!endif

!define MUI_PAGE_CUSTOMFUNCTION_LEAVE AfterFinishPage
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

VIProductVersion "${VERSION}.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${NAME}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductVersion" "${VERSION}.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "${NAME}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" ""
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${VERSION}"

!ifdef MOD_README_PATH
Function ShowReleaseNotes
  ExecShell "open" "$INSTDIR\${MOD_FOLDER}\${MOD_README_PATH}"
FunctionEnd
!endif

Function AfterFinishPage
  MessageBox MB_OK|MB_ICONINFORMATION "Steam must be restarted for ${NAME} to appear in your game list."
FunctionEnd

Section
  SetDetailsPrint both
  SetOutPath "$INSTDIR"
  File /a /r "${MOD_FILES_PATH}\*"
  WriteUninstaller "$INSTDIR\${MOD_FOLDER}\Uninstall.exe"
SectionEnd

Section "Uninstall"
  Delete "$INSTDIR\Uninstall.exe"
  RMDir /r "$INSTDIR"
  
  # Allow up to 10 additional mod folders to delete.
  !ifdef MOD_FOLDER2
    RMDir /r "$INSTDIR\..\${MOD_FOLDER2}"
  !endif
  !ifdef MOD_FOLDER3
    RMDir /r "$INSTDIR\..\${MOD_FOLDER3}"
  !endif
  !ifdef MOD_FOLDER4
    RMDir /r "$INSTDIR\..\${MOD_FOLDER4}"
  !endif
  !ifdef MOD_FOLDER5
    RMDir /r "$INSTDIR\..\${MOD_FOLDER5}"
  !endif
  !ifdef MOD_FOLDER6
    RMDir /r "$INSTDIR\..\${MOD_FOLDER6}"
  !endif
  !ifdef MOD_FOLDER7
    RMDir /r "$INSTDIR\..\${MOD_FOLDER7}"
  !endif
  !ifdef MOD_FOLDER8
    RMDir /r "$INSTDIR\..\${MOD_FOLDER8}"
  !endif
  !ifdef MOD_FOLDER9
    RMDir /r "$INSTDIR\..\${MOD_FOLDER9}"
  !endif
  !ifdef MOD_FOLDER10
    RMDir /r "$INSTDIR\..\${MOD_FOLDER10}"
  !endif
  !ifdef MOD_FOLDER11
    RMDir /r "$INSTDIR\..\${MOD_FOLDER11}"
  !endif
SectionEnd

Function .onInit
  ReadRegStr $R0 HKCU Software\Valve\Steam SourceModInstallPath
  IfErrors 0 sourcemods_dir_found
    MessageBox MB_OK "sourcemods directory not found!"
    Abort
sourcemods_dir_found:
  StrCpy $INSTDIR "$R0"
FunctionEnd
