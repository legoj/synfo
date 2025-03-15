'Option Explicit On

Imports System.Xml
Imports System.Management
Imports System.IO
Imports Microsoft.Win32
Imports System.Runtime.InteropServices






Module Module1
    Sub Main2(ByVal args As String())

        Dim xmlRef = New XmlDocument()
        xmlRef.Load(args(0))
        Dim s = New Synfo
        s.Parse(xmlRef.DocumentElement)
        s.ToXml("DEBUGOUT.xml")
    End Sub
    Sub Main(ByVal args As String())

        If args.Length > 0 Then
            If args(0).Equals("/?") Or args(0).Equals("?") Or args(0).Equals("-help", StringComparison.CurrentCultureIgnoreCase) Then
                Console.WriteLine()
                Console.WriteLine("synfo.exe tool help.")
                Console.WriteLine()
                Console.WriteLine("to dump the system info, run with no parameters.")
                Console.WriteLine(" synfo.exe <enter>")
                Console.WriteLine()
                Console.WriteLine("to compare the synfo files:")
                Console.WriteLine(" synfo.exe <referenceFile> [compareFile] [xslPath]")
                Console.WriteLine("   <referenceFile>" & vbTab & "- the base synfo xml file. required")
                Console.WriteLine("   [compareFile]" & vbTab & "- the synfo xml file to compare. ")
                Console.WriteLine("                " & vbTab & "if not specified, the current system state is used.")
                Console.WriteLine("   [xslFilePath]" & vbTab & "- path to the result xml stylesheet. optional")
            Else
                CmpSynfos(args)
            End If
        Else
            DumpObjects()
        End If

    End Sub
    Sub CmpSynfos(ByVal args As String())
        Dim xslPath As String = Nothing
        Dim sXmlRef = args(0)
        Dim sXmlCmp As String

        If args.Length = 1 Then
            sXmlCmp = DumpObjects()
        ElseIf args.Length = 2 Then
            If (args(1).EndsWith(".xsl", StringComparison.CurrentCultureIgnoreCase)) Then
                xslPath = args(1)
                sXmlCmp = DumpObjects()
            Else
                sXmlCmp = args(1)
            End If
        Else
            sXmlCmp = args(1)
            xslPath = args(2)
        End If

        If File.Exists(sXmlRef) And File.Exists(sXmlCmp) Then
            Dim xmlRef = New XmlDocument()
            Dim xmlCmp = New XmlDocument()
            xmlRef.Load(sXmlRef)
            xmlCmp.Load(sXmlCmp)
            Dim outPath = GetAppPath() & "\synfoCompareResult.xml"
            Dim xmlResult = New XmlTextWriter(outPath, Text.Encoding.UTF8)
            With xmlResult
                .Formatting = Formatting.Indented
                .WriteStartDocument()
                If Not IsNothing(xslPath) Then .WriteProcessingInstruction("xml-stylesheet", "type='text/xsl' href='" & xslPath & "'")
                .WriteStartElement("synfo")
                .WriteStartElement("refFile")
                .WriteAttributeString("path", sXmlRef)
                .WriteEndElement()
                .WriteStartElement("cmpFile")
                .WriteAttributeString("path", sXmlCmp)
                .WriteEndElement()


                Dim rSyn = New Synfo
                Dim cSyn = New Synfo
                rSyn.Parse(xmlRef.DocumentElement)
                cSyn.Parse(xmlCmp.DocumentElement)
                Dim sCmp = New CmpResult
                rSyn.Compare(cSyn, sCmp)
                sCmp.ToXml(xmlResult)
                Console.WriteLine("Synfo comparison result: " & outPath)
                .WriteEndDocument()
                .Close()
            End With
        Else
            Console.WriteLine("The specified filepath does not exist!")
        End If
    End Sub



    Function DumpObjects() As String

        Dim outXml = GetAppPath()
        outXml = outXml & "\synfo_" & Environment.MachineName & "_" & DateTime.Now.ToString("yyyyMMddHHmmss") & ".xml"

        Dim svc = New Services()
        Console.WriteLine("Reading Win32_Service")
        svc.Read()

        Dim app = New MSIProducts()
        Console.WriteLine("Getting Products list thru WindowsInstaller API")
        app.Read()

        Dim rapp = New RegProducts
        Console.WriteLine("Getting Products on Registry uninstall node")
        rapp.Read()

        Dim w As XmlTextWriter
        w = New XmlTextWriter(outXml, Text.Encoding.UTF8)
        w.Formatting = Formatting.Indented
        w.WriteStartDocument()
        'w.WriteProcessingInstruction("xml", "version='1.0' encoding='UTF-8'")

        w.WriteStartElement("synfo")

        Console.WriteLine("Writing System Info data")
        WriteInfo(w)



        w.WriteStartElement("services")
        w.WriteAttributeString("count", svc.Count)
        For Each s As String In svc.Keys
            svc.GetObj(s).WriteXML("svc", w)
        Next
        w.WriteEndElement()

        w.WriteStartElement("products")
        w.WriteAttributeString("count", app.Count)
        For Each s As String In app.Keys
            app.GetObj(s).WriteXML("app", w, False)
            If rapp.Has(s) Then
                rapp.GetObj(s).WriteXML("reg.info", w)
            End If
            If app.HasPatches(s) Then
                Dim patches = app.GetPatches(s)
                w.WriteStartElement("patches")
                w.WriteAttributeString("count", patches.Count)
                For Each z As String In patches.Keys
                    Dim patch = patches.GetObj(z)
                    Dim dName = patch.Value("DisplayName")
                    patch.WriteXML("patch", w, False, "name", dName)

                    If rapp.Has(dName) Then
                        rapp.GetObj(dName).WriteXML("reg.info", w)
                    End If
                    w.WriteEndElement()
                Next
                w.WriteEndElement()
            End If
            w.WriteEndElement()
        Next
        w.WriteEndElement()

        w.WriteEndElement()
        w.WriteEndDocument()
        w.Close()

        DumpObjects = outXml
    End Function
    Function GetAppPath() As String
        Return System.IO.Path.GetDirectoryName( _
            System.Reflection.Assembly.GetExecutingAssembly().Location)
    End Function

    Sub WriteDic(ByVal sType As String, ByVal elName As String, ByRef writer As XmlTextWriter, ByRef dic As Hashtable)

        With writer
            .WriteStartElement(sType)
            For Each k As String In dic.Keys
                .WriteStartElement(elName)
                .WriteAttributeString("name", k)
                .WriteString(dic.Item(k).ToString())
                .WriteEndElement()
            Next
            .WriteEndElement()
        End With
    End Sub

    Sub WriteInfo(ByRef w As XmlTextWriter)
        w.WriteStartElement("info")
        w.WriteAttributeString("id", My.Computer.Name)
        WriteInfo(w, "OSInfo", Environment.OSVersion.ToString())
        WriteInfo(w, "Version", Environment.Version.ToString())
        WriteInfo(w, "SystemDirectory", Environment.SystemDirectory)
        WriteInfo(w, "UserDomainName", Environment.UserDomainName)
        WriteInfo(w, "UserName", Environment.UserName)
        With My.Computer.Info
            WriteInfo(w, "OSFullName", .OSFullName)
            WriteInfo(w, "OSPlatform", .OSPlatform)
            WriteInfo(w, "OSVersion", .OSVersion)
            WriteInfo(w, "InstalledUICulture", .InstalledUICulture.ToString())
            WriteInfo(w, "TotalPhysicalMemory", .TotalPhysicalMemory.ToString())
            WriteInfo(w, "TotalVirtualMemory", .TotalVirtualMemory.ToString())
        End With
        WriteDic("env.vars", "prop", w, Environment.GetEnvironmentVariables())
        w.WriteEndElement()
    End Sub
    Sub WriteInfo(ByRef w As XmlTextWriter, ByVal attName As String, ByVal attVal As String)
        w.WriteStartElement("prop")
        w.WriteAttributeString("name", attName)
        w.WriteString(attVal)
        w.WriteEndElement()
    End Sub
