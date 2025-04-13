
Class Synfo{
    [string]$ConfigXml = "$global:PSScriptRoot\synfo.xml"
    $WCObjects = [System.Collections.ArrayList]@() 
    [void]DumpObjects(){
        [xml]$xml = gc $this.ConfigXml
        foreach($child in $xml.DocumentElement.dump.ChildNodes){
            [System.Xml.XmlElement]$ch = $child
            $typ = $ch.GetAttribute("typ")
            switch($typ){
                'wmi'{ $this.ReadWMIObjects($ch)  }
                'reg'{ $this.ReadRegObjects($ch)  }
                'wix'{ $this.ReadWIXObjects($ch)  }
                'nfo'{ $this.ReadComputerInfo($ch)}
                default{}
            }
        }
    }
    [void]ReadComputerInfo([System.Xml.XmlElement]$xml){
        $this.DumpCurrentMethod()
        $wco = [WinCompObject]::new($xml.LocalName,$env:COMPUTERNAME)
        $this.WCObjects.Add($wco)

        $fld = $xml.SelectSingleNode("fld").InnerText.Split(",")
        $nfo = gwmi -ClassName Win32_OperatingSystem -Property $fld 
        foreach($p in $nfo.Properties){ $wco.AddProp($p.Name,$p.Value)  }

        $wen = [WinCompObject]::new("envvars","SYSTEM")
        $wco.SubProps = $wen
        $sev = [Environment]::GetEnvironmentVariables(2)
        foreach($p in $sev.Keys){ $wen.AddProp($p,$sev[$p])    }        
        
    }
    [void]ReadWIXObjects([System.Xml.XmlElement]$xml){
        $this.DumpCurrentMethod()
        $obj = $xml.GetAttribute("obj")
        $nam = $xml.LocalName
        $prd = $xml.SelectSingleNode("prd").InnerText.Split(",")
        $pch = $xml.SelectSingleNode("pch").InnerText.Split(",")

        $wi = New-Object -ComObject "WindowsInstaller.Installer"
        $wcc = [WinCompCollection]::new($nam)

        $col =  $wi.GetType().InvokeMember('Products', [System.Reflection.BindingFlags]::GetProperty, $null, $wi, $null)
        foreach($swp in $col){
            $wco = [WinCompObject]::new($obj,$swp)
            foreach($p in $prd){  $wco.AddProp($p,$wi.ProductInfo($swp, $p))  }
            $pat = $wi.PatchesEx($swp,"",4,15)
            if($pat.Count() -gt 0){
                $pcc = [WinCompCollection]::new("patches")
                foreach($q in $pat){
                    $k = $q.PatchProperty("DisplayName")
                    if($k -ne $null -and $k.Contains("(KB")){$k = $k.SubString($k.IndexOf("KB"),9)}
                    $pco = [WinCompObject]::new("patch",$k)
                    foreach($p in $pch){
                        $v = ""
                        try{ $v = $q.PatchProperty($p) } catch{}
                        $pco.AddProp($p,$v)
                    }
                    $pcc.Add($pco)
                }
                $wco.SubObjects = $pcc
            }
            $wcc.Add($wco)
        }
        $this.WCObjects.Add($wcc)
        
    }
    [void]ReadRegObjects([System.Xml.XmlElement]$xml){
        $this.DumpCurrentMethod()
        $obj = $xml.GetAttribute("obj")
        $nam = $xml.LocalName
        $wcc = [WinCompCollection]::new($nam)
        foreach($cNode in $xml.ChildNodes){
            $rks = gci "HKLM:$($cNode.InnerText)"
            foreach($rap in $rks){
                $wco = [WinCompObject]::new($obj, $rap.PSChildName)
                $props = $rap | Get-Item 
                foreach($p in $props.Property){$wco.AddProp($p,[Synfo]::ToStringValue($props.GetValue($p)))  }
                if(!$wcc.Objects.ContainsKey($wco.Id)){  $wcc.Objects.Add($wco.Id,$wco) }
            }
        }
        $this.WCObjects.Add($wcc)
    }
    [void]ReadWMIObjects([System.Xml.XmlElement]$xml){
        $this.DumpCurrentMethod()
        $obj = $xml.GetAttribute("obj")
        $nam = $xml.LocalName
        $cls = $xml.SelectSingleNode("cls").InnerText
        $fld = $xml.SelectSingleNode("fld").InnerText
        $key = $xml.SelectSingleNode("key").InnerText
        $ext = $xml.SelectSingleNode("ext")
        $col = gwmi -Query "SELECT $fld FROM $cls"
        $wcc = [WinCompCollection]::new($nam)
        foreach($wmo in $col){
            $kvl = $wmo.Properties.Item($key).Value
            $wco = [WinCompObject]::new($obj, $kvl)
            foreach($p in $wmo.Properties){ $wco.AddProp($p.Name,$p.Value)}
            if($ext -ne $null){ 
                $cus = $ext.Attributes.GetNamedItem("fld").Value
                $pth = $wco.Objects[$ext.InnerText]
                if($cus -eq 'Version' -and $pth -ne $null -and $pth -ne [string]::Empty){
                    if($pth.Contains('svchost.exe') -eq $false -and (Test-Path $pth)){
                        $ver = (gi $pth).VersionInfo.FileVersion
                        if($ver -ne $null){ $wco.AddProp($cus,($ver.Split(" "))[0]) } 
                    }
                }
            }
            $wcc.Objects.Add($wco.Id,$wco)
        }
        $this.WCObjects.Add($wcc)
    }
    [void]ReadXML([string]$synfoXml){
        [xml]$xml = gc $synfoXml
        foreach($child in $xml.DocumentElement.ChildNodes){
            [System.Xml.XmlElement]$ch = $child
            if($ch.HasAttribute("count")){
                $wc = [WinCompCollection]::ParseXml($ch)
                $this.WCObjects.Add($wc)
            }elseif($ch.HasAttribute("id")){
                $wc = [WinCompObject]::ParseXml($ch)
                $this.WCObjects.Add($wc)
            }
        }
    }
    [void]SaveToXML([string]$outXmlPath){
        $writer = [System.Xml.XmlTextWriter]::new($outXmlPath, [Text.Encoding]::UTF8)
        $writer.Formatting = [System.Xml.Formatting]::Indented
        $writer.WriteStartDocument()
        $writer.WriteStartElement("synfo")
        foreach($wco in $this.WCObjects){ $wco.WriteXml($writer) }
        $writer.WriteEndElement()
        $writer.WriteEndDocument()
        $writer.Close()
    }
    [void]DumpCurrentMethod () {
        Write-Host($(Get-PSCallStack)[1].FunctionName)
    }
    static [string]ToStringValue($pVal){
        $p = ""
        if($pVal -eq $null){ return $p }
        $t = $pVal.GetType()
        switch($t){
            'string'{ $p = $pVal.replace("`0","")  }
            'int'{  $p = "$pVal" }
            'string[]'{ $p = $pVal -join "|" }
            default{ $p = "[$t]"}
        }
        return $p
    }
}

