# synfo

## update!!!
the tool has been ported to powershell to ease updates. please see the ***\pssynfo*** folder.
note that the PatchCode property of a patch is not available from powershell invocation. it is possible to load and get the info from the MSP file but this slow down the process; especially from within powershell runtime.

**Usage:**
* to dump the system info, invoke the static method *Dump()* of the **Synfo** class
```
[Synfo]::Dump()
```

* to compare the dumped Synfo xml files, use the static method *Compare()* and specify the XML file paths
```
[Synfo]::Compare("$global:PSScriptRoot\sample1.xml","$global:PSScriptRoot\sample2.xml")
```

### deprecated
Utility to dump and compare system info (computer properties, environment variables, services, system drivers and updates, as well as the installed products and the patches applied to them)

**Usage:**
to dump the system info, run with no parameters. the info will be dumped into an XML file (referred to as synfo file) on the same location as the executable.

` synfo.exe <enter>`

to compare the synfo files, specify the reference or base synfo file dumped before doing any changes and the synfo file dumped after the change. 

` synfo.exe <referenceFile> [compareFile] [xslPath]`

- referenceFile - the base synfo xml file. required
- [compareFile]        - the synfo xml file to compare. ( if not specified, the current system state is used)
- [xslFilePath]        - path to the result xml stylesheet. (optional)