End Module


Class MSIProducts
    Inherits SysObjects
    Dim dPatches As Dictionary(Of String, SysObjects)
    Dim prodProps As String()
    Dim patchProps As String()
    Dim objWI
    Public Sub New()
        prodProps = New String() {"ProductName", "VersionString", "InstallDate", "Publisher", "URLInfoAbout", _
            "InstallLocation", "InstallSource", "PackageName", "HelpLink", "HelpTelephone"}
        patchProps = New String() {"DisplayName", "InstallDate", "MoreInfoURL", "State", "LocalPackage", "Transforms"}
        objWI = CreateObject("WindowsInstaller.Installer")
        dPatches = New Dictionary(Of String, SysObjects)
    End Sub
    Public Sub AddPatches(ByVal pName As String, ByRef objPats As SysObjects)
        dPatches.Add(pName, objPats)
    End Sub
    Public Function HasPatches(ByVal prodKey As String) As Boolean
        HasPatches = dPatches.ContainsKey(prodKey)
    End Function
    Public Function GetPatches(ByVal prodKey As String) As SysObjects
        GetPatches = dPatches.Item(prodKey)
    End Function
    Public Function GetPatchKeys() As ICollection(Of String)
        GetPatchKeys = dPatches.Keys
    End Function
    Public Overloads Function Read() As Boolean
        Log("Reading Products thru Windows Installer API")
        Dim colProducts = objWI.Products
        If colProducts.Count > 0 Then
            Log("Found " & colProducts.Count & " products")
            For Each product In colProducts
                Log("Product: " & product)
                Dim app = New ObjectInfo
                For Each p In prodProps
                    'Try
                    app.Add(p, objWI.ProductInfo(product, p))
                    'Catch e As COM
                Next
                'WriteProdInfo(product, prodProps)
                app.Key = product
                Dim colPatches = objWI.PatchesEx(product, "", 4, 15)
                If colPatches.Count > 0 Then
                    Log("Found " & colPatches.Count & " patch/es")
                    Dim patches = New SysObjects
                    For Each patch In colPatches
                        Dim pObj = New ObjectInfo
                        pObj.Key = patch.PatchCode
                        'On Error Resume Next
                        Log("Patch:  " & pObj.Key)
                        For Each q In patchProps
                            Log("Setting property: " & q)
                            Try
                                pObj.Add(q, patch.PatchProperty(q))
                            Catch ce As COMException
                                Log("COMError: " & ce.Message & " -- Property: " & q)
                            End Try
                        Next

                        patches.AddObj(pObj)
                    Next
                    dPatches.Add(product, patches)
                End If
                AddObj(app)
            Next
        End If

    End Function
