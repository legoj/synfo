
Class Synfo{
    static [string]$_DEFCFG="PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiID8+CjxzeW5mbz4KCTxkdW1wPgoJCTxjb21waW5mbyB0eXA9Im5mbyIgb2JqPSJuZm8iPgoJCQk8ZmxkPlZlcnNpb24sQ2FwdGlvbixJbnN0YWxsRGF0ZSxMb2NhbGUsT1NBcmNoaXRlY3R1cmUsT1NMYW5ndWFnZSxTeXN0ZW1EaXJlY3RvcnksU3lzdGVtRHJpdmUsVG90YWxWaXNpYmxlTWVtb3J5U2l6ZTwvZmxkPgoJCTwvY29tcGluZm8+CgkJPHNlcnZpY2VzIHR5cD0id21pIiBvYmo9InN2YyI+CgkJCTxjbHM+V2luMzJfU2VydmljZTwvY2xzPgoJCQk8ZmxkPkFjY2VwdFN0b3AsQ2FwdGlvbixDaGVja1BvaW50LENyZWF0aW9uQ2xhc3NOYW1lLERlc2NyaXB0aW9uLERlc2t0b3BJbnRlcmFjdCxEaXNwbGF5TmFtZSxFcnJvckNvbnRyb2wsRXhpdENvZGUsSW5zdGFsbERhdGUsTmFtZSxQYXRoTmFtZSxQcm9jZXNzSWQsU2VydmljZVNwZWNpZmljRXhpdENvZGUsU2VydmljZVR5cGUsU3RhcnRlZCxTdGFydE1vZGUsU3RhcnROYW1lLFN0YXRlLFN0YXR1cyxTeXN0ZW1DcmVhdGlvbkNsYXNzTmFtZSxTeXN0ZW1OYW1lLFRhZ0lkLFdhaXRIaW50PC9mbGQ+CgkJCTxrZXk+TmFtZTwva2V5PgoJCQk8ZXh0IGZsZD0iVmVyc2lvbiI+UGF0aE5hbWU8L2V4dD4KCQk8L3NlcnZpY2VzPgoJCTxob3RmaXhlcyB0eXA9IndtaSIgb2JqPSJxZmUiPgoJCQk8Y2xzPldpbjMyX1F1aWNrRml4RW5naW5lZXJpbmc8L2Nscz4KCQkJPGZsZD5DYXB0aW9uLERlc2NyaXB0aW9uLEhvdEZpeElELEluc3RhbGxlZEJ5LEluc3RhbGxlZE9uPC9mbGQ+CgkJCTxrZXk+SG90Rml4SUQ8L2tleT4KCQk8L2hvdGZpeGVzPgoJCTxkcml2ZXJzIHR5cD0id21pIiBvYmo9ImRydiI+CgkJCTxjbHM+V2luMzJfU3lzdGVtRHJpdmVyPC9jbHM+CgkJCTxmbGQ+QWNjZXB0UGF1c2UsQWNjZXB0U3RvcCxDYXB0aW9uLERlc2NyaXB0aW9uLERlc2t0b3BJbnRlcmFjdCxEaXNwbGF5TmFtZSxFcnJvckNvbnRyb2wsRXhpdENvZGUsTmFtZSxQYXRoTmFtZSxTZXJ2aWNlU3BlY2lmaWNFeGl0Q29kZSxTZXJ2aWNlVHlwZSxTdGFydGVkLFN0YXJ0TW9kZSxTdGFydE5hbWUsU3RhdGUsU3RhdHVzLFRhZ0lkPC9mbGQ+CgkJCTxrZXk+TmFtZTwva2V5PgoJCQk8ZXh0IGZsZD0iVmVyc2lvbiI+UGF0aE5hbWU8L2V4dD4KCQk8L2RyaXZlcnM+CgkJPGFycHJlZ3MgdHlwPSJyZWciIG9iaj0iYXJwIj4KCQkJPHg2ND5TT0ZUV0FSRVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxVbmluc3RhbGxcPC94NjQ+CgkJCTx4ODY+U09GVFdBUkVcV09XNjQzMk5vZGVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cVW5pbnN0YWxsXDwveDg2PgoJCTwvYXJwcmVncz4KCQk8cHJvZHVjdHMgdHlwPSJ3aXgiIG9iaj0iYXBwIj4KCQkJPHByZD5Qcm9kdWN0TmFtZSxWZXJzaW9uU3RyaW5nLEluc3RhbGxEYXRlLFB1Ymxpc2hlcixVUkxJbmZvQWJvdXQsSW5zdGFsbExvY2F0aW9uLEluc3RhbGxTb3VyY2UsUGFja2FnZU5hbWU8L3ByZD4KCQkJPHBjaD5EaXNwbGF5TmFtZSxJbnN0YWxsRGF0ZSxNb3JlSW5mb1VSTCxTdGF0ZSxMb2NhbFBhY2thZ2UsVHJhbnNmb3JtcyxVbmluc3RhbGxhYmxlPC9wY2g+CgkJPC9wcm9kdWN0cz4KCTwvZHVtcD4KCTxjb21wPgoJPC9jb21wPgo8L3N5bmZvPg=="
    [string]$ConfigXml = "$global:PSScriptRoot\synfo.xml"
    [WCO]$SysProps = $null  #WCO
    $WCObjects = @{}   #WCC coll
    [void]DumpObjects(){
        if(!(Test-Path $this.ConfigXml)){
            [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String([Synfo]::_DEFCFG)) | Out-File $this.ConfigXml -Encoding utf8
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
        Write-Host "Dumping System Info"
        $this.SysProps = [WCO]::new($xml.LocalName,$env:COMPUTERNAME)

        $fld = $xml.SelectSingleNode("fld").InnerText.Split(",")
        Write-Host "AddProps from WMI.OS"
        $nfo = gwmi -ClassName Win32_OperatingSystem -Property $fld 
        foreach($p in $nfo.Properties){ $this.SysProps.AddProp($p.Name,$p.Value)  }

        $wen = [WCO]::new("envvars","SYSTEM")
        $this.SysProps.SubProps = $wen
        $sev = [Environment]::GetEnvironmentVariables(2)
        Write-Host "AddProps from ENV.Vars - SYSTEM"
        foreach($p in $sev.Keys){ $wen.AddProp($p,$sev[$p])    }        
        
    }
    [void]ReadWIXObjects([System.Xml.XmlElement]$xml){
        $obj = $xml.GetAttribute("obj")
        $nam = $xml.LocalName
        $prd = $xml.SelectSingleNode("prd").InnerText.Split(",")
        $pch = $xml.SelectSingleNode("pch").InnerText.Split(",")
        Write-Host "Dumping WIX Products"
        $wi = New-Object -ComObject "WindowsInstaller.Installer"
        $wcc = [WCC]::new($nam)

        $col =  $wi.GetType().InvokeMember('Products', [System.Reflection.BindingFlags]::GetProperty, $null, $wi, $null)
        foreach($swp in $col){
            $wco = [WCO]::new($obj,$swp)
            Write-Host "WCO.$obj - $swp"
            foreach($p in $prd){  $wco.AddProp($p,$wi.ProductInfo($swp, $p))  }
            $pat = $wi.PatchesEx($swp,"",4,15)
            if($pat.Count() -gt 0){
                $pcc = [WCC]::new("patches")
                foreach($q in $pat){
                    $k = $q.PatchProperty("DisplayName")
                    if($k -ne $null -and $k.Contains("(KB")){$k = $k.SubString($k.IndexOf("KB"),9)}
                    $pco = [WCO]::new("patch",$k)
                    foreach($p in $pch){
                        $v = ""
                        try{ $v = $q.PatchProperty($p) } catch{}
                        $pco.AddProp($p,$v)
                    }
                    $pcc.Members.Add($pco.Id,$pco)
                }
                $wco.SubObjects = $pcc
            }
            $wcc.Members.Add($wco.Id,$wco)
        }
        $this.WCObjects.Add($wcc.Name,$wcc)
        
    }
    [void]ReadRegObjects([System.Xml.XmlElement]$xml){
        $obj = $xml.GetAttribute("obj")
        $nam = $xml.LocalName        
        $wcc = [WCC]::new($nam)
        foreach($cNode in $xml.ChildNodes){
            Write-Host "Dumping Reg - $($cNode.InnerText)"
            $rks = gci "HKLM:$($cNode.InnerText)"
            foreach($rap in $rks){
                $wco = [WCO]::new($obj, $rap.PSChildName)
                Write-Host "WCO.$obj - $($rap.PSChildName)"
                $props = $rap | Get-Item 
                foreach($p in $props.Property){$wco.AddProp($p,[Synfo]::ToStringValue($props.GetValue($p)))  }
                if(!$wcc.Members.ContainsKey($wco.Id)){  $wcc.Members.Add($wco.Id,$wco) }
            }
        }
        $this.WCObjects.Add($wcc.Name,$wcc)
    }
    [void]ReadWMIObjects([System.Xml.XmlElement]$xml){
        $obj = $xml.GetAttribute("obj")
        $nam = $xml.LocalName
        $cls = $xml.SelectSingleNode("cls").InnerText
        $fld = $xml.SelectSingleNode("fld").InnerText
        $key = $xml.SelectSingleNode("key").InnerText
        $ext = $xml.SelectSingleNode("ext")
        Write-Host "Dumping WMI instance - $cls"
        $col = gwmi -Query "SELECT $fld FROM $cls"
        $wcc = [WCC]::new($nam)
        foreach($wmo in $col){
            $kvl = $wmo.Properties.Item($key).Value
            $wco = [WCO]::new($obj, $kvl)
            Write-Host "WCO.$obj - $kvl"
            foreach($p in $wmo.Properties){ $wco.AddProp($p.Name,$p.Value)}
            if($ext -ne $null){ 
                $cus = $ext.Attributes.GetNamedItem("fld").Value
                $pth = $wco.Members[$ext.InnerText]
                if($cus -eq 'Version' -and $pth -ne $null -and $pth -ne [string]::Empty){
                    if($pth.Contains('svchost.exe') -eq $false -and (Test-Path $pth)){
                        $ver = (gi $pth).VersionInfo.FileVersion
                        if($ver -ne $null){ $wco.AddProp($cus,($ver.Split(" "))[0]) } 
                    }
                }
            }
            $wcc.Members.Add($wco.Id,$wco)

        }
        $this.WCObjects.Add($wcc.Name,$wcc)
    }
    [void]ReadXML([string]$synfoXml){
        [xml]$xml = gc $synfoXml
        foreach($child in $xml.DocumentElement.ChildNodes){
            [System.Xml.XmlElement]$ch = $child
            if($ch.HasAttribute("count")){
                $wc = [WCC]::ParseXml($ch)
                $this.WCObjects.Add($wc.Name,$wc)
            }elseif($ch.HasAttribute("id")){
                $this.SysProps = [WCO]::ParseXml($ch)
            }
        }
    }
    [void]SaveToXML([string]$outXmlPath){
        $w = [System.Xml.XmlTextWriter]::new($outXmlPath, [Text.Encoding]::UTF8)
        $w.Formatting = [System.Xml.Formatting]::Indented
        $w.WriteStartDocument()
        $w.WriteStartElement("synfo")
        $this.SysProps.WriteXml($w)
        foreach($wco in $this.WCObjects.Values){ $wco.WriteXml($w) }
        $w.WriteEndElement()
        $w.WriteEndDocument()
        $w.Close()
    }
    [string]CurrentMethod () {
        return (Get-PSCallStack)[1].FunctionName
    }
    static [void]CompareXML([string]$refXml,[string]$cmpXml,[string]$resXml){
        $refSyn = [Synfo]::new(); $refSyn.ReadXML($refXml)
        $cmpSyn = [Synfo]::new(); $cmpSyn.ReadXML($cmpXml)

        $w = [System.Xml.XmlTextWriter]::new($resXml, [Text.Encoding]::UTF8)
        $w.Formatting = [System.Xml.Formatting]::Indented
        $w.WriteStartDocument()
        $w.WriteStartElement("synfo")
        $w.WriteStartElement("ref")
        $w.WriteAttributeString("path",$refXml)
        $w.WriteEndElement()
        $w.WriteStartElement("cmp")
        $w.WriteAttributeString("path",$cmpXml)
        $w.WriteEndElement()
        $w.WriteStartElement("result")
        $wcoRes = [CRO]::Compare($refSyn.SysProps,$cmpSyn.SysProps)        
        $w.WriteAttributeString("hasChanges",$wcoRes.HasChanges())
        $wcoRes.WriteXml($w)
        foreach($wcc in $refSyn.WCObjects.Values){            
            $wccRes = [CRC]::Compare($wcc,$cmpSyn.WCObjects[$wcc.Name])
            $wccRes.WriteXml($w)
        }
        $w.WriteEndElement() #result
        $w.WriteEndElement()
        $w.WriteEndDocument()
        $w.Close()       

        #
        #$wcoRes.WriteXml()
        #foreach($wcc in $other.WCObjects.Values){
        #    $wcc.Compare($other.WCObjects[$wcc.Name])
        #}
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

#WindowsComponent class
Class WC{
    [string]$Name
    [Hashtable]$Members=@{} 
    WC([string]$name){$this.Name=$name}
}

#WindowsComponent object collection class
Class WCC:WC{
    WCC([string]$name):base($name){}
    [void]WriteXml([System.Xml.XmlTextWriter]$w){
        $w.WriteStartElement($this.Name)
        $w.WriteAttributeString("count", $this.Members.Count)
        foreach($wco in $this.Members.Values){ $wco.WriteXML($w) }
        $w.WriteEndElement()
    }
    static [WCC]ParseXml([System.Xml.XmlElement]$xml){
        $wc = [WCC]::new($xml.LocalName)
        foreach($cNode in $xml.ChildNodes){
            [System.Xml.XmlElement]$cXml = $cNode
            $cwo = [WCO]::ParseXml($cXml)
            $wc.Members.Add($cwo.Id,$cwo)
        }
        return $wc
    }
}

#WindowsComponent object class
Class WCO:WC{
    [string]$Id
    [WC]$SubProps = $null #coll of props
    [WCC]$SubObjects = $null #coll of wcobj
    WCO([string]$Type, [string]$Id):base($Type){$this.Id = $Id}
    [void]AddProp([string]$Name,[string]$Value){ $this.Members.Add($Name,$Value)}
    [bool]HasSubProps(){ return $this.SubProps -ne $null }
    [void]WriteXml([System.Xml.XmlTextWriter]$w){
        if($this.Members.Count -eq 0){ return }
        $w.WriteStartElement($this.Name)
        $w.WriteAttributeString("id",$this.Id)
        foreach($name in $this.Members.Keys){
            $w.WriteStartElement("prop")
            $w.WriteAttributeString("name", $name)
            $w.WriteString($this.Members[$name])
            $w.WriteEndElement()
        }
        if($this.SubProps -ne $null){ 
            $w.WriteStartElement($this.SubProps.Name)
            $w.WriteAttributeString("id",$this.SubProps.Id)
            foreach($name in $this.SubProps.Members.Keys){
                $w.WriteStartElement("prop")
                $w.WriteAttributeString("name", $name)
                $w.WriteString($this.SubProps.Members[$name])
                $w.WriteEndElement()
            }        
            $w.WriteEndElement()
        }
        if($this.SubObjects -ne $null){ $this.SubObjects.WriteXml($w)}
        $w.WriteEndElement()
    }
    static [WCO]ParseXml([System.Xml.XmlElement]$xml){
        $wc = [WCO]::new($xml.LocalName,$xml.GetAttribute("id"))
        foreach($cNode in $xml.ChildNodes){
            [System.Xml.XmlElement]$cXml = $cNode
            if($cXml.LocalName -eq "prop"){   $wc.AddProp($cXml.GetAttribute("name"),$cXml.InnerText)}
            elseif($cXml.HasAttribute("id")){ $wc.SubProps = [WCO]::ParseXml($cXml) }
            elseif($cXml.HasAttribute("count")){ $wc.SubObjects = [WCC]::ParseXml($cXml) }
        }
        return $wc
    }
}

#Changed Window Component object
Class CRDO{
    [string]$Name
    [WCO]$OldValue
    [WCO]$NewValue
    CRDO($name,$old,$new){
        $this.Name = $name
        $this.OldValue = $old
        $this.NewValue = $new
    }
    [void]WriteXml([System.Xml.XmlTextWriter]$w){
        $w.WriteStartElement($this.OldValue.Name)
        $w.WriteAttributeString("id", $this.OldValue.Id)
        $w.WriteStartElement("old")
        $w.WriteString($this.OldValue)
        $w.WriteEndElement()
        $w.WriteStartElement("new")
        $w.WriteString($this.NewValue)
        $w.WriteEndElement()
        $w.WriteEndElement()        
    }
}

#Changed Window Component prop
Class CRDP{
    [string]$Name
    [string]$OldValue
    [string]$NewValue
    CRDP($name,$old,$new){
        $this.Name = $name
        $this.OldValue = $old
        $this.NewValue = $new
    }
    [void]WriteXml([System.Xml.XmlTextWriter]$w){
        $w.WriteStartElement("p")
        $w.WriteAttributeString("name", $this.Name)
        $w.WriteStartElement("old")
        $w.WriteString($this.OldValue)
        $w.WriteEndElement()
        $w.WriteStartElement("new")
        $w.WriteString($this.NewValue)
        $w.WriteEndElement()
        $w.WriteEndElement()        
    }
}

#Compare Result base class
Class CR{
    [string]$Name  #id or type
    [Hashtable]$Added = @{}
    [Hashtable]$Changed = @{}
    [Hashtable]$Deleted = @{}
    CR([string]$name){$this.Name = $name }
    [bool]HasNewItem(){ return $this.Added.Count -gt 0}
    [bool]HasModItem(){ return $this.Changed.Count -gt 0}
    [bool]HasDelItem(){ return $this.Deleted.Count -gt 0}
    [bool]HasChanges(){ return $this.HasNewItem() -or $this.HasModItem() -or $this.HasDelItem()  }
}
Class CRP:CR{
    CRP([string]$name):base($name){}
    [void]AddModProp([string]$name,[string]$oldVal,[string]$newVal){$this.Changed.Add($name,[CRDP]::new($name,$oldVal,$newVal))}
    [void]AddDelProp([string]$name,[string]$refVal){$this.Deleted.Add($name,$refVal)}
    [CRDP]GetChanged([string]$name){return $this.Changed[$name] }
    [void]WriteXml([System.Xml.XmlTextWriter]$w){
        if($this.HasNewItem()){
            $w.WriteStartElement("addedProps")
            $w.WriteAttributeString("count", $this.Added.Count)
            foreach($k in $this.Added.Keys){
                $w.WriteStartElement("p")
                $w.WriteAttributeString("name", $k)
                $w.WriteString($this.Added[$k])
                $w.WriteEndElement()
            }
            $w.WriteEndElement()
        }
        if($this.HasDelItem()){
            $w.WriteStartElement("removedProps")
            $w.WriteAttributeString("count", $this.Deleted.Count)
            foreach($k in $this.Deleted.Keys){
                $w.WriteStartElement("p")
                $w.WriteAttributeString("name", $k)
                $w.WriteString($this.Deleted[$k])
                $w.WriteEndElement()
            }
            $w.WriteEndElement()
        }
        if($this.HasModItem()){
            $w.WriteStartElement("changedProps")
            $w.WriteAttributeString("count", $this.Changed.Count)
            foreach($o in $this.Changed.Values){  $o.WriteXml($w) }
            $w.WriteEndElement()
        }       
    }
    static [CRP]Compare([Hashtable]$refTab,[Hashtable]$cmpTab,[string]$name){
        $cmpRes = [CRP]::new($name)
        foreach($k in $refTab.Keys){
            $rVal = $refTab[$k]
            if($cmpTab.ContainsKey($k)){ $cVal = $cmpTab[$k]; if($rVal -ne $cVal){$cmpRes.AddModProp($k,$rVal,$cVal)} }
            else{ $cmpRes.AddDelProp($k,$rVal) }
            $cmpTab.Remove($k)
        }
        $cmpRes.Added = $cmpTab 
        return $cmpRes
    }
}

#Compare Result Object class
Class CRO:CR{
    [string]$Id
    [CRP]$Props=$null
    [CRP]$SubProps=$null
    [CRC]$SubObjects=$null
    CRO([string]$id,[string]$name):base($name){$this.Id=$id}
    [bool]HasChanges(){ return ($this.SysProps -ne $null -and $this.SysProps.HasChanges()) -or ($this.SubProps -ne $null -and $this.SubProps.HasChanges()) -or ($this.SubObjects -ne $null -and $this.SubObjects.HasChanges()) }
    [void]WriteXml([System.Xml.XmlTextWriter]$w){
        if($this.HasChanges()){
              $w.WriteStartElement($this.Name)
              $w.WriteAttributeString("id",$this.Id)
              if($this.Props -ne $null){
                if($this.Props.HasChanges()){
                    $this.Props.WriteXml($w)
                }
              }
              if($this.SubProps -ne $null){
                if($this.SubProps.HasChanges()){
                    $w.WriteStartElement($this.SubProps.Name)
                    $this.SubProps.WriteXml($w)
                    $w.WriteEndElement()
                }
              }
              if($this.SubObjects -ne $null){
                 if($this.SubObjects.HasChanges()){
                    $w.WriteStartElement($this.Id)
                    $this.SubObjects.WriteXml($w)
                    $w.WriteEndElement()
                }               
              }
              $w.WriteEndElement()
        }
    }

    static [CRO]Compare([WCO]$refWco,[WCO]$cmpWco){
        $ocr = [CRO]::new($refWco.Id,$refWco.Name)
        $ocr.Props=[CRP]::Compare($refWco.Members,$cmpWco.Members,$refWco.Name)
        if($refWco.SubProps -ne $null){
            $ocr.SubProps = [CRP]::Compare($refWco.SubProps.Members ,$cmpWco.SubProps.Members,$refWco.SubProps.Name)
        }
        if($refWco.SubObjects -ne $null){
            $ccr = [CRC]::new($refWco.SubObjects.Name)
            foreach($wco in $refWco.SubObjects.Members.Values){
                if($cmpWco.SubObjects.Members.ContainsKey($wco.Id)){
                    $rco = $cmpWco.SubObjects.Members[$wco.Id]
                    $ccro = [CRO]::Compare($wco,$rco)
                    if($ccro.HasChanges()){$ccr.Changed.Add($ccro.Id,[CRDO]::new($wco.Id,$wco,$rco))}                    
                }else{
                    $ccr.Deleted.Add($wco.Id,$wco)
                }
                $cmpWco.SubObjects.Members.Remove($wco.Id)
            }
            $ccr.Added = $cmpWco.SubObjects.Members
            $ocr.SubObjects = $ccr
        }
        return $ocr
    }
}

#Compare Result Collection class
Class CRC:CR{
    CRC([string]$name):base($name){}    
    [void]WriteXml([System.Xml.XmlTextWriter]$w){
        if($this.HasChanges()){
            $w.WriteStartElement($this.Name)
            if($this.HasNewItem()){
                $w.WriteStartElement("addedObjects")
                $w.WriteAttributeString("count", $this.Added.Count)
                foreach($wco in $this.Added.Values){ $wco.WriteXml($w) }
                $w.WriteEndElement()
            }
            if($this.HasDelItem()){
                $w.WriteStartElement("removedObjects")
                $w.WriteAttributeString("count", $this.Deleted.Count)
                foreach($wco in $this.Deleted.Values){ $wco.WriteXml($w) }
                $w.WriteEndElement()
            }
            if($this.HasModItem()){
                $w.WriteStartElement("changedObjects")
                $w.WriteAttributeString("count", $this.Changed.Count)
                foreach($o in $this.Changed.Values){  $o.WriteXml($w) }
                $w.WriteEndElement()
            }
            $w.WriteEndElement()
        }        
    }

    static [CRC]Compare([WCC]$refWcc,[WCC]$cmpWcc){
        $ccr = [CRC]::new($refWcc.Name)
        foreach($wco in $refWcc.Members.Values){
            if($cmpWcc.Members.ContainsKey($wco.Id)){
                $ocr=[CRO]::Compare($wco,$cmpWcc.Members[$wco.Id])
                if($ocr.HasChanges()){$ccr.Changed.Add($ocr.Id,$ocr)}   
            }else{
                $ccr.Deleted.Add($wco.Id,$wco)
            }
            $cmpWcc.Members.Remove($wco.Id)
        }
        $ccr.Added = $cmpWcc.Members
        return $ccr
    }
}

[Synfo]::CompareXML("$PSScriptRoot\sample1.xml","$PSScriptRoot\sample2.xml","$PSScriptRoot\testfile.xml")

#$syn = [Synfo]::new()
#$syn.DumpObjects()
#$syn.SaveToXML("$PSScriptRoot\testsave.xml")

#$syn.ReadXML("$PSScriptRoot\sample1.xml")

#$syn2 = [Synfo]::new()
#$syn2.ReadXML("$PSScriptRoot\sample2.xml")

#$syn.Compare($syn2)

#$syn.DumpObjects()
#$syn.SaveToXML("$PSScriptRoot\testsave.xml")
