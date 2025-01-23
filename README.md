# synfo
Utility to dump and compare system info (computer properties, environment variables and installed products/updates)

**Usage:**
to dump the system info, run with no parameters. the info will be dumped into an XML file (referred to as synfo file) on the same location as the executable.

` synfo.exe <enter>`

to compare the synfo files, specify the reference or base synfo file dumped before doing any changes and the synfo file dumped after the change. 

` synfo.exe <referenceFile> [compareFile] [xslPath]`

- referenceFile - the base synfo xml file. required
- [compareFile]        - the synfo xml file to compare. ( if not specified, the current system state is used)
- [xslFilePath]        - path to the result xml stylesheet. (optional)