End Class

Class RegProducts
    Inherits SysObjects
    Public Const RKEY = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\"
    Public Const HKLM = &H80000002

    Public Overloads Function Read() As Boolean
        Dim appKeys = Registry.LocalMachine.OpenSubKey(RKEY, False)
        Log("Reading subKey: " & RKEY)
        For Each appKey As String In appKeys.GetSubKeyNames()
            Dim subKey = appKeys.OpenSubKey(appKey, False)
            Dim dName = subKey.GetValue("DisplayName", "").ToString()
            If dName <> "" Then
                Dim app = New ObjectInfo
                app.Key = appKey
                Log("Adding App: " & appKey)
                For Each p In subKey.GetValueNames
                    If (p.Trim() <> "") Then
                        app.Add(p.Trim(), subKey.GetValue(p, "").ToString())
                        Log("Adding Prop: " & p)
                    End If
                Next

                AddObj(app)
            End If
        Next
        appKeys.Close()
        Read = True
    End Function
End Class

Class WMIProducts
    Inherits SysObjects


    Public Overloads Function Read() As Boolean
        Dim PROP = New String() { _
            "AssignmentType", _
            "Caption", _
            "Description", _
            "IdentifyingNumber", _
            "InstallDate", _
            "InstallDate2", _
            "InstallLocation", _
            "InstallState", _
            "HelpLink", _
            "HelpTelephone", _
            "InstallSource", _
            "Language", _
            "LocalPackage", _
            "Name", _
            "PackageCache", _
            "PackageCode", _
            "PackageName", _
            "ProductID", _
            "PackageName", _
            "RegOwner", _
            "RegCompany", _
            "SKUNumber", _
            "Transforms", _
            "URLInfoAbout", _
            "URLUpdateInfo", _
            "Vendor", _
            "WordCount", _
            "Version"}
        Read = MyBase.Read("SELECT * FROM Win32_Product", "IdentifyingNumber", PROP)
    End Function
End Class

Class Services
    Inherits SysObjects

    Public Overloads Function Read() As Boolean
        '*** using ServiceController
        'Dim scServices As ICollection(Of ServiceController)
        'scServices = ServiceController.GetServices()

        'For Each svc As ServiceController In scServices
        '    Dim oNfo = New ObjectInfo
        '    With oNfo
        '        .Key = svc.ServiceName
        '        .Add("ServiceType", svc.ServiceType.ToString())
        '        .Add("DisplayName", svc.DisplayName)
        '        .Add("ServiceHandle", svc.ServiceHandle.ToString())
        '        .Add("Status", svc.Status.ToString())
        '    End With
        'Next

        '*** using WMI
        Dim PROP = New String() { _
        "AcceptStop", _
        "Caption", _
        "CheckPoint", _
        "CreationClassName", _
        "Description", _
        "DesktopInteract", _
        "DisplayName", _
        "ErrorControl", _
        "ExitCode", _
        "InstallDate", _
        "Name", _
        "PathName", _
        "ProcessId", _
        "ServiceSpecificExitCode", _
        "ServiceType", _
        "Started", _
        "StartMode", _
        "StartName", _
        "State", _
        "Status", _
        "SystemCreationClassName", _
        "SystemName", _
        "TagId", _
        "WaitHint"}

        Read = MyBase.Read("SELECT * FROM Win32_Service", "Name", PROP)
    End Function

End Class