Class WinComp{
    [string] $Id
    [Hashtable] $Objects 
    WinComp([string]$Id){ $this.Id = $Id; $this.Objects= @{} }
    [void]WriteXml([System.Xml.XmlTextWriter]$Writer){
        $Writer.WriteStartElement($this.Id)
        $Writer.WriteAttributeString("count", $this.Objects.Count)
        foreach($wco in $this.Objects.Values){
            $wco.WriteXML($Writer)
        }
        $Writer.WriteEndElement()
    }
}

Class WinCompCollection : WinComp{
    WinCompCollection([string]$Name):base($Name){}
    [void]Add([WinCompObject]$wcObj){ $this.Objects.Add($wcObj.Id, $wcObj)}
    [int]Count(){ return $this.Objects.Count}
    static [WinCompCollection]ParseXml([System.Xml.XmlElement]$xml){
        $wc = [WinCompCollection]::new($xml.LocalName)
        foreach($cNode in $xml.ChildNodes){
            [System.Xml.XmlElement]$cXml = $cNode
            $cwo = [WinCompObject]::ParseXml($cXml)
            $wc.Objects.Add($cwo.Id,$cwo)
        }
        return $wc
    }
}

Class WinCompObject : WinComp{
    [string] $Type
    [WinCompObject] $SubProps = $null
    [WinCompCollection] $SubObjects = $null

    WinCompObject([string]$Type, [string]$Id):base($Id){$this.Type = $Type}
    [void]AddProp([string]$Name,[string]$Value){ $this.Objects.Add($Name,$Value)}
    [bool]HasSubProps(){ return $this.SubProps -ne $null }
    [void]WriteXml([System.Xml.XmlTextWriter]$Writer){
        if($this.Objects.Count -eq 0){ return }
        $writer.WriteStartElement($this.Type)
        $writer.WriteAttributeString("id",$this.Id)
        foreach($name in $this.Objects.Keys){
            $writer.WriteStartElement("prop")
            $writer.WriteAttributeString("name", $name)
            $writer.WriteString($this.Objects[$name])
            $writer.WriteEndElement()
        }
        if($this.SubProps -ne $null){ $this.SubProps.WriteXml($Writer) }
        if($this.SubObjects -ne $null){ $this.SubObjects.WriteXml($Writer)}
        $writer.WriteEndElement()
    }
    static [WinCompObject]ParseXml([System.Xml.XmlElement]$xml){
        $wc = [WinCompObject]::new($xml.LocalName,$xml.GetAttribute("id"))
        foreach($cNode in $xml.ChildNodes){
            [System.Xml.XmlElement]$cXml = $cNode
            if($cXml.LocalName -eq "prop"){ $wc.AddProp($cXml.GetAttribute("name"),$cXml.InnerText)}
            elseif($cXml.HasAttribute("id")){
                $wc.SubProps = [WinCompObject]::ParseXml($cXml)
            }elseif($cXml.HasAttribute("count")){
                $wc.SubObjects = [WinCompCollection]::ParseXml($cXml)
            }
        }
        return $wc
    }

}


$syn = [Synfo]::new()
#$syn.ReadXML("$PSScriptRoot\sample.xml")

$syn.DumpObjects()
$syn.SaveToXML("$PSScriptRoot\testsave.xml")