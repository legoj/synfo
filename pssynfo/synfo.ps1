
Class Synfo{
    hidden static [string]$_DEFCFG="PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiID8+CjxzeW5mbz4KCTxkdW1wPgoJCTxpbmZvIHR5cD0ibmZvIiBvYmo9Im5mbyI+CgkJCTxmbGQ+VmVyc2lvbixDYXB0aW9uLEluc3RhbGxEYXRlLExvY2FsZSxPU0FyY2hpdGVjdHVyZSxPU0xhbmd1YWdlLFN5c3RlbURpcmVjdG9yeSxTeXN0ZW1Ecml2ZSxUb3RhbFZpc2libGVNZW1vcnlTaXplPC9mbGQ+CgkJPC9pbmZvPgoJCTxzZXJ2aWNlcyB0eXA9IndtaSIgb2JqPSJzdmMiPgoJCQk8Y2xzPldpbjMyX1NlcnZpY2U8L2Nscz4KCQkJPGZsZD5BY2NlcHRTdG9wLENhcHRpb24sQ2hlY2tQb2ludCxDcmVhdGlvbkNsYXNzTmFtZSxEZXNjcmlwdGlvbixEZXNrdG9wSW50ZXJhY3QsRGlzcGxheU5hbWUsRXJyb3JDb250cm9sLEV4aXRDb2RlLEluc3RhbGxEYXRlLE5hbWUsUGF0aE5hbWUsUHJvY2Vzc0lkLFNlcnZpY2VTcGVjaWZpY0V4aXRDb2RlLFNlcnZpY2VUeXBlLFN0YXJ0ZWQsU3RhcnRNb2RlLFN0YXJ0TmFtZSxTdGF0ZSxTdGF0dXMsU3lzdGVtQ3JlYXRpb25DbGFzc05hbWUsU3lzdGVtTmFtZSxUYWdJZCxXYWl0SGludDwvZmxkPgoJCQk8a2V5Pk5hbWU8L2tleT4KCQkJPGV4dCBmbGQ9IlZlcnNpb24iPlBhdGhOYW1lPC9leHQ+CgkJPC9zZXJ2aWNlcz4KCQk8aG90Zml4ZXMgdHlwPSJ3bWkiIG9iaj0icWZlIj4KCQkJPGNscz5XaW4zMl9RdWlja0ZpeEVuZ2luZWVyaW5nPC9jbHM+CgkJCTxmbGQ+Q2FwdGlvbixEZXNjcmlwdGlvbixIb3RGaXhJRCxJbnN0YWxsZWRCeSxJbnN0YWxsZWRPbjwvZmxkPgoJCQk8a2V5PkhvdEZpeElEPC9rZXk+CgkJPC9ob3RmaXhlcz4KCQk8ZHJpdmVycyB0eXA9IndtaSIgb2JqPSJkcnYiPgoJCQk8Y2xzPldpbjMyX1N5c3RlbURyaXZlcjwvY2xzPgoJCQk8ZmxkPkFjY2VwdFBhdXNlLEFjY2VwdFN0b3AsQ2FwdGlvbixEZXNjcmlwdGlvbixEZXNrdG9wSW50ZXJhY3QsRGlzcGxheU5hbWUsRXJyb3JDb250cm9sLEV4aXRDb2RlLE5hbWUsUGF0aE5hbWUsU2VydmljZVNwZWNpZmljRXhpdENvZGUsU2VydmljZVR5cGUsU3RhcnRlZCxTdGFydE1vZGUsU3RhcnROYW1lLFN0YXRlLFN0YXR1cyxUYWdJZDwvZmxkPgoJCQk8a2V5Pk5hbWU8L2tleT4KCQkJPGV4dCBmbGQ9IlZlcnNpb24iPlBhdGhOYW1lPC9leHQ+CgkJPC9kcml2ZXJzPgoJCTxhcnByZWdzIHR5cD0icmVnIiBvYmo9ImFycCI+CgkJCTx4NjQ+U09GVFdBUkVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cVW5pbnN0YWxsXDwveDY0PgoJCQk8eDg2PlNPRlRXQVJFXFdPVzY0MzJOb2RlXE1pY3Jvc29mdFxXaW5kb3dzXEN1cnJlbnRWZXJzaW9uXFVuaW5zdGFsbFw8L3g4Nj4KCQk8L2FycHJlZ3M+CgkJPHByb2R1Y3RzIHR5cD0id2l4IiBvYmo9ImFwcCI+CgkJCTxwcmQ+UHJvZHVjdE5hbWUsVmVyc2lvblN0cmluZyxJbnN0YWxsRGF0ZSxQdWJsaXNoZXIsVVJMSW5mb0Fib3V0LEluc3RhbGxMb2NhdGlvbixJbnN0YWxsU291cmNlLFBhY2thZ2VOYW1lPC9wcmQ+CgkJCTxwY2g+RGlzcGxheU5hbWUsSW5zdGFsbERhdGUsTW9yZUluZm9VUkwsU3RhdGUsTG9jYWxQYWNrYWdlLFRyYW5zZm9ybXMsVW5pbnN0YWxsYWJsZTwvcGNoPgoJCTwvcHJvZHVjdHM+Cgk8L2R1bXA+Cjwvc3luZm8+"
    hidden static [string]$ConfigXml = "$global:PSScriptRoot\synfo.xml"
    [WCO]$SysProps = $null  #WCO info
    $WCObjects = @{}   #WCC coll
    [string]$xmlPath = "$PSScriptRoot\synfo_$($env:COMPUTERNAME)_$((Get-Date).ToString("yyyymmddHHMMss")).xml"
    Synfo(){
        if(!(Test-Path $([Synfo]::ConfigXml))){   [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String([Synfo]::_DEFCFG)) | Out-File $([Synfo]::ConfigXml) -Encoding utf8  }
        [xml]$xml = gc $([Synfo]::ConfigXml)
        foreach($child in $xml.DocumentElement.dump.ChildNodes){
            [System.Xml.XmlElement]$ch = $child
            $typ = $ch.GetAttribute("typ")
            switch($typ){
                'wmi'{ $wcc = [Synfo]::ReadWMIObjects($ch); $this.WCObjects.Add($wcc.Name,$wcc)  }
                'reg'{ $wcc = [Synfo]::ReadRegObjects($ch); $this.WCObjects.Add($wcc.Name,$wcc)  }
                'wix'{ $wcc = [Synfo]::ReadWIXObjects($ch); $this.WCObjects.Add($wcc.Name,$wcc)  }
                'nfo'{ $this.SysProps = [Synfo]::ReadComputerInfo($ch)}
                default{}
            }
        }
    }
    Synfo([string]$synfoXml){
        [xml]$xml = gc $synfoXml
        foreach($child in $xml.DocumentElement.ChildNodes){
            [System.Xml.XmlElement]$ch = $child
            if($ch.HasAttribute("count")){    $wc = [WCC]::ParseXml($ch); $this.WCObjects.Add($wc.Name,$wc) }
            elseif($ch.LocalName -eq "info"){ $this.SysProps = [WCO]::ParseXml($ch) }
        }
        $this.xmlPath = $synfoXml    
    }
    [string]Save(){
        $w = [System.Xml.XmlTextWriter]::new($this.xmlPath, [Text.Encoding]::UTF8)
        $w.Formatting = [System.Xml.Formatting]::Indented
        $w.WriteStartDocument()
        $w.WriteStartElement("synfo")
        $this.SysProps.WriteXml($w)
        foreach($wco in $this.WCObjects.Values){ $wco.WriteXml($w) }
        $w.WriteEndElement()
        $w.WriteEndDocument()
        $w.Close()
        return $this.xmlPath
    }
    [string]Compare([string]$refXml){ return [Synfo]::Compare([Synfo]::new($refXml),$this)  }

    hidden static [WCO]ReadComputerInfo([System.Xml.XmlElement]$xml){
        Write-Host "Dumping System Info"
        $wcoSys = [WCO]::new($xml.LocalName,$env:COMPUTERNAME)

        $fld = $xml.SelectSingleNode("fld").InnerText.Split(",")
        Write-Host "AddProps from WMI.OS"
        $nfo = gwmi -ClassName Win32_OperatingSystem -Property $fld 
        foreach($p in $nfo.Properties){ $wcoSys.AddProp($p.Name,$p.Value)  }

        $wen = [WCO]::new("envvars","SYSTEM")
        $wcoSys.SubProps = $wen
        $sev = [Environment]::GetEnvironmentVariables(2)
        Write-Host "AddProps from ENV.Vars - SYSTEM"
        foreach($p in $sev.Keys){ $wen.AddProp($p,$sev[$p])    }        
        return $wcoSys
    }
    hidden static [WCC]ReadWIXObjects([System.Xml.XmlElement]$xml){
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
        return $wcc
    }
    hidden static [WCC]ReadRegObjects([System.Xml.XmlElement]$xml){
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
        return $wcc
    }
    hidden static [WCC]ReadWMIObjects([System.Xml.XmlElement]$xml){
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
        return $wcc
    }
    hidden static [string]ToStringValue($pVal){
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

    static [string]Dump(){ return ([Synfo]::new()).Save() }
    static [string]Compare([string]$refXml,[string]$cmpXml){ return [Synfo]::Compare([Synfo]::new($refXml),[Synfo]::new($cmpXml)) }
    static [string]Compare([Synfo]$refSynfo,[Synfo]$cmpSynfo){
        $cMode = "xcmp"
        if($refSynfo.SysProps.Id -eq $cmpSynfo.SysProps.Id){ $cMode = "diff_$($refSynfo.SysProps.Id)-$($cmpSynfo.SysProps.Id)" }
        else{ $cMode = "xcmp_$($refSynfo.SysProps.Id)-$($cmpSynfo.SysProps.Id)" }

        $resXml = "$PSScriptRoot\synfo_$($cMode)_$((Get-Date).ToString("yyyymmddHHMMss")).xml"
        $w = [System.Xml.XmlTextWriter]::new($resXml, [Text.Encoding]::UTF8)
        $w.Formatting = [System.Xml.Formatting]::Indented
        $w.WriteStartDocument()
        $w.WriteStartElement("synfo")
        $w.WriteStartElement("ref")
        $w.WriteAttributeString("path",$refSynfo.xmlPath)
        $w.WriteEndElement()
        $w.WriteStartElement("cmp")
        $w.WriteAttributeString("path",$cmpSynfo.xmlPath)
        $w.WriteEndElement()
        $w.WriteStartElement("result")
        $wcoRes = [CRO]::Compare($refSynfo.SysProps,$cmpSynfo.SysProps)        
        $w.WriteAttributeString("hasChanges",$wcoRes.HasChanges())
        $wcoRes.WriteXml($w)
        foreach($wcc in $refSynfo.WCObjects.Values){            
            $wccRes = [CRC]::Compare($wcc,$cmpSynfo.WCObjects[$wcc.Name])
            $wccRes.WriteXml($w)
        }
        $w.WriteEndElement() #result
        $w.WriteEndElement()
        $w.WriteEndDocument()
        $w.Close()       
        return $resXml
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
    [bool]HasChanges(){ return ($this.Props -ne $null -and $this.Props.HasChanges()) -or ($this.SubProps -ne $null -and $this.SubProps.HasChanges()) -or ($this.SubObjects -ne $null -and $this.SubObjects.HasChanges()) }
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


#sample usage
#[Synfo]::Dump()

[Synfo]::Compare("$PSScriptRoot\sample1.xml","$PSScriptRoot\sample2.xml")


