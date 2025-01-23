<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/synfo">
<html>
<head>
<title>Synfo Compare Result</title>
<style>
A{ border: thin solid;	font-family: Arial, Tahoma, 'Trebuchet MS';	clear: none;	font: bold;
font-variant: small-caps;	color: #FF8C00;	border-top-width: 1px;	border-top: none; 
border-right: none;	border-left: none;	border-bottom: none;	text-decoration: none;	}
BODY{ PADDING-RIGHT: 0px; PADDING-LEFT: 10px; PADDING-BOTTOM: 0px; MARGIN: 0px;
COLOR: #F1F1F1; PADDING-TOP: 10px; BACKGROUND-COLOR: Black;  font-size: smaller;
	font-family: 'Arial Narrow', Tahoma;} 
TABLE{	border-left: 1px solid;	border-right: 1px solid;	border-bottom: 1px solid; 
  		border-top: 1px solid;	background-color: #111111;}
TH {	font: Tahoma, 'Trebuchet MS', Arial; font-size: small;	border: none; 
background: #3F3F3F;	border-left: 0px;	border-right: 0px;}
TD {	font: Tahoma, 'Trebuchet MS', Arial;	font-size: small;	border: none;	padding-left: 4px;	padding-right: 4px;	}
h4{	background-color: #393939;}
.collapse { position: absolute; visibility: hidden; }
.expand { position: relative; visibility: visible; }
</style>
<script>
function T(tableName) {
  var temp = document.getElementById(tableName);
	state = temp.style.visibility;
	if(state == 'visible' || state == 'show' ){
   temp.style.position = 'absolute';
   temp.style.visibility = 'hidden';
  }else{
   temp.style.position = 'relative';
   temp.style.visibility = 'visible';
  } 
 }
 function S(tableName) {
	T(tableName);
	var s = document.getElementById(tableName+"_Lnk").innerHTML;
	document.getElementById(tableName+"_Lnk").innerHTML= (s=="[+]") ? "[-]" : "[+]";
 }
</script>
</head>
<body>

<a id="fTable_Lnk" href="javascript:S('fTable')">+</a>
<table id="fTable" name="fTable">
<tr><td>ReferenceFile:</td><td><xsl:value-of select="refFile/@path"/></td></tr>
<tr><td>SubjectFile:</td><td><xsl:value-of select="cmpFile/@path"/></td></tr>
</table>


<xsl:if test="count(result/info) > 0">
<h4>Information</h4>
Changed <a id="tb_changedInfo_Lnk" href="javascript:S('tb_changedInfo')">[+]</a>
<table id="tb_changedInfo" name="tb_changedInfo" class="collapse">
  <tr>
    <th>HostName</th>
    <th>Property</th>
    <th>OldValue</th>
    <th>NewValue</th>
  </tr>
  <xsl:for-each select="result/info">
  	<xsl:variable name="pos" select="count(current()/changed/p) mod 2"/>
    <xsl:for-each select="current()/changed/p">
    <tr>
    <xsl:if test="position() mod 2 = 0">
       <xsl:attribute name="bgcolor">#222222</xsl:attribute>
    </xsl:if>   
      <td><xsl:value-of select="../../@id"/></td>      
      <td><xsl:value-of select="@name"/></td>
      <td><xsl:value-of select="current()/oldValue"/></td>
      <td><xsl:value-of select="current()/newValue"/></td>
    </tr>
    </xsl:for-each>
	<xsl:for-each select="current()/env.vars/changed/p">
	   <tr>
	    <xsl:if test="position() mod 2 = $pos">
	       <xsl:attribute name="bgcolor">#222222</xsl:attribute>
	    </xsl:if>   
	      <td><xsl:value-of select="../../../@id"/></td>      
	      <td><xsl:value-of select="@name"/></td>
	      <td><xsl:value-of select="current()/oldValue"/></td>
	      <td><xsl:value-of select="current()/newValue"/></td>
	    </tr>
	  </xsl:for-each>
  </xsl:for-each>
</table>
<br/>
</xsl:if>

<xsl:if test="count(result/services) > 0">
	<h4>Services</h4>
	<table>
	<xsl:if test="count(result/services/changed) > 0">
	<tr><td valign="top"><h5>Changed (<xsl:value-of select="result/services/changed/@count"/>)</h5>
		</td>
		<td valign="top">
		<table>
		  <xsl:for-each select="result/services/changed/svc">
		    <tr>
		    <xsl:if test="position() mod 2 = 0">
		       <xsl:attribute name="bgcolor">#222222</xsl:attribute>
		    </xsl:if>   
		    <td valign="top">
		      	<xsl:value-of select="@id"/>
		      	</td>	
		      <xsl:if test="count(current()/added) > 0">
			      <td valign="top">
		      		<a><xsl:attribute name="href">javascript:T('tb_addedProp_<xsl:value-of select="@id"/>')</xsl:attribute>
			      Added(<xsl:value-of select="count(current()/added/@count)"/>)
			      </a><br/>
		      		<table >
		      		<xsl:attribute name="id">tb_addedProp_<xsl:value-of select="@id"/></xsl:attribute>
		      		<xsl:attribute name="name">tb_addedProp_<xsl:value-of select="@id"/></xsl:attribute>
				       <tr><th>Property</th><th>Value</th></tr>
				       <xsl:for-each select="current()/added/p">
				       <tr>
					       <td><xsl:value-of select="@name"/></td>
					       <td><xsl:value-of select="."/></td>
					      </tr>
				       </xsl:for-each>
				       </table>
				   </td>
				   <br/>
		      </xsl:if>
		      <xsl:if test="count(current()/removed) > 0">
			      <td  valign="top">		      		
			      <a><xsl:attribute name="href">javascript:T('tb_removedProp_<xsl:value-of select="@id"/>')</xsl:attribute>
			      Removed(<xsl:value-of select="count(current()/removed/@count)"/>)
			      </a><br/>
		      		<table >
		      		<xsl:attribute name="id">tb_removedProp_<xsl:value-of select="@id"/></xsl:attribute>
		      		<xsl:attribute name="name">tb_removedProp_<xsl:value-of select="@id"/></xsl:attribute>
				       <tr><th>Property</th><th>Value</th></tr>
				       <xsl:for-each select="current()/removed/p">
				       <tr>
					       <td><xsl:value-of select="@name"/></td>
					       <td><xsl:value-of select="."/></td>
					      </tr>
				       </xsl:for-each>
				       </table>
				   </td><br/>
		      </xsl:if>	
		      <xsl:if test="count(current()/changed) > 0">
			      <td  valign="top">		      		
			      <a><xsl:attribute name="href">javascript:T('tb_changedProp_<xsl:value-of select="@id"/>')</xsl:attribute>
			      Changed(<xsl:value-of select="count(current()/changed/@count)"/>)
			      </a><br/>
		      		<table >
		      		<xsl:attribute name="id">tb_changedProp_<xsl:value-of select="@id"/></xsl:attribute>
		      		<xsl:attribute name="name">tb_changedProp_<xsl:value-of select="@id"/></xsl:attribute>
				       <tr><th>Property</th><th>OldValue</th><th>NewValue</th></tr>
				       <xsl:for-each select="current()/changed/p">
				       <tr>
					       <td><xsl:value-of select="@name"/></td>
					       <td><xsl:value-of select="current()/oldValue"/></td>
					       <td><xsl:value-of select="current()/newValue"/></td>
					      </tr>
				       </xsl:for-each>
				       </table>
				   </td><br/>
		      </xsl:if>			      	      
		    </tr>
		  </xsl:for-each>
		</table>
		</td>
	</tr>

	</xsl:if>
	
	<xsl:if test="count(result/services/added) > 0">
	<tr><td valign="top">
		<a href="javascript:T('tb_addedSvc')">Added (<xsl:value-of select="result/services/added/@count"/>)</a>
		</td><td valign="top">
		<table id="tb_addedSvc" name="tb_addedSvc" class="collapse">
		  <xsl:for-each select="result/services/added/svc">
		  		<tr>

		      	<td valign="top">
		      	<a><xsl:attribute name="href">javascript:T('tb_addedSvc_<xsl:value-of select="@id"/>')</xsl:attribute>
		      	<xsl:value-of select="@id"/>
		      	</a>
		      	</td>
		      	<td valign="top">
		      	<table class="collapse">
		      		<xsl:attribute name="id">tb_addedSvc_<xsl:value-of select="@id"/></xsl:attribute>
		      		<xsl:attribute name="name">tb_addedSvc_<xsl:value-of select="@id"/></xsl:attribute>
		      		<tr><th>Property</th><th>Value</th></tr>	
		      	<xsl:for-each select="current()/*">
					<tr>
						<xsl:if test="position() mod 2 = 0">
			       		<xsl:attribute name="bgcolor">#222222</xsl:attribute>
			    		</xsl:if>   
			      	<td><xsl:value-of select="local-name()"/></td>
			      	<td><xsl:value-of select="."/></td>
			      	</tr>
		      	</xsl:for-each>
		      	</table>
		      	</td>				
		   		</tr>
		  	</xsl:for-each>
		</table>
	</td>
	</tr>
	</xsl:if>

	<xsl:if test="count(result/services/removed) > 0">
	<tr><td valign="top">
		<a href="javascript:T('tb_removedSvc')">Removed (<xsl:value-of select="result/services/removed/@count"/>)</a>
		</td><td valign="top">
		<table id="tb_RemovedSvc" name="tb_RemovedSvc" class="collapse">
		  <xsl:for-each select="result/services/removed/svc">
		  		<tr>

		      	<td valign="top">
		      	<a><xsl:attribute name="href">javascript:T('tb_removedSvc_<xsl:value-of select="@id"/>')</xsl:attribute>
		      	<xsl:value-of select="@id"/>
		      	</a>
		      	</td>
		      	<td valign="top">
		      	<table class="collapse">
		      		<xsl:attribute name="id">tb_removedSvc_<xsl:value-of select="@id"/></xsl:attribute>
		      		<xsl:attribute name="name">tb_removedSvc_<xsl:value-of select="@id"/></xsl:attribute>
		      		<tr><th>Property</th><th>Value</th></tr>	
		      	<xsl:for-each select="current()/*">
					<tr>
						<xsl:if test="position() mod 2 = 0">
			       		<xsl:attribute name="bgcolor">#222222</xsl:attribute>
			    		</xsl:if>   
			      	<td><xsl:value-of select="local-name()"/></td>
			      	<td><xsl:value-of select="."/></td>
			      	</tr>
		      	</xsl:for-each>
		      	</table>
		      	</td>				
		   		</tr>
		  	</xsl:for-each>
		</table>
	</td>
	</tr>
	</xsl:if>	
 </table>
</xsl:if>

<xsl:if test="count(result/services) > 0">
<h4>Services</h4>
<a href="javascript:T('tb_changedSvc')">Changed (<xsl:value-of select="result/services/changed/@count"/>)</a>
<table id="tb_changedSvc" name="tb_changedSvc" class="collapse">
  <tr>
    <th>SvcName</th>
    <th>PropertyName</th>
    <th>OldValue</th>
    <th>NewValue</th>
  </tr>
  <xsl:for-each select="result/services/changed/svc/changedProperties/property">
    <tr>
    <xsl:if test="position() mod 2 = 0">
       <xsl:attribute name="bgcolor">#222222</xsl:attribute>
    </xsl:if>   
      <td><xsl:value-of select="../../@id"/></td>      
      <td><xsl:value-of select="@name"/></td>
      <td><xsl:value-of select="current()/oldValue"/></td>
      <td><xsl:value-of select="current()/newValue"/></td>
    </tr>
  </xsl:for-each>
</table>
<br/>
</xsl:if>



<xsl:if test="count(result/products) > 0">
<h4>Products</h4>
<a href="javascript:T('tb_changedProd')">Changed (<xsl:value-of select="result/products/changed/@count"/>)</a>
<table id="tb_changedProd" name="tb_changedProd" class="collapse">
  <tr>
    <th>ProductId</th>
    <th>Property</th>
    <th>OldValue</th>
    <th>NewValue</th>
  </tr>
  <xsl:for-each select="result/products/changed/app/changedProperties/property">
    <tr>
    <xsl:if test="position() mod 2 = 0">
       <xsl:attribute name="bgcolor">#222222</xsl:attribute>
    </xsl:if>   
      <td><xsl:value-of select="../../@id"/></td>      
      <td><xsl:value-of select="@name"/></td>
      <td><xsl:value-of select="current()/oldValue"/></td>
      <td><xsl:value-of select="current()/newValue"/></td>
    </tr>
  </xsl:for-each>
</table>
<br/>
</xsl:if>


<h4>Analysis</h4>
<a href="javascript:T('tb_svcStateModified')">Services::StateModified (<xsl:value-of select="count(result/services/changed/svc/changedProperties/property[@name='State'])"/>)</a>
<table id="tb_svcStateModified" name="tb_svcStateModified" class="collapse">
  <tr>
    <th>SvcName</th>
    <th>OldState</th>
    <th>NewState</th>
  </tr>
  <xsl:for-each select="result/services/changed/svc/changedProperties/property[@name='State']">
    <tr>
    <xsl:if test="position() mod 2 = 0">
       <xsl:attribute name="bgcolor">#222222</xsl:attribute>
    </xsl:if>   
      <td><xsl:value-of select="../../@id"/></td>      
      <td><xsl:value-of select="current()/oldValue"/></td>
      <td><xsl:value-of select="current()/newValue"/></td>
    </tr>
  </xsl:for-each>
</table>
<br/>

<a href="javascript:T('tb_svcAddedPatches')">Products::AddedPatches (<xsl:value-of select="count(result/products/changed/app/added/patch)"/>)</a>
<table id="tb_svcAddedPatches" name="tb_svcAddedPatches" class="collapse">
  <tr>
    <th>ProductId</th>
    <th>PatchId</th>
    <th>PatchName</th>
    <th>InstallDate</th>
    <th>State</th>
  </tr>
  <xsl:for-each select="result/products/changed/app/added/patch">
    <tr>
    <xsl:if test="position() mod 2 = 0">
       <xsl:attribute name="bgcolor">#222222</xsl:attribute>
    </xsl:if>   
      <td><xsl:value-of select="../../@id"/></td>      
      <td><xsl:value-of select="@id"/></td>      
      <td><xsl:value-of select="current()/DisplayName"/></td>
      <td><xsl:value-of select="current()/InstallDate"/></td>
      <td><xsl:value-of select="current()/State"/></td>
    </tr>
  </xsl:for-each>
</table>
<br/>
</body></html>
</xsl:template>

</xsl:stylesheet>