Class SysObjects
    Private dObjs As Dictionary(Of String, ObjectInfo)
    Public Sub New()
        dObjs = New Dictionary(Of String, ObjectInfo)
    End Sub
    Public Function Read(ByVal queryParam As String, ByVal keyPropName As String, ByVal propNames As ICollection(Of String)) As Boolean
        Dim oColl = GetObjects(queryParam)
        For Each sObj As ManagementObject In oColl
            Dim oNfo = New ObjectInfo
            With oNfo
                .Key = sObj(keyPropName)
                On Error Resume Next
                For Each s As String In propNames
                    .Add(s, sObj(s))
                Next
            End With
            dObjs.Add(oNfo.Key, oNfo)
        Next

        Read = True
    End Function
    Public Sub AddObj(ByVal objInfo As ObjectInfo)
        dObjs.Add(objInfo.Key, objInfo)
    End Sub
    Public Function Has(ByVal key As String) As Boolean
        Has = dObjs.ContainsKey(key)
    End Function

    Public Function GetObjects(ByVal strQuery As String) As ManagementObjectCollection
        Dim query As ManagementObjectSearcher
        Dim queryCollection As ManagementObjectCollection
        Dim msc As ManagementScope = New ManagementScope("\\.\root\cimv2")
        Dim select_query As SelectQuery = New SelectQuery(strQuery)
        query = New ManagementObjectSearcher(msc, select_query)
        queryCollection = query.Get()
        Return queryCollection
    End Function

    Public Function Keys() As ICollection(Of String)
        Return dObjs.Keys
    End Function
    Public Function GetObj(ByVal key As String) As ObjectInfo
        GetObj = dObjs.Item(key)
    End Function
    Public Function Count() As Integer
        Count = dObjs.Count
    End Function
    Public Sub Clear()
        dObjs.Clear()
    End Sub
    Public Sub Remove(ByVal key As String)
        dObjs.Remove(key)
    End Sub
    Public Sub Log(ByVal str As String)
        Console.WriteLine(str)
    End Sub
End Class

Class ObjectInfo
    Private dProps As Dictionary(Of String, String)
    Private sKey As String

    Public Sub New()
        dProps = New Dictionary(Of String, String)
    End Sub
    Public Function IsOfValue(ByVal propName As String, ByVal testValue As String)
        If Has(propName) Then
            IsOfValue = (dProps.Item(propName) = testValue)
        Else
            IsOfValue = False
        End If
    End Function
    Public Property Key() As String
        Get
            Return sKey
        End Get
        Set(ByVal value As String)
            sKey = value
        End Set
    End Property
    Public Sub Add(ByVal propName As String, ByVal propValue As String)
        dProps.Add(propName, propValue)
    End Sub
    Public Function Value(ByVal propName As String) As String
        If Has(propName) Then
            Value = dProps.Item(propName)
        Else
            Value = ""
        End If
    End Function
    Public Function Has(ByVal propName As String)
        Has = dProps.ContainsKey(propName)
    End Function
    Public Sub WriteXML(ByVal sType As String, ByRef writer As XmlTextWriter)
        WriteXML(sType, writer, True)
    End Sub
    Public Sub WriteXML(ByVal sType As String, ByRef writer As XmlTextWriter, ByVal bEndElement As Boolean, Optional ByVal attrName As String = "", Optional ByVal attrVal As String = "")
        With writer
            .WriteStartElement(sType)
            .WriteAttributeString("id", sKey)
            If attrName <> "" Then .WriteAttributeString(attrName, attrVal)
            For Each k As String In dProps.Keys
                .WriteStartElement("prop")
                .WriteAttributeString("name", k)
                .WriteString(dProps.Item(k))
                .WriteEndElement()
            Next
            If bEndElement Then .WriteEndElement()
        End With
    End Sub
End Class

