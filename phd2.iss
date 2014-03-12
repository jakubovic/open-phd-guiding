; PHD2 installer script
; Generated by Bret McKee on 2013/03/23
; Updated to install independently of PHD1 by Andy Galasso on 2013/7/25

#define APP_NAME "PHD 2"
#define APP_VERSION "2.2.1"

[Setup]
AppName="{#APP_NAME}"
AppVersion="{#APP_VERSION}"
DefaultDirName="{pf}\PHDGuiding2"
DefaultGroupName="PHD Guiding 2"
UninstallDisplayIcon={app}\phd2.exe
Compression=lzma2
SolidCompression=yes
OutputDir=.
OutputBaseFilename="phd2-v{#APP_VERSION}-installer"
DirExistsWarning=no

[Files]
Source: "Release\phd2.exe";                   DestDir: "{app}"; Flags: replacesameversion
Source: "locale\*"; Excludes: "*-old.*";      DestDir: "{app}\locale"; Flags: recursesubdirs replacesameversion
Source: "PHD2GuideHelp.zip";                  DestDir: "{app}"; Flags: replacesameversion
Source: "README-PHD2.txt";                    DestDir: "{app}"; Flags: isreadme replacesameversion
Source: "WinLibs\astroDLLGeneric.dll";        DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\astroDLLQHY5V.dll";          DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\astroDLLsspiag.dll";         DestDir: "{app}"; Flags: replacesameversion
#emit 'Source: "' + GetEnv("CFITSIO") + '\cfitsio.dll";             DestDir: "{app}"; Flags: replacesameversion'
Source: "WinLibs\CMOSDLL.dll";                DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\DICAMSDK.dll";               DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\DSCI.dll";                   DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\FcApi.dll";                  DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\inpout32.dll";               DestDir: "{app}"; Flags: replacesameversion
#emit 'Source: "' + GetEnv("OPENCV_DIR") + '\x86\vc11\bin\opencv_core245.dll"; DestDir: "{app}"; Flags: replacesameversion'
#emit 'Source: "' + GetEnv("OPENCV_DIR") + '\x86\vc11\bin\opencv_highgui245.dll"; DestDir: "{app}"; Flags: replacesameversion'
#emit 'Source: "' + GetEnv("OPENCV_DIR") + '\x86\vc11\bin\opencv_imgproc245.dll"; DestDir: "{app}"; Flags: replacesameversion'
Source: "WinLibs\qhy5IIdll.dll";              DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\qhy5LIIdll.dll";             DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\ShoestringGPUSB_DLL.dll";    DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\ShoestringLXUSB_DLL.dll";    DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\SSAGIFv2.dll";               DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\SSAGIFv4.dll";               DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\SSPIAGCAM.dll";              DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\SSPIAGUSB_WIN.dll";          DestDir: "{app}"; Flags: replacesameversion
Source: "WinLibs\SXUSB.dll";                  DestDir: "{app}"; Flags: replacesameversion
; Missing: TIS_DShowLib09.dll
; Missing: TIS_UDSHL09_vc10.dll
; Missing: TIS_UDSHL09_vc9.dll
Source: "WinLibs\vcredist_x86.exe";           DestDir: {tmp}; Flags: deleteafterinstall

[Icons]
Name: "{group}\PHD Guiding 2"; FileName: "{app}\phd2.exe"

[Run]
Filename: "{tmp}\vcredist_x86.exe"; Check: VCRedistNeedsInstall
Filename: {app}\phd2.exe; Description: "Launch {#APP_NAME} after installation"; Flags: nowait postinstall skipifsilent

[Registry]
Root: HKCU; Subkey: "Software\StarkLabs"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\StarkLabs\PHDGuidingV2"; Flags: uninsdeletekey

[Code]
#IFDEF UNICODE
  #DEFINE AW "W"
#ELSE
  #DEFINE AW "A"
#ENDIF
type
  INSTALLSTATE = Longint;
const
  INSTALLSTATE_INVALIDARG = -2;  // An invalid parameter was passed to the function.
  INSTALLSTATE_UNKNOWN = -1;     // The product is neither advertised or installed.
  INSTALLSTATE_ADVERTISED = 1;   // The product is advertised but not installed.
  INSTALLSTATE_ABSENT = 2;       // The product is installed for a different user.
  INSTALLSTATE_DEFAULT = 5;      // The product is installed for the current user.

  VC_2010_REDIST_X86 = '{196BB40D-1578-3D01-B289-BEFC77A11A1E}';
  VC_2010_SP1_REDIST_X86 = '{F0C3E5D1-1ADE-321E-8167-68EF0DE699A5}';
  VC_2013_REDIST_X86 = '{13A4EE12-23EA-3371-91EE-EFB36DDFFF3E}';

function MsiQueryProductState(szProduct: string): INSTALLSTATE; 
  external 'MsiQueryProductState{#AW}@msi.dll stdcall';

function VCVersionInstalled(const ProductID: string): Boolean;
begin
  Result := MsiQueryProductState(ProductID) = INSTALLSTATE_DEFAULT;
end;

function VCRedistNeedsInstall: Boolean;
begin
  Result := not (VCVersionInstalled(VC_2013_REDIST_X86));
end;
