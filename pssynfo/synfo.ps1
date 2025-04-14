
Class Synfo{
    [string]$_DEFCFG="PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiID8+CjxzeW5mbz4KCTxkdW1wPgoJCTxjb21waW5mbyB0eXA9Im5mbyIgb2JqPSJuZm8iPgoJCQk8ZmxkPlZlcnNpb24sQ2FwdGlvbixJbnN0YWxsRGF0ZSxMb2NhbGUsT1NBcmNoaXRlY3R1cmUsT1NMYW5ndWFnZSxTeXN0ZW1EaXJlY3RvcnksU3lzdGVtRHJpdmUsVG90YWxWaXNpYmxlTWVtb3J5U2l6ZTwvZmxkPgoJCTwvY29tcGluZm8+CgkJPHNlcnZpY2VzIHR5cD0id21pIiBvYmo9InN2YyI+CgkJCTxjbHM+V2luMzJfU2VydmljZTwvY2xzPgoJCQk8ZmxkPkFjY2VwdFN0b3AsQ2FwdGlvbixDaGVja1BvaW50LENyZWF0aW9uQ2xhc3NOYW1lLERlc2NyaXB0aW9uLERlc2t0b3BJbnRlcmFjdCxEaXNwbGF5TmFtZSxFcnJvckNvbnRyb2wsRXhpdENvZGUsSW5zdGFsbERhdGUsTmFtZSxQYXRoTmFtZSxQcm9jZXNzSWQsU2VydmljZVNwZWNpZmljRXhpdENvZGUsU2VydmljZVR5cGUsU3RhcnRlZCxTdGFydE1vZGUsU3RhcnROYW1lLFN0YXRlLFN0YXR1cyxTeXN0ZW1DcmVhdGlvbkNsYXNzTmFtZSxTeXN0ZW1OYW1lLFRhZ0lkLFdhaXRIaW50PC9mbGQ+CgkJCTxrZXk+TmFtZTwva2V5PgoJCQk8ZXh0IGZsZD0iVmVyc2lvbiI+UGF0aE5hbWU8L2V4dD4KCQk8L3NlcnZpY2VzPgoJCTxob3RmaXhlcyB0eXA9IndtaSIgb2JqPSJxZmUiPgoJCQk8Y2xzPldpbjMyX1F1aWNrRml4RW5naW5lZXJpbmc8L2Nscz4KCQkJPGZsZD5DYXB0aW9uLERlc2NyaXB0aW9uLEhvdEZpeElELEluc3RhbGxlZEJ5LEluc3RhbGxlZE9uPC9mbGQ+CgkJCTxrZXk+SG90Rml4SUQ8L2tleT4KCQk8L2hvdGZpeGVzPgoJCTxkcml2ZXJzIHR5cD0id21pIiBvYmo9ImRydiI+CgkJCTxjbHM+V2luMzJfU3lzdGVtRHJpdmVyPC9jbHM+CgkJCTxmbGQ+QWNjZXB0UGF1c2UsQWNjZXB0U3RvcCxDYXB0aW9uLERlc2NyaXB0aW9uLERlc2t0b3BJbnRlcmFjdCxEaXNwbGF5TmFtZSxFcnJvckNvbnRyb2wsRXhpdENvZGUsTmFtZSxQYXRoTmFtZSxTZXJ2aWNlU3BlY2lmaWNFeGl0Q29kZSxTZXJ2aWNlVHlwZSxTdGFydGVkLFN0YXJ0TW9kZSxTdGFydE5hbWUsU3RhdGUsU3RhdHVzLFRhZ0lkPC9mbGQ+CgkJCTxrZXk+TmFtZTwva2V5PgoJCQk8ZXh0IGZsZD0iVmVyc2lvbiI+UGF0aE5hbWU8L2V4dD4KCQk8L2RyaXZlcnM+CgkJPGFycHJlZ3MgdHlwPSJyZWciIG9iaj0iYXJwIj4KCQkJPHg2ND5TT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxVbmluc3RhbGxcPC94NjQ+CgkJCTx4ODY+U09GVFdBUkVcV09XNjQzMk5vZGVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cVW5pbnN0YWxsXDwveDg2PgoJCTwvYXJwcmVncz4KCQk8cHJvZHVjdHMgdHlwPSJ3aXgiIG9iaj0iYXBwIj4KCQkJPHByZD5Qcm9kdWN0TmFtZSxWZXJzaW9uU3RyaW5nLEluc3RhbGxEYXRlLFB1Ymxpc2hlcixVUkxJbmZvQWJvdXQsSW5zdGFsbExvY2F0aW9uLEluc3RhbGxTb3VyY2UsUGFja2FnZU5hbWU8L3ByZD4KCQkJPHBjaD5EaXNwbGF5TmFtZSxJbnN0YWxsRGF0ZSxNb3JlSW5mb1VSTCxTdGF0ZSxMb2NhbFBhY2thZ2UsVHJhbnNmb3JtcyxVbmluc3RhbGxhYmxlPC9wY2g+CgkJPC9wcm9kdWN0cz4KCTwvZHVtcD4KCTxjb21wPgoJPC9jb21wPgo8L3N5bmZvPg=="
    [string]$ConfigXml = "$global:PSScriptRoot\synfo.xml"
    $WCObjects = [System.Collections.ArrayList]@() 
    [void]DumpObjects(){
        if(!(Test-Path $this.ConfigXml)){
            [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($this._DEFCFG)) | Out-File $this.ConfigXml -Encoding utf8
        }
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
    [string]CurrentMethod () {
        return (Get-PSCallStack)[1].FunctionName
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
$syn.DumpObjects()
$syn.SaveToXML("$PSScriptRoot\testsave.xml")