'used for comparing
Class Synfo
    Private sInfo As SynProps
    Protected dSvcs As Dictionary(Of String, SynProps)
    Protected dApps As Dictionary(Of String, SynApp)
    Public Sub New()
        dSvcs = New Dictionary(Of String, SynProps)
        dApps = New Dictionary(Of String, SynApp)
    End Sub
    Public Sub Parse(ByRef x As XmlElement)
        For Each cX As XmlElement In x.ChildNodes
            Select Case cX.Name
                Case "info"
                    sInfo = New SynProps("info", "env.vars")
                    sInfo.Parse(cX)
                Case "services"
                    For Each sX In cX.ChildNodes
                        Dim s = New SynProps("svc")
                        s.Parse(sX)
                        dSvcs.Add(s.Id, s)
                    Next
                Case "products"
                    For Each pX In cX.ChildNodes
                        Dim p = New SynApp
                        p.Parse(pX)
                        dApps.Add(p.Id, p)
                    Next
            End Select
        Next
    End Sub
    Public Function SynInfo() As SynProps
        SynInfo = sInfo
    End Function
    Public Sub ToXml(ByVal outPath As String)
        Dim x = New XmlTextWriter(outPath, Text.Encoding.UTF8)
        x.Formatting = Formatting.Indented
        x.WriteStartDocument()
        x.WriteStartElement("synfo")
        sInfo.ToXml(x)
        x.WriteStartElement("services")
        x.WriteAttributeString("count", dSvcs.Count)
        For Each s In dSvcs.Values
            s.ToXml(x)
        Next
        x.WriteEndElement()
        x.WriteStartElement("products")
        x.WriteAttributeString("count", dApps.Count)
        For Each p In dApps.Values
            p.ToXml(x)
        Next
        x.WriteEndElement()
        x.WriteEndElement()
        x.WriteEndDocument()
        x.Close()
    End Sub
    Public Sub Compare(ByRef sBase As Synfo, ByRef cmp As CmpResult)
        Dim sCmp = New SynCmp(Me.SynInfo.NodeName, Me.SynInfo.Id)
        Me.SynInfo.Compare(sBase.SynInfo, sCmp)
        cmp.InfoSynCmp = sCmp

        For Each k In New List(Of String)(dSvcs.Keys)
            If sBase.dSvcs.ContainsKey(k) Then
                Dim c = New SynCmp(sBase.dSvcs.Item(k).NodeName, sBase.dSvcs.Item(k).Id)
                dSvcs.Item(k).Compare(sBase.dSvcs.Item(k), c)
                dSvcs.Remove(k)
                sBase.dSvcs.Remove(k)
                If c.HasChanges() Then cmp.AddChangedSvc(c)
            End If
        Next
        For Each s In New List(Of String)(dApps.Keys)
            If sBase.dApps.ContainsKey(s) Then
                Dim c = New ProdCmp(s, dApps.Item(s))
                dApps.Item(s).Compare(sBase.dApps.Item(s), c)
                dApps.Remove(s)
                sBase.dApps.Remove(s)
                If c.HasChanges() Then cmp.AddChangedApp(c)
            End If
        Next
        If Me.dSvcs.Count > 0 Or sBase.dSvcs.Count > 0 Then
            If Me.dSvcs.Count > 0 Then
                For Each k In New List(Of String)(Me.dSvcs.Keys)
                    cmp.AddRemovedSvc(Me.dSvcs.Item(k))
                Next
            End If
            If sBase.dSvcs.Count > 0 Then
                For Each k In New List(Of String)(sBase.dSvcs.Keys)
                    cmp.AddAddedSvc(sBase.dSvcs.Item(k))
                Next
            End If
        End If
        If Me.dApps.Count > 0 Or sBase.dApps.Count > 0 Then
            If Me.dApps.Count > 0 Then
                For Each k In New List(Of String)(Me.dApps.Keys)
                    cmp.AddRemovedApp(Me.dApps.Item(k))
                Next
            End If
            If sBase.dApps.Count > 0 Then
                For Each k In New List(Of String)(sBase.dApps.Keys)
                    cmp.AddAddedApp(sBase.dApps.Item(k))
                Next
            End If
        End If
    End Sub
End Class

Class CmpResult
    Protected infoCmp As SynCmp
    Protected svcCmps As List(Of SynCmp)
    Protected appCmps As List(Of ProdCmp)
    Protected removedApps As List(Of SynApp)
    Protected addedApps As List(Of SynApp)
    Protected addedSvcs As List(Of SynProps)
    Protected removedSvcs As List(Of SynProps)
    Public Sub New()
        svcCmps = New List(Of SynCmp)()
        appCmps = New List(Of ProdCmp)()
        addedSvcs = New List(Of SynProps)()
        removedSvcs = New List(Of SynProps)()
        addedApps = New List(Of SynApp)()
        removedApps = New List(Of SynApp)()
    End Sub
    Public Property InfoSynCmp() As SynCmp
        Get
            Return infoCmp
        End Get
        Set(ByVal value As SynCmp)
            infoCmp = value
        End Set
    End Property
    Public Sub AddChangedSvc(ByRef s As SynCmp)
        svcCmps.Add(s)
    End Sub
    Public Sub AddChangedApp(ByRef s As ProdCmp)
        appCmps.Add(s)
    End Sub

    Public Sub AddAddedApp(ByRef a As SynApp)
        addedApps.Add(a)
    End Sub
    Public Sub AddRemovedApp(ByRef a As SynApp)
        removedApps.Add(a)
    End Sub
    Public Sub AddAddedSvc(ByRef a As SynProps)
        addedSvcs.Add(a)
    End Sub
    Public Sub AddRemovedSvc(ByRef a As SynProps)
        removedSvcs.Add(a)
    End Sub
    Public Sub ToXml(ByRef w As XmlTextWriter)
        w.WriteStartElement("result")
        infoCmp.ToXml(w)
        If svcCmps.Count > 0 Or addedSvcs.Count > 0 Or removedSvcs.Count > 0 Then
            w.WriteStartElement("services")
            If svcCmps.Count > 0 Then
                w.WriteStartElement("changedServices")
                w.WriteAttributeString("count", svcCmps.Count)
                For Each x In svcCmps
                    x.ToXml(w)
                Next
                w.WriteEndElement()
            End If
            If addedSvcs.Count > 0 Then
                w.WriteStartElement("addedServices")
                w.WriteAttributeString("count", addedSvcs.Count)
                For Each x In addedSvcs
                    x.ToXml(w)
                Next
                w.WriteEndElement()
            End If
            If removedSvcs.Count > 0 Then
                w.WriteStartElement("removedServices")
                w.WriteAttributeString("count", removedSvcs.Count)
                For Each x In removedSvcs
                    x.ToXml(w)
                Next
                w.WriteEndElement()
            End If
            w.WriteEndElement()
        End If
        If appCmps.Count > 0 Or addedApps.Count > 0 Or removedApps.Count > 0 Then
            w.WriteStartElement("products")
            If appCmps.Count > 0 Then
                w.WriteStartElement("changedProducts")
                w.WriteAttributeString("count", appCmps.Count)
                For Each x In appCmps
                    x.ToXml(w)
                Next
                w.WriteEndElement()
            End If
            If addedApps.Count > 0 Then
                w.WriteStartElement("addedProducts")
                w.WriteAttributeString("count", addedApps.Count)
                For Each x In addedApps
                    x.ToXml(w)
                Next
                w.WriteEndElement()
            End If
            If removedApps.Count > 0 Then
                w.WriteStartElement("removedProducts")
                w.WriteAttributeString("count", removedApps.Count)
                For Each x In removedApps
                    x.ToXml(w)
                Next
                w.WriteEndElement()
            End If
            w.WriteEndElement()
        End If
        w.WriteEndElement()
    End Sub
End Class

Class ProdCmp
    Inherits SynCmp
    Protected parent As SynApp
    Protected patchDiffs As List(Of SynCmp)
    Protected addedPatches As List(Of SynProps)
    Protected removedPatches As List(Of SynProps)
    Public Sub New(ByVal id As String, ByRef parent As SynApp)
        MyBase.New("app", id)
        patchDiffs = New List(Of SynCmp)()
        addedPatches = New List(Of SynProps)()
        removedPatches = New List(Of SynProps)()
    End Sub
    Public Sub AddPatchDiff(ByRef sCmp As SynCmp)
        patchDiffs.Add(sCmp)
    End Sub
    Public Sub AddAddedPatch(ByRef sP As SynProps)
        addedPatches.Add(sP)
    End Sub
    Public Sub AddRemovedPatch(ByRef sP As SynProps)
        removedPatches.Add(sP)
    End Sub
    Public Overloads Function HasChanges() As Boolean
        HasChanges = MyBase.HasChanges Or patchDiffs.Count > 0 Or addedPatches.Count > 0 Or removedPatches.Count > 0
    End Function
    Public Overloads Sub ToXml(ByRef w As XmlTextWriter)
        If MyBase.HasChanges Then
            MyBase.ToXml(w, False)
        Else
            w.WriteStartElement(nodeName)
            w.WriteAttributeString("id", objId)
        End If
        If addedPatches.Count > 0 Then
            w.WriteStartElement("addedPatches")
            w.WriteAttributeString("count", addedPatches.Count)
            For Each k In addedPatches
                k.ToXml(w)
            Next
            w.WriteEndElement()
        End If
        If removedPatches.Count > 0 Then
            w.WriteStartElement("removedPatches")
            w.WriteAttributeString("count", removedPatches.Count)
            For Each k In removedPatches
                k.ToXml(w)
            Next
            w.WriteEndElement()
        End If
        If patchDiffs.Count > 0 Then
            w.WriteStartElement("changedPatches")
            w.WriteAttributeString("count", patchDiffs.Count)
            For Each p In patchDiffs
                p.ToXml(w)
            Next
            w.WriteEndElement()
        End If
        w.WriteEndElement()
    End Sub
End Class


Class SynCmp
    Protected subProps As SynProps = Nothing
    Protected nodeName As String
    Protected isNew As Boolean
    Protected objId As String
    Protected dDiffs As List(Of SynDiff)
    Protected dRemoved As Dictionary(Of String, String)
    Protected dAdded As Dictionary(Of String, String)
    Protected aggCmp As SynCmp = Nothing


    Public Sub New(ByVal nName As String, ByVal id As String, Optional ByVal bNew As Boolean = False)
        nodeName = nName
        objId = id
        dDiffs = New List(Of SynDiff)()
        dRemoved = New Dictionary(Of String, String)
        dAdded = New Dictionary(Of String, String)
        isNew = bNew
    End Sub
    Public Function HasChanges() As Boolean
        Dim t = dDiffs.Count > 0 Or dRemoved.Count > 0 Or dAdded.Count > 0 Or Not IsNothing(subProps)
        If Not IsNothing(aggCmp) Then
            t = t Or aggCmp.HasChanges
        End If
        HasChanges = t
    End Function
    Public Sub SetAggSynCmp(ByRef s As SynCmp)
        aggCmp = s
    End Sub
    Public Sub AddDiff(ByVal pName As String, ByVal oldVal As String, ByVal newVal As String)
        dDiffs.Add(New SynDiff(pName, oldVal, newVal))
    End Sub
    Public Sub AddRemoved(ByVal pName As String, ByVal val As String)
        dRemoved.Add(pName, val)
    End Sub
    Public Sub AddAdded(ByVal pName As String, ByVal val As String)
        dAdded.Add(pName, val)
    End Sub
    Public Sub SetSubProps(ByRef dP As SynProps, ByVal bNew As Boolean)
        isNew = bNew
        subProps = dP
    End Sub

    Public Sub ToXml(ByRef w As XmlTextWriter, Optional ByVal bClose As Boolean = True)
        If HasChanges() Then
            w.WriteStartElement(nodeName)
            If Not IsNothing(objId) Then w.WriteAttributeString("id", objId)

            If dAdded.Count > 0 Then
                w.WriteStartElement("addedProperties")
                w.WriteAttributeString("count", dAdded.Count)
                For Each k In dAdded.Keys
                    w.WriteStartElement("p")
                    w.WriteAttributeString("name", k)
                    w.WriteString(dAdded.Item(k))
                    w.WriteEndElement()
                Next
                w.WriteEndElement()
            End If
            If dRemoved.Count > 0 Then
                w.WriteStartElement("removedProperties")
                w.WriteAttributeString("count", dRemoved.Count)
                For Each k In dRemoved.Keys
                    w.WriteStartElement("p")
                    w.WriteAttributeString("name", k)
                    w.WriteString(dRemoved.Item(k))
                    w.WriteEndElement()
                Next
                w.WriteEndElement()
            End If
            If dDiffs.Count > 0 Then
                w.WriteStartElement("changedProperties")
                w.WriteAttributeString("count", dDiffs.Count)
                For Each p In dDiffs
                    p.ToXml(w)
                Next
                w.WriteEndElement()
            End If
            If Not IsNothing(aggCmp) Then
                aggCmp.ToXml(w)
            End If
            If Not IsNothing(subProps) Then
                If isNew Then
                    w.WriteStartElement("addedSubProperties")
                Else
                    w.WriteStartElement("removedSubProperties")
                End If
                subProps.ToXml(w)
                w.WriteEndElement()
            End If

            If bClose Then w.WriteEndElement()
        End If
    End Sub
End Class

Class SynDiff
    Private pNam As String
    Private sOld As String
    Private sNew As String
    Public Sub New(ByVal name As String, ByVal oldV As String, ByVal newV As String)
        pNam = name
        sOld = oldV
        sNew = newV
    End Sub

    Public Sub ToXml(ByRef w As XmlTextWriter)
        w.WriteStartElement("p")
        w.WriteAttributeString("name", pNam)
        w.WriteStartElement("oldValue")
        w.WriteString(sOld)
        w.WriteEndElement()
        w.WriteStartElement("newValue")
        w.WriteString(sNew)
        w.WriteEndElement()
        w.WriteEndElement()
    End Sub
End Class



Class SynApp
    Inherits SynProps
    Protected appPatches As Dictionary(Of String, SynProps)
    Public Sub New()
        MyBase.New("app", "reg.info")
        appPatches = New Dictionary(Of String, SynProps)
    End Sub
    Public Sub AddPatch(ByVal name As String, ByRef sPatch As SynProps)
        appPatches.Add(name, sPatch)
    End Sub
    Public Function GetPatch(ByVal name As String) As SynProps
        GetPatch = appPatches.Item(name)
    End Function
    Public Function PatchExists(ByVal name As String) As Boolean
        PatchExists = appPatches.ContainsKey(name)
    End Function
    Public Function PatchesKeys() As ICollection(Of String)
        PatchesKeys = appPatches.Keys
    End Function
    Public Overloads Sub Parse(ByRef xml As XmlElement)
        If xml.HasAttribute("id") Then
            Id = xml.GetAttribute("id")
        End If
        For Each x As XmlElement In xml.ChildNodes
            If x.HasChildNodes Then
                If x.Name.Equals("patches") Then
                    For Each xp As XmlElement In x.ChildNodes
                        Dim p = New SynProps("patch", "reg.info")
                        p.Parse(xp)
                        appPatches.Add(p.Id, p)
                    Next
                Else
                    If x.FirstChild.NodeType = XmlNodeType.Text And x.Name.Equals("prop") Then
                        AddProperty(x.Attributes("name").Value, x.InnerText)
                    Else
                        If HasSubProps() Then SubProperties.Parse(x)
                    End If
                End If
            Else
                If x.Name.Equals("prop") Then AddProperty(x.Attributes("name").Value, "")
            End If
        Next
    End Sub
    Public Overloads Sub ToXml(ByRef w As XmlTextWriter)
        w.WriteStartElement(NodeName)
        If Not IsNothing(Id) Then w.WriteAttributeString("id", Id)
        For Each s As String In PropertyKeys()
            w.WriteStartElement(s)
            w.WriteString(GetProperty(s))
            w.WriteEndElement()
        Next
        If HasSubProps() Then SubProperties.ToXml(w)
        If appPatches.Count > 0 Then
            w.WriteStartElement("patches")
            w.WriteAttributeString("count", appPatches.Count)
            For Each p In appPatches.Values()
                p.ToXml(w)
            Next
            w.WriteEndElement()
        End If
        w.WriteEndElement()
    End Sub
    Public Overloads Sub Compare(ByRef sBase As SynApp, ByRef pCmp As ProdCmp)
        If Me.Id = sBase.Id Then
            MyBase.Compare(sBase, pCmp)
            For Each p In New List(Of String)(appPatches.Keys)
                If sBase.appPatches.ContainsKey(p) Then
                    Dim s = Me.appPatches(p)
                    Dim c = New SynCmp(s.NodeName, s.Id)
                    s.Compare(sBase.appPatches.Item(p), c)
                    If c.HasChanges() Then pCmp.AddPatchDiff(c)
                    appPatches.Remove(p)
                    sBase.appPatches.Remove(p)
                End If
            Next
            If appPatches.Count > 0 Then
                For Each p In appPatches.Values
                    pCmp.AddRemovedPatch(p)
                Next
            End If
            If sBase.appPatches.Count > 0 Then
                For Each p In sBase.appPatches.Values
                    pCmp.AddAddedPatch(p)
                Next
            End If
        End If
    End Sub
End Class


Class SynProps
    Private sId As String
    Private name As String
    Private dProps As Dictionary(Of String, String)
    Private subProps As SynProps = Nothing

    Public Sub New(ByVal nodeName As String)
        Me.New(nodeName, Nothing)
    End Sub
    Public Sub New(ByVal nodeName As String, ByVal subNodName As String)
        name = nodeName
        dProps = New Dictionary(Of String, String)
        If Not IsNothing(subNodName) Then SetSubProperties(subNodName)
    End Sub
    Public Property Id() As String
        Get
            Return sId
        End Get
        Set(ByVal value As String)
            sId = value
        End Set
    End Property
    Public Property NodeName() As String
        Get
            Return name
        End Get
        Set(ByVal value As String)
            name = value
        End Set
    End Property
    Public Function PropertyCount() As Integer
        PropertyCount = dProps.Count
    End Function
    Public Sub AddProperty(ByVal name As String, ByVal val As String)
        dProps.Add(name, val)
    End Sub
    Public Function GetProperty(ByVal name As String) As String
        GetProperty = dProps.Item(name)
    End Function
    Public Function PropertyExists(ByVal name As String) As Boolean
        PropertyExists = dProps.ContainsKey(name)
    End Function
    Public Function PropertyKeys() As ICollection(Of String)
        PropertyKeys = dProps.Keys
    End Function
    Public Sub RemoveProperty(ByVal name As String)
        dProps.Remove(name)
    End Sub
    Public Sub Parse(ByRef xml As XmlElement)
        If xml.HasAttribute("id") Then sId = xml.GetAttribute("id")
        For Each x As XmlNode In xml.ChildNodes
            If x.HasChildNodes Then
                If x.FirstChild.NodeType = XmlNodeType.Text And x.Name.Equals("prop") Then
                    dProps.Add(x.Attributes("name").Value, x.InnerText)
                Else
                    If HasSubProps() Then subProps.Parse(x)
                End If
            Else
                If x.Name.Equals("prop") Then dProps.Add(x.Attributes("name").Value, "")
            End If
        Next
    End Sub
    Public Sub SetSubProperties(ByVal subNodeName As String)
        subProps = New SynProps(subNodeName)
    End Sub
    Public Function SubProperties() As SynProps
        SubProperties = subProps
    End Function
    Public Function HasSubProps() As Boolean
        HasSubProps = Not IsNothing(Me.subProps)
    End Function
    Public Sub ToXml(ByRef w As XmlTextWriter)
        If PropertyCount() > 0 Then
            w.WriteStartElement(NodeName)
            If Not IsNothing(Id) Then w.WriteAttributeString("id", Id)
            For Each s As String In PropertyKeys()
                w.WriteStartElement(s)
                w.WriteString(GetProperty(s))
                w.WriteEndElement()
            Next
            If HasSubProps() Then subProps.ToXml(w)
            w.WriteEndElement()
        End If
    End Sub
    Public Sub Compare(ByRef sBase As SynProps, ByRef sCmp As SynCmp)
        If Me.Id = sBase.Id Then
            For Each k In New List(Of String)(Me.PropertyKeys)
                If sBase.PropertyExists(k) Then
                    Dim rV = Me.GetProperty(k)
                    Dim cV = sBase.GetProperty(k)
                    If Not rV = cV Then sCmp.AddDiff(k, rV, cV)
                    Me.RemoveProperty(k)
                    sBase.RemoveProperty(k)
                End If
            Next

            If Me.PropertyCount > 0 Then
                For Each k In Me.PropertyKeys
                    sCmp.AddRemoved(k, Me.GetProperty(k))
                Next
            End If

            If sBase.PropertyCount > 0 Then
                For Each k In sBase.PropertyKeys
                    sCmp.AddAdded(k, sBase.GetProperty(k))
                Next
            End If
        End If

        If Not IsNothing(sBase.subProps) And Not IsNothing(Me.subProps) Then
            Dim s = New SynCmp(Me.subProps.NodeName, Me.subProps.Id)
            Me.subProps.Compare(sBase.subProps, s)
            sCmp.SetAggSynCmp(s)
        Else
            If Not IsNothing(Me.subProps) Then sCmp.SetSubProps(Me.subProps, False)
            If Not IsNothing(sBase.subProps) Then sCmp.SetSubProps(sBase.subProps, True)
        End If
    End Sub
End Class
