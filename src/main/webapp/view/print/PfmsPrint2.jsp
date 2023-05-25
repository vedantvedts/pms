
	<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<%

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf2=new SimpleDateFormat("MMMM yyyy");
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> costbreak = (List<Object[]>)request.getAttribute("costbreak");
Object[] PfmsInitiationList=(Object[])request.getAttribute("PfmsInitiationList");
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
List<Object[]> CostDetailsList=(List<Object[]>)request.getAttribute("CostDetailsList");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
Object[] LabList=(Object[])request.getAttribute("LabList");
String lablogo=(String)request.getAttribute("lablogo");
List<Object[]> RequirementList=(List<Object[]>)request.getAttribute("RequirementList");



%>





<meta charset="ISO-8859-1">
<title> Project Proposal </title>
<style type="text/css">
 

  .break {
    page-break-before: always;
      }
     

	     
     @page {
      size: : 790px 1120px; 
       margin-top: 49px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px;
       border: 1px solid black; 
       counter-increment:page;
       
       @bottom-left {          		
             content: "<%=LabList[1]%>";
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
        }
        
        @bottom-right {
	            content: "Page " counter(page) " of " counter(pages);
	            margin-bottom: 30px;
		}
		
		@top-right {
             content: "Proposed Project: <%=PfmsInitiationList[4]%>";
             margin-top: 30px;
             font-size: 13px;
         }
         
        @top-left {
             content: "<%=PfmsInitiationList[3]%>";
             margin-top: 30px;
             font-size: 13px;
        }
       
       
       
       
       
    }
    
    .article td{
    	padding:9px 5px 9px !important; 
    }
 
 	.article{
 		font-family:Gadugi
 	}
 	                                                       
 	.lineheight td{
 		line-height: 40px;
 	}
 	
 	.Page6 td{
 		padding:9px 45px  !important;
 		font-family:Gadugi
 	}
 	
 	.articledesc{
 		line-height: 30px;
 		margin-top:00px;
 		margin-bottom: 30px;
 		margin-left: 80px;
 		margin-right:50px !important;
 	}
 	
 	.break{
  page-break-before:always;
  }

    table tbody b{
	background-color: #ADFF2F;
}

#container-fluid{
	background-color: white !important;
	margin-top: -14px;
}
    
.left{
	text-align: left
}

.right{
	text-align: right
}

.center{
	text-align: center
}

.weight_700{
	font-weight: 700;
}

.normal{
	font-weight: normal;
}

.border_black{
	border:1px solid black;
}
 	
.executive th{
	padding:10px 5px;
}



.heading{
	font-size: 26px;
}

.heading-color{
	color: #145374;
}

.breiftable {
	border:1px solid black;
	border-collapse : collapse;
}

.breiftable td{
	border:1px solid black;
	border-collapse : collapse;
}

.breiftable-th{
	font-weight: 800;
}

.editor-text span,p,h1,h2,h3,h4,h5,h6{
	font-size: 18px !important;
	font-family: 'Times New Roman', Times, serif !important;
}

.editor-text {
	font-size: 18px !important;
	font-family: 'Times New Roman', Times, serif !important;
}

.editor-text-font{
	font-size : 18px !important;
}

.editor-text span,p{
	font-weight: 500 !important;
}

.executive, .executive th, .executive td {
  border: 1px solid black;
  border-collapse: collapse;
}

.brieftable td,.brieftable th{
	padding: 15px; 
}

.editor-text table{
	width: 650px !important;
	maargin-left:20px !important;
}
/*  table>tbody>tr>td>table{
 width:450px !important;
 }
   */
 .border-black{
 border:1px solid black !important;
 border-collapse: collapse !important;
 }
 .border-black td th{
 padding:px !important;
 margin: 0px !important;
 }
</style>
</head>
<body >


<%-- <div  align="center">
	<form action="ProjectProposalDownload.htm" method="post" target="_blank"  >
		<input type="hidden" name="htmlstring" value="" id="htmlstring"  >
		<br>
		<button type="submit" class="btn btn-sm prints" id="pdfdown" ><i class="fa fa-file-text-o" aria-hidden="true" style="color: white" ></i> &nbsp; Generate PDF</button>
		<button type="button" class="btn btn-sm prints" id="print"  >Print</button>
		
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form> 
</div> --%>

 





<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 0px;width:717px; font-size: 15px;border-collapse: collapse;font-family:Gadugi ;" >

	<tbody >
		<tr>
				<th colspan="4" style="  text-align: center; padding: 0 5px 5px;font-size:30px" class=" heading-color"><br>Project Proposal</th>
		</tr>
		<tr>
			<th colspan="4"  style="text-align:center; width:100%;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
		
	
		<tr>
				<th colspan="8" style="  text-align: center; padding: 0 5px 5px;font-size:28px"><%if(PfmsInitiationList[5]!=null){ %><br><%=PfmsInitiationList[5] %><%}else{ %><i>Project Title</i><%} %>
			</th>
		</tr>
	
		<tr>
			<th colspan="8" style="  text-align: center; padding: 0 5px 5px;font-size:24px"><%if(PfmsInitiationList[4]!=null){ %>(<%=PfmsInitiationList[4] %>)<%}else{ %><i> - </i><%} %>
			</th>
		</tr>
		
			<tr>
			<th colspan="8" style="  text-align: center; padding: 0 5px 5px;font-size:24px">
			</th>
		</tr>
			
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size: 24px">
				<%if(PfmsInitiationList[10]!=null){%> <%=sdf2.format(PfmsInitiationList[10])%><%}else{ %>-<%} %>
			</th>
		</tr>
		
		<tr>
			<th style="height:20px"></th>
			</tr>
			<tr>
		<th style="height:20px"></th>
			</tr>
			<tr>
				<th style="height:50px"></th>
			</tr>
		<tr>			
			<th colspan="8" style="text-align: center; font-weight: 700;">
				<br><br>
				<img class="logo" style="width:120px;height: 120px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
		<tr>
			<th colspan="8" style="text-align: center; height:80px; font-weight: 700;font-size:22px;padding-top: 50px;"></th>
		</tr>
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><br><%if(LabList[1]!=null){ %><%=LabList[1] %><%}else{ %>-<%} %></th>
		</tr>
		
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Government of India, Ministry of Defence</th>
		</tr>
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
		</tr>
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(LabList[2]!=null){ %><%=LabList[2] %><%}else{ %> - <%} %></th>			
		</tr>

	</tbody>


</table>

 <h1 class="break"></h1>
 

<!-- 2nd page -->


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:650px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Brief of Proposed Project</th>
		</tr>
		<tr>
		<th colspan="4"  style="text-align:center; width:70%;font-size:30px;border-bottom: 3px solid grey;"></th>
		</tr>
	</tbody>
</table>
<br>
<table  class="brieftable executive" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:650px; font-size: 20px;border-collapse: collapse; ">
	<tbody>
		<tr>
			<th  class="border_black weight_700 left" ><span >Title of the Project</span></th>
			<td  class="border_black weight_700 left" ><span ><%if(PfmsInitiationList[5]!=null){ %><%=PfmsInitiationList[5] %><%}else{ %><i></i><%} %></span></td>
		</tr>
		<tr>
			<th  class="border_black weight_700 left" ><span >Cost</span></th>
			<td  class="border_black weight_700 left" ><span ><%if(PfmsInitiationList[6]!=null){ %><i>&#8377;</i> <%=nfc.convert(Double.parseDouble(PfmsInitiationList[6].toString())/100000)%> Lakhs<%}else{ %><i></i><%} %></span></td>
		</tr>
		<tr>
			<th	 class="border_black weight_700 left" ><span >PDC</span></th>
			<td  class="border_black weight_700 left" ><span ><%if(PfmsInitiationList[7]!=null){ %><%=PfmsInitiationList[7] %> Months <%}else{ %><i></i><%} %></span></td>
		</tr>
		<tr>
			<th  class="border_black weight_700 left"> <span >Security Classification</span></th>
			<td  class="border_black weight_700 left" ><span ><%if(PfmsInitiationList[3]!=null){ %><%=PfmsInitiationList[3] %><%}else{ %><i></i><%} %></span></td>
		</tr>
		<tr>
			<th  class="border_black weight_700 left"> <span >Whether Plan/Non-Plan</span></th>
			<td class="border_black weight_700 left" ><span ><%if(PfmsInitiationList[8]!=null){ if(PfmsInitiationList[8].toString().equalsIgnoreCase("P")){%> Plan <%}if(PfmsInitiationList[8].toString().equalsIgnoreCase("N")){ %>Non-Plan - <%if(PfmsInitiationList[14]!=null){ %> (Remarks : <%=PfmsInitiationList[14]%> ) <%}else{ %> No  Remarks <%} %> <%}}else{ %><%} %></span></td>
		</tr> 
		
	</tbody>
</table>
		
<h1 class="break"></h1>

<!-- Need For Project -->

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Need of the Project</th>
		</tr>
		<tr>
			<th colspan="4"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:5px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
	<tbody>
<%if(!DetailsList.isEmpty()){
	
	for(Object[] obj: DetailsList){
	%>
	
		<tr>
		<%if(obj[6]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[6] %></td>
		<%}else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" ><i class="normal">To be filled</i></td>
		<%} %>
		</tr>

	<%}}else{ %>

<tr>
	<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>

<%} %>

	</tbody>
</table>

<h1 class="break"></h1>


<!-- Requirements -->

<!-- <table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" > -->
<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:600px; font-size: 18px;border:;font-family:Gadugi ;" >
		<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Requirements</th></tr>
			<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
		</table>
		
		<% if(!RequirementList.isEmpty()){ %>
		<table style="width:100%;margin-left:17px; margin-top:25px; padding:10px; border-collapse:collapse; border:1px solid black;">

				<thead  style="margin-top:10px; borde:1px solid black">
	 			 <tr style="margin-top:40px; padding:20px!important">
<!-- 	 	     <th style="width: 5%;">Select</th> -->
			    <th style="width: 3%; padding:8px;font-size: 22px;  border-collapse:collapse; border:1px solid black;">SN</th>
				<th style="width:8% ; font-size:22px; border-collapse:collapse; border:1px solid black;">ID</th>
				<!-- <th style="width:8%" class="text-nowrap">Requirement Type</th> -->
				<th style="width:70% ;font-size: 22px; border-collapse:collapse; border:1px solid black;" >Brief</th>
				</tr>
				</thead>
<tbody>
  <%int i=1;
  if(!RequirementList.isEmpty()){
  for(Object obj[]:RequirementList){ %>
  <tr>
		<td style="font-size: 17px;  padding:10px; border-collapse:collapse; border:1px solid black;"><%=i+"." %></td>
 			 	<td style="font-size: 17px; padding:7px; border-collapse:collapse; border:1px solid black;"><%=obj[1] %></td>
	 			   	<td style="text-align:justify; font-size: 17px; padding-top:7px;  border-collapse:collapse; border:1px solid black;"><%=obj[3] %></td>
	 			   	 </tr>
	 		
 <%
 i++;
 } %>
 <%}else{ %>
 		
 <tr>
  <td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
 </tr>
 <%} %>

 </tbody>
</table>
<hr style="width:90%">

<%}else{%>
<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:920px; font-size: 22px; ">
	<tbody>
	<tr>
	<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>
	</tbody>
	</table>


<%} %>
<h1 class="break"></h1>


<!-- World Scenario -->

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">World Scenario</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:5px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
	<tbody>
<%if(!DetailsList.isEmpty()){
	
	for(Object[] obj: DetailsList){
	%>
	
		<tr>
		<%if(obj[12]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[12] %></td>
		<%}else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" ><i class="normal">To be filled</i></td>
		<%} %>
		</tr>

	<%}}else{ %>

<tr>
	<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>

<%} %>

	</tbody>
</table>

<h1 class="break"></h1>


<!-- Objective -->
 <table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Objective</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
	<tbody>
<%if(!DetailsList.isEmpty()){
	
	for(Object[] obj: DetailsList){
	%>
	
		<tr>
		<%if(obj[1]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[1] %></td>
		<%}else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" ><i class="normal">To be filled</i></td>
		<%} %>
		</tr>

	<%}}else{ %>

<tr>
	<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>

<%} %>

	</tbody>
</table>
  
  
   <h1 class="break"></h1>
  
  <!-- Scope -->
    <table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Scope</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
	<tbody>
<%if(!DetailsList.isEmpty()){
	
	for(Object[] obj: DetailsList){
	%>
	
		<tr>
		<%if(obj[2]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[2] %></td>
		<%}else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" ><i class="normal">To be filled</i></td>
		<%} %>
		</tr>

	<%}}else{ %>

<tr>
	<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>

<%} %>

	</tbody>
</table>
  
  
   <h1 class="break"></h1>
  
<!-- Deliverables-->

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Deliverables</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>
 <%if(PfmsInitiationList!=null){%>
<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 0px;width:715px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
			
		<tr>
		<%if(PfmsInitiationList[11]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><br>
		
		
		<%=PfmsInitiationList[11] %></td>
		<%}
		else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
		<%}%>
		</tr>
			</tbody>
</table>
	<%} else{%>
	   <table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:600px; font-size: 22px; ">
		 <tbody>
		<tr>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
	</tr>
		</tbody>
		</table>


	<%} %>
	
	


 
<h1 class="break"></h1> 
 

<!-- Participating Labs with Work Share -->


<%

	if(PfmsInitiationList[9]!=null){ if(PfmsInitiationList[9].toString().equalsIgnoreCase("Y")){
	
	%>


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Participating Labs with Work Share </th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<%for(Object[] obj1 : DetailsList){ %>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
	<tbody>
		<tr>
			<td colspan="8" style="  text-align: left; padding: 0 5px 5px;font-size:20px" class="editor-text"><%if(obj1[3]!=null){%><%=obj1[3]%><%}else{%>To be filled<%} %>
			</td>
		</tr>
	</tbody>
</table>

<%} %>

 <h1 class="break"></h1>

 <%}}%>
 
 
<!-- Brief of Earlier Work Done -->

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Brief of Earlier Work Done </th>
		</tr>
		<tr>
		<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
<%
if(!DetailsList.isEmpty()){
for(Object[] obj : DetailsList){   %>
	
		<tbody>
			<tr>
			<%if(obj[4]!=null){  %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[4] %></td>
			<%}else{ %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
			<%} %>
			</tr>
			
			<%}}else {%>
			<tr>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
			</tr>
			<%} %>
	</tbody>
</table>

<h1 class="break"></h1>


<!-- Competency Established -->

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Competency Established </th>
		</tr>
		<tr>
		<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
<%
if(!DetailsList.isEmpty()){
for(Object[] obj : DetailsList){   %>
	
		<tbody>
			<tr>
			<%if(obj[5]!=null){  %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[5] %></td>
			<%}else{ %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
			<%} %>
			</tr>
			
			<%}}else {%>
			<tr>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
			</tr>
			<%} %>
	</tbody>
</table>


 <h1 class="break"></h1>

 

<!-- Technology Challenges -->
  <table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Technology Challenges</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
	<tbody>
<%if(!DetailsList.isEmpty()){
	
	for(Object[] obj: DetailsList){
	%>
	
		<tr>
		<%if(obj[7]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[7] %></td>
		<%}else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" ><i class="normal">To be filled</i></td>
		<%} %>
		</tr>

	<%}}else{ %>

<tr>
	<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>

<%} %>

	</tbody>
</table>
  
  
   <h1 class="break"></h1> 
   
   <!--Risk Mitigation  -->
    <table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Risk Mitigation</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
	<tbody>
<%if(!DetailsList.isEmpty()){
	
	for(Object[] obj: DetailsList){
	%>
	
		<tr>
		<%if(obj[8]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[8] %></td>
		<%}else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" ><i class="normal">To be filled</i></td>
		<%} %>
		</tr>

	<%}}else{ %>

<tr>
	<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>

<%} %>

	</tbody>
</table>
  
  
   <h1 class="break"></h1> 
   


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Proposal </th>
		</tr>
		<tr>
		<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
<%
if(!DetailsList.isEmpty()){
for(Object[] obj : DetailsList){   %>
	
		<tbody>
			<tr>
			<%if(obj[9]!=null){  %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[9] %></td>
			<%}else{ %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
			<%} %>
			</tr>
			
			<%}}else {%>
			<tr>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
			</tr>
			<%} %>
	</tbody>
</table>


 <h1 class="break"></h1>
 

 
 <!-- Cost Breakup -->
  <div align="center" style="font-size: 25px"><b>Annexure - A </b></div>
<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
	   <tr>
		   <th colspan="8"  style="text-align:center;" class="heading heading-color">Cost Breakup as per proposal</th>
	   </tr>
	   <tr>
		   <th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
	   </tr>
	</tbody>
</table>

<%if(!CostDetailsList.isEmpty()){ %>

<table  class="executive editor-text-font" style="margin-right:2px;margin-top:5px; margin-bottom: 10px;margin-left: 2px;width:708px;;border-collapse: collapse; ">
	<tbody>
	<tr>
		<th colspan="1" class="" style=";width:4%"><span >SN</span></th>
		<th colspan="4" class="" style=";width:30%"><span >Budget Item</span></th>
		<th colspan="2" class="" style=";width:40%"><span >Item</span></th>
		<th colspan="2" class=""style=";width:20%"> <span >Cost (Lakhs)</span></th>
	</tr>
		<%int count=1;
		for(Object[] obj : CostDetailsList){ %> 
	<tr>
		<td colspan="1" class="border_black weight_700 center" style="width:7%;"><span ><%=count %>.</span></td>
		<td colspan="4" class=" left" style="padding-left:5px"   ><span ><%=obj[0]+"("+obj[5]+")"%><br><%="("+obj[1]+")" %></span></td>
		<td colspan="2" class=" left" style="padding-left:5px" ><span ><%=obj[2] %></span></td>
		<td colspan="2" class="border_black weight_700 right" style="padding-right:5px" ><span >&#8377; <span><%=nfc.convert(Double.parseDouble(obj[3].toString())/100000)%></span></span></td>
	</tr> 
	</tbody>
	<%
	count++;
	} %>
			
			<%if(PfmsInitiationList!= null) { Object[] obj = PfmsInitiationList; %>
			
			<tr>
				<td colspan="12" class="border_black weight_700 right"  ><span ><%if(obj[6]!=null && Double.parseDouble(obj[6].toString()) >0 ){ %>Total Cost : &#8377; <span><%=nfc.convert(Double.parseDouble(obj[6].toString())/100000)%></span> <%}else{ %>  <%} %> Lakhs</span></td>
			</tr>
			<%} %>
</table>

<%}else{ %>
<table  class="executive editor-text-font" style="margin-top:5px; margin-bottom: 10px;margin-left: 2px; margin-right: 2px;width:708px;  ">

<tr>
	<th colspan="1" class="border_black weight_700 left" style=";width:9%"><span >SN</span></th>
	<th colspan="3" class="border_black weight_700 center" style=";width:15%"><span >Head Code</span></th>
	<th colspan="2" class="border_black weight_700 center" style=";width:60%"><span >Item</span></th>
	<th colspan="2" class="border_black weight_700 center" ><span >Cost (Lakhs)</span></th>
</tr> 
<tr>
	<th colspan="8" class="border_black weight_700 center" ><span >No Data Available</span></th>
</tr> 



</table>

<%}%>

 <h1 class="break"></h1>
<%
  
 double totalcost = costbreak.stream().mapToDouble(e-> Double.parseDouble(e[0].toString())).sum();
 if(PfmsInitiationList[19]!=null && PfmsInitiationList[19].toString().equalsIgnoreCase("1") ||
		 PfmsInitiationList[19].toString().equalsIgnoreCase("2")|| PfmsInitiationList[19].toString().equalsIgnoreCase("4") ||
		 PfmsInitiationList[19].toString().equalsIgnoreCase("6") ||PfmsInitiationList[19].toString().equalsIgnoreCase("7") ||
		 PfmsInitiationList[19].toString().equalsIgnoreCase("8")){ 
		 
		 
	  double transportation=0; 
	  double Equipment = 0;
	  double CARSCAPSI =0;
	  double Consultancy=0;
	  double TechnicalServices=0;
	  double HiringofTransport=0;
	  double ProjectVehicles=0;
	  double Miscellaneous=0;
	  double PlantMachinery=0;
	  double ProjectrelatedVehicles=0;
	  double Works=0;
	  
	  double FEtransportation=0; 
	  double FEEquipment = 0;
	  double FECARSCAPSI =0;
	  double FEConsultancy=0;
	  double FETechnicalServices=0;
	  double FEHiringofTransport=0;
	  double FEProjectVehicles=0;
	  double FEMiscellaneous=0;
	  double FEPlantMachinery=0;
	  double FEProjectrelatedVehicles=0;
	  double FEWorks=0;
	  for(Object[] obj:costbreak){
	  
	   if(obj[3].toString().contains("Consultancy ")){
		   Consultancy+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEConsultancy+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Fuel")){
		   ProjectVehicles+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectVehicles+=Double.parseDouble(obj[0].toString()); }
	  } 
	 if(obj[3].toString().contains("CAPSI")){
		 CARSCAPSI+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FECARSCAPSI+=Double.parseDouble(obj[0].toString()); }
	  } 
	 
	    if(obj[3].toString().contains("Equipment")){
	    	Equipment+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEEquipment+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Miscellaneous")){
		   Miscellaneous+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEMiscellaneous+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Hiring")){
		   HiringofTransport+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEHiringofTransport+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Jobwork")){
		   TechnicalServices+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FETechnicalServices+=Double.parseDouble(obj[0].toString()); }
	  } 
	if(obj[3].toString().contains("Machinery")){
		PlantMachinery+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEPlantMachinery+=Double.parseDouble(obj[0].toString()); }
	  } 
	    if(obj[3].toString().contains("Project related Vehicles")){
	    	ProjectrelatedVehicles+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectrelatedVehicles+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Transportation")){
		   transportation+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEtransportation+=Double.parseDouble(obj[0].toString()); }
	  } 
	   if(obj[3].toString().contains("Works")){
		   Works+=Double.parseDouble(obj[0].toString());
		   if("FE".equalsIgnoreCase(obj[2].toString())){FEWorks+=Double.parseDouble(obj[0].toString()); }
	  }  
			}
		 
		 
		 %>
 <table class="border-black" style="margin-top:0px; margin-bottom: 10px;margin-left: 10px;width:695px;  " id="cost">
		  <thead>
			  	<tr> 
				  	 <th colspan="5" class="border_black weight_700 center">
				 		 	 Cost Break-Up Table for MM, TD, UT & IF Projects  <br> (in &#x20B9; Lakhs.)
				  	</th>
			  	</tr>
			  	<tr>
			  		<th rowspan="2" class="border_black weight_700 center"> Minor Head </th>
			  		<th class="border_black weight_700 center" > Major Head 4076 - Revenue </th>
			  		<th class="border_black weight_700 center"> Nodal  Lab</th>
			  		<th class="border_black weight_700 center"> Participating <br> Lab, if any</th>
			  		<th rowspan="2" class="border_black weight_700 center"> Total  (FE) </th>
			  	</tr>
			  	<tr>
			  		<th class="border_black weight_700 center"> Heads of Expenditure </th>
			  		<th class="border_black weight_700 center"> Total (FE) </th>
			  		<th class="border_black weight_700 center"> Total (FE)</th>
			  	</tr>
		  </thead>
		  
		  <tbody>
				  	<tr>	
				  		<td class="border-black" rowspan="10">052 <br>(Code Head-929/25)*</td>	
				  		<td class="border-black" style="padding:12px;"> Transportation (Movement of Stores)</td>
				  		<td class="border-black" style="text-align:right;font-size: 13px;"><%=nfc.convert(transportation/100000)%><br>(<%=nfc.convert(FEtransportation/100000)%>)</td>
				  		<td class="border-black" align="right"style="font-size: 13px">0.00</td>
				  		<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(transportation/100000)%><br>(<%=nfc.convert(FEtransportation/100000) %>)</td>
				   </tr>
				   <tr>
				   		<td class="border-black" style="padding-top:20px;padding-bottom: 20px;"> Equipment/Stores</td>
				   		<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(Equipment/100000)%><br>(<%=nfc.convert(FEEquipment/100000)%>)</td>
				  		<td class="border-black" align="right" style="font-size: 13px">0.00</td>
				  		<td class="border-black" style="text-align:right;font-size: 13px">(<%=nfc.convert(Equipment/100000)%><br>(<%=nfc.convert(FEEquipment/100000)%>)</td>
				   </tr>	 	
				  <tr>
				 		<td class="border-black"  style="padding:12px;"> CARS/CAPSI </td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(CARSCAPSI/100000)%>)<br>(<%=nfc.convert(FECARSCAPSI/100000)%>)</td>
				  		<td class="border-black"  align="right" style="font-size: 13px">0.00</td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(CARSCAPSI/100000)%><br>(<%=nfc.convert(FECARSCAPSI/100000)%>)</td>
				  </tr>
				  <tr>
				 		<td class="border-black"  style="padding:12px;"> Consultancy Contracts </td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(Consultancy/100000)%><br>(<%=nfc.convert(FEConsultancy/100000)%>)</td>
				  		<td class="border-black"  align="right" style="font-size: 13px"> 0.00</td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(Consultancy/100000)%><br>(<%=nfc.convert(FEConsultancy/100000)%>)</td>
				  </tr> 
				  <tr>
				  		<td class="border-black"  style="padding:12px;"> Job Work/Contracts/Technical Services</td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(TechnicalServices/100000)%><br>(<%=nfc.convert(FETechnicalServices/100000)%>)</td>
				  		<td class="border-black"  align="right" style="font-size: 13px"> 0.00</td>
				  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(TechnicalServices/100000)%><br>(<%=nfc.convert(FETechnicalServices/100000)%>)</td>
				  </tr>

				  <tr>
				 	 <td class="border-black"  style="padding:12px;"> Hiring of Transport </td>
				 	 <td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(HiringofTransport/100000)%><br>(<%=nfc.convert(FEHiringofTransport/100000)%>)</td>
				  	 <td class="border-black"  align="right" style="font-size: 13px"> 0.00</td>
				  	 <td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(HiringofTransport/100000)%><br>(<%=nfc.convert(FEHiringofTransport/100000)%>)</td>
				 </tr>
				 <tr>
				 	<td class="border-black"  style="padding:12px;"> Fuel/Oil/Lubricants for Project Vehicles</td>
				 	<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(ProjectVehicles/100000)%><br>(<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
				  	<td class="border-black"  align="right" style="font-size: 13px"> 0.00</td>
				    <td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(ProjectVehicles/100000)%><br>(<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
				 </tr>	
				  <tr>
				 	<td class="border-black"  style="padding:12px;"> Contingency & Miscellaneous</td>
				 	<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(Miscellaneous/100000)%><br>(<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
				  	<td class="border-black" align="right" style="font-size: 13px"> 0.00</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(Miscellaneous/100000)%><br>(<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
				 </tr>	 
				 <tr>
				  	<td  class="border-black" style="padding:12px;"> Plant & Machinery</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(PlantMachinery/100000)%><br>(<%=nfc.convert(FEPlantMachinery/100000)%>)</td>
				  	<td class="border-black" align="right" style="font-size: 13px"> 0.00</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(PlantMachinery/100000)%><br>(<%=nfc.convert(FEPlantMachinery/100000)%>)</td>
				</tr>
			    <tr>
			  		<td  class="border-black" style="padding:12px;"> Project related Vehicles </td>
			  		<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(ProjectrelatedVehicles/100000)%> <br>(<%=nfc.convert(FEProjectrelatedVehicles/100000)%>)</td>
				  	<td class="border-black" align="right" style="font-size: 13px"> 0.00</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(ProjectrelatedVehicles/100000)%><br>(<%=nfc.convert(FEProjectrelatedVehicles/100000)%>)</td>
			  	</tr>
			  	 <tr>
			  		<td  class="border-black" style="padding:12px;"> 111 </td>
			  		<td class="border-black" > Works</td>
			  		<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(Works/100000)%><br>(<%=nfc.convert(FEWorks/100000)%>)</td>
				  	<td class="border-black" align="right" style="font-size: 13px"> 0.00</td>
				  	<td class="border-black" style="text-align:right;font-size: 13px"><%=nfc.convert(Works/100000)%><br>(<%=nfc.convert(FEWorks/100000)%>)</td>
				  	
			  	</tr>
			  	<tr>
			  		<td colspan="2" class="border-black"style="padding:12px;" > Total </td>
			  		<td style="text-align:right;font-size: 13px"class="border-black "><%=nfc.convert(totalcost/100000)%><br>(<%=nfc.convert((FEtransportation + FEEquipment + FECARSCAPSI + FEConsultancy + FETechnicalServices + FEHiringofTransport + FEProjectVehicles + FEMiscellaneous + FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td>
			  		<td class="border-black"  align="right" style="font-size: 13px">0.00</td>
			  		<td class="border-black"  style="text-align:right;font-size: 13px"><%=nfc.convert(totalcost/100000)%><br>(<%=nfc.convert((FEtransportation + FEEquipment + FECARSCAPSI + FEConsultancy + FETechnicalServices + FEHiringofTransport + FEProjectVehicles + FEMiscellaneous + FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td></td>
			  	</tr>
		  </tbody>
 </table>
<%--  <table class="executive editor-text-font" style="margin-top:10px; margin-bottom: 10px;margin-left: 3px;width:707px;  " id="cost">
		  <thead>
			  	<tr> 
				  	 <th colspan="5" class="border_black weight_700 center">
				 		 	 Cost Break-Up Table for MM, TD, UT & IF Projects  <br> (in &#x20B9; Lakhs.)
				  	</th>
			  	</tr>
			  	<tr>
			  		<th rowspan="2" class="border_black weight_700 center"> Minor Head </th>
			  		<th class="border_black weight_700 center"> Major Head 4076 - Revenue </th>
			  		<th class="border_black weight_700 center"> Nodal  Lab</th>
			  		<th class="border_black weight_700 center"> Participating <br> Lab, if any</th>
			  		<th rowspan="2" class="border_black weight_700 center"> Total  (FE) </th>
			  	</tr>
			  	<tr>
			  		<th class="border_black weight_700 center"> Heads of Expenditure </th>
			  		<th class="border_black weight_700 center"> Total (FE) </th>
			  		<th class="border_black weight_700 center"> Total (FE)</th>
			  	</tr>
		  </thead>
		  
		  <tbody>
				  	<tr>	
				  		<td rowspan="10">052 <br>(Code Head-929/25)*</td>	
				  		<td style="padding:2px;"> Transportation (Movement of Stores)</td>
				  		<td style="text-align:right;"><%=nfc.convert(transportation/100000)%><br>(<%=nfc.convert(FEtransportation/100000)%>)</td>
				  		<td align="right">0.00</td>
				  		<td style="text-align:right;"><%=nfc.convert(transportation/100000)%><br>(<%=nfc.convert(FEtransportation/100000) %>)</td>
				   </tr>
				   <tr>
				   		<td  style="padding:2px;"> Equipment/Stores</td>
				   		<td style="text-align:right;"><%=nfc.convert(Equipment/100000)%><br>(<%=nfc.convert(FEEquipment/100000)%>)</td>
				  		<td align="right">0.00</td>
				  		<td style="text-align:right;"><%=nfc.convert(Equipment/100000)%><br>(<%=nfc.convert(FEEquipment/100000)%>)</td>
				   </tr>	 	
				  <tr>
				 		<td  style="padding:2px;"> CARS/CAPSI </td>
				  		<td style="text-align:right;"><%=nfc.convert(CARSCAPSI/100000)%><br>(<%=nfc.convert(FECARSCAPSI/100000)%>)</td>
				  		<td align="right">0.00</td>
				  		<td style="text-align:right;"><%=nfc.convert(CARSCAPSI/100000)%><br>(<%=nfc.convert(FECARSCAPSI/100000)%>)</td>
				  </tr>
				  <tr>
				 		<td  style="padding:2px;"> Consultancy Contracts </td>
				  		<td style="text-align:right;"><%=nfc.convert(Consultancy/100000)%><br>(<%=nfc.convert(FEConsultancy/100000)%>)</td>
				  		<td align="right"> 0.00</td>
				  		<td style="text-align:right;"><%=nfc.convert(Consultancy/100000)%><br>(<%=nfc.convert(FEConsultancy/100000)%>)</td>
				  </tr> 
				  <tr>
				  		<td  style="padding:2px;"> Job Work/Contracts/Technical Services</td>
				  		<td style="text-align:right;"><%=nfc.convert(TechnicalServices/100000)%><br>(<%=nfc.convert(FETechnicalServices/100000)%>)</td>
				  		<td align="right"> 0.00</td>
				  		<td style="text-align:right;"><%=nfc.convert(TechnicalServices/100000)%><br>(<%=nfc.convert(FETechnicalServices/100000)%>)</td>
				  </tr>

				  <tr>
				 	 <td  style="padding:2px;"> Hiring of Transport </td>
				 	 <td style="text-align:right;"><%=nfc.convert(HiringofTransport/100000)%><br>(<%=nfc.convert(FEHiringofTransport/100000)%>)</td>
				  	 <td align="right"> 0.00</td>
				  	 <td style="text-align:right;"><%=nfc.convert(HiringofTransport/100000)%><br>(<%=nfc.convert(FEHiringofTransport/100000)%>)</td>
				 </tr>
				 <tr>
				 	<td  style="padding:2px;"> Fuel/Oil/Lubricants for Project Vehicles</td>
				 	<td style="text-align:right;"><%=nfc.convert(ProjectVehicles/100000)%><br>(<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
				  	<td align="right"> 0.00</td>
				    <td style="text-align:right;"><%=nfc.convert(ProjectVehicles/100000)%><br>(<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
				 </tr>	
				  <tr>
				 	<td  style="padding:2px;"> Contingency & Miscellaneous</td>
				 	<td style="text-align:right;"><%=nfc.convert(Miscellaneous/100000)%><br>(<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
				  	<td align="right"> 0.00</td>
				  	<td style="text-align:right;"><%=nfc.convert(Miscellaneous/100000)%><br>(<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
				 </tr>	 
				 <tr>
				  	<td  style="padding:2px;"> Plant & Machinery</td>
				  	<td style="text-align:right;"><%=nfc.convert(PlantMachinery/100000)%><br>(<%=nfc.convert(FEPlantMachinery/100000)%>)</td>
				  	<td align="right"> 0.00</td>
				  	<td style="text-align:right;"><%=nfc.convert(PlantMachinery/100000)%><br>(<%=nfc.convert(FEPlantMachinery/100000)%>)</td>
				</tr>
			    <tr>
			  		<td  style="padding:0px;"> Project related Vehicles </td>
			  		<td style="text-align:right;"><%=nfc.convert(ProjectrelatedVehicles/100000)%> <br>(<%=nfc.convert(FEProjectrelatedVehicles/100000)%>)</td>
				  	<td align="right"> 0.00</td>
				  	<td style="text-align:right;"><%=nfc.convert(ProjectrelatedVehicles/100000)%><br>(<%=nfc.convert(FEProjectrelatedVehicles/100000)%>)</td>
			  	</tr>
			  	 <tr>
			  		<td  style="padding:2px;"> 111 </td>
			  		<td> Works</td>
			  		<td style="text-align:right;"><%=nfc.convert(Works/100000)%><br>(<%=nfc.convert(FEWorks/100000)%>)</td>
				  	<td align="right"> 0.00</td>
				  	<td style="text-align:right;"><%=nfc.convert(Works/100000)%><br>(<%=nfc.convert(FEWorks/100000)%>)</td>
				  	
			  	</tr>
			  	<tr>
			  		<td colspan="2" class="border_black weight_700 right"> Total </td>
			  		<td style="text-align:right;"><%=nfc.convert(totalcost/100000)%><br>(<%=nfc.convert((FEtransportation + FEEquipment + FECARSCAPSI + FEConsultancy + FETechnicalServices + FEHiringofTransport + FEProjectVehicles + FEMiscellaneous + FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td>
			  		<td align="right">0.00</td>
			  		<td style="text-align:right;"><%=nfc.convert(totalcost/100000)%><br>(<%=nfc.convert((FEtransportation + FEEquipment + FECARSCAPSI + FEConsultancy + FETechnicalServices + FEHiringofTransport + FEProjectVehicles + FEMiscellaneous + FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td></td>
			  	</tr>
		  </tbody>
  
 </table> --%>
 <h1 class="break"></h1>
  <%}%>
  <%if(PfmsInitiationList[19]!=null && PfmsInitiationList[19].toString().equalsIgnoreCase("3") ||
		 PfmsInitiationList[19].toString().equalsIgnoreCase("5")){
		 
		  double grandtotal = costbreak.stream().mapToDouble(e-> Double.parseDouble(e[0].toString())).sum();
		  double transportation=0; 
		  double Equipment = 0;
		  double CARS =0;
		  double CAPSI=0;
		  double Consultancy=0;
		  double TechnicalServices=0;
		  double HiringofTransport=0;
		  double ProjectVehicles=0;
		  double Miscellaneous=0;
		  double PlantMachinery=0;
		  double ProjectrelatedVehicles=0;
		  double Works=0;
		  double CapWorks=0;
		  
		  double FEtransportation=0; 
		  double FEEquipment = 0;
		  double FECARS =0;
		  double FECAPSI=0;
		  double FEConsultancy=0;
		  double FETechnicalServices=0;
		  double FEHiringofTransport=0;
		  double FEProjectVehicles=0;
		  double FEMiscellaneous=0;
		  double FEPlantMachinery=0;
		  double FEProjectrelatedVehicles=0;
		  double FEWorks=0;
		  double FECapWorks=0;
		  for(Object[] obj:costbreak){ 

				/*  capital part start*/
				if(obj[3].toString().contains("Machinery")){
					PlantMachinery+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FEPlantMachinery+=Double.parseDouble(obj[0].toString());}
				}
				
				if(obj[3].toString().contains("Project related Vehicles")){
					ProjectrelatedVehicles+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectrelatedVehicles+=Double.parseDouble(obj[0].toString());}
				}
				
				if(obj[3].toString().contains("Works") && obj[4].toString().equalsIgnoreCase("4076")){
					CapWorks+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FECapWorks+=Double.parseDouble(obj[0].toString());}
				}
				/*  capital part end */ 
				
				/*revenue start  */
				
				if(obj[3].toString().contains("CAPSI")){
					CAPSI+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FECAPSI+=Double.parseDouble(obj[0].toString());}
				}
				
				if(obj[3].toString().contains("CARS")){
					CARS+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FECARS+=Double.parseDouble(obj[0].toString());}
				}
				   if(obj[3].toString().contains("Consultancy ")){
					   Consultancy+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEConsultancy+=Double.parseDouble(obj[0].toString()); }
				  } 
				
				   if(obj[3].toString().contains("Fuel")){
					   ProjectVehicles+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectVehicles+=Double.parseDouble(obj[0].toString()); }
				  } 
				   
				   if(obj[3].toString().contains("Equipment")){
				    	Equipment+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEEquipment+=Double.parseDouble(obj[0].toString()); }
				  } 
				   if(obj[3].toString().contains("Hiring")){
					   HiringofTransport+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEHiringofTransport+=Double.parseDouble(obj[0].toString()); }
				  } 
				  
				   if(obj[3].toString().contains("Jobwork")){
					   TechnicalServices+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FETechnicalServices+=Double.parseDouble(obj[0].toString()); }
				  } 
				   if(obj[3].toString().contains("Transportation")){
					   transportation+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEtransportation+=Double.parseDouble(obj[0].toString()); }
				  } 
				   if(obj[3].toString().contains("Miscellaneous")){
					   Miscellaneous+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEMiscellaneous+=Double.parseDouble(obj[0].toString()); }
				  }
				   if(obj[3].toString().contains("Works") && obj[4].toString().equalsIgnoreCase("2080")){
					   Works+=Double.parseDouble(obj[0].toString());
					   if("FE".equalsIgnoreCase(obj[2].toString())){FEWorks+=Double.parseDouble(obj[0].toString()); }
				   } 
		  }
			 
		 
		 
		 %>  

	 
  <table class="border-black" style="margin-top:10px; margin-bottom: 10px;margin-left: 10px;width:710px;  " id="cost">
		  <thead>
			  	<tr> 
				  	 <th colspan="5" class="border_black weight_700 center">
				  	 		Cost Break-up Table for S&T & PS Projects  <br> (in &#x20B9; Lakhs.) 
				  	</th> 
			  	</tr>
			  	<tr>
			  		<th rowspan="2" class="border_black weight_700 center"> Minor Head </th>
			  		<th class="border_black weight_700 center" > Major Head 2080 - Capital <br> Sub Major Head - 05 </th>
			  		<th class="border_black weight_700 center"> Nodal <br> Lab</th>
			  		<th class="border_black weight_700 center"> Participating <br> Lab, if any</th>
			  		<th class="border-black" rowspan="2"> Total <br> (FE) </th>
			  	</tr>
			  	<tr>
			  		<th class="border_black weight_700 center"> Heads of Expenditure </th>
			  		<th class="border_black weight_700 center"> Total (FE) </th>
			  		<th class="border_black weight_700 center"> Total (FE)</th>
			  	</tr>
		  </thead>
		  
		  <tbody>
			  	<tr>
			  		<td class="border-black"> 105</td>
			  		<td class="border-black" style="padding:12px;"> Transportation (Movement of Stores) </td>
			  		<td class="border-black"  style="text-align:right;font-size:13px;"><%=nfc.convert(transportation/100000)%><br>(<%=nfc.convert(FEtransportation/100000)%>)</td>
			  		<td class="border-black" style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black" style="text-align:right;font-size:13px; "><%=nfc.convert(transportation/100000)%> <br>(<%=nfc.convert(FEtransportation/100000)%>)</td>
			  	</tr>
			  	
			  	<tr>
			  		<td class="border-black" rowspan="7"> 110 <br> (Code Head - <br>856/01)**</td>
			  		<td class="border-black"style="padding:12px;"> Equipment/Stores </td>
			     	<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(Equipment/100000)%><br> (<%=nfc.convert(FEEquipment/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Equipment/100000)%><br> (<%=nfc.convert(FEEquipment/100000)%>)</td>
			  		
			  	</tr>
			  	<tr>
			  		<td class="border-black" style="padding:12px;"> CARS</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(CARS/100000)%><br> (<%=nfc.convert(FECARS/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(CARS/100000)%><br> (<%=nfc.convert(FECARS/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"> CAPSI</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(CAPSI/100000)%><br> (<%=nfc.convert(FECAPSI/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(CAPSI/100000)%><br> (<%=nfc.convert(FECAPSI/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"> Consultancy Contracts </td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Consultancy/100000)%><br> (<%=nfc.convert(FEConsultancy/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Consultancy/100000)%> <br>(<%=nfc.convert(FEConsultancy/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"> Job Work/Contracts/Hiring of <br>Technical Services</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(TechnicalServices/100000)%><br> (<%=nfc.convert(FETechnicalServices/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(TechnicalServices/100000)%><br> (<%=nfc.convert(FETechnicalServices/100000)%>)</td>

			  	</tr> 
				<tr>
			  		<td class="border-black"style="padding:12px;font-size:13px;"> Hiring of Transport,  <br>Fuel/Oil/Lubricants for Project <br> Vehicles</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((ProjectVehicles+HiringofTransport)/100000)%><br> (<%=nfc.convert((FEProjectVehicles+FEHiringofTransport)/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((ProjectVehicles+HiringofTransport)/100000)%><br> (<%=nfc.convert((FEProjectVehicles+FEHiringofTransport)/100000)%>)</td>
			  		
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;">Contingency & Miscellaneous</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Miscellaneous/100000)%><br> (<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Miscellaneous/100000)%><br> (<%=nfc.convert(FEMiscellaneous/100000)%>)</td>

			  	</tr>
			  	<tr>
			 	 	<td class="border-black"> 111</td>
			  		<td class="border-black"style="padding:12px;"> Works</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Works/100000)%><br> (<%=nfc.convert(FEWorks/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert(Works/100000)%><br> (<%=nfc.convert(FEWorks/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;" colspan="2" class="border_black"> Total (Revenue)</td>
			  	    <td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((transportation + Equipment + CARS +HiringofTransport+ CAPSI + Consultancy + TechnicalServices + ProjectVehicles + Miscellaneous + Works)/100000)%> 
			  	 <br> (<%=nfc.convert((FEtransportation + FEEquipment + FECARS + FECAPSI + FEConsultancy + FETechnicalServices + FEProjectVehicles + FEMiscellaneous + FEWorks+FEHiringofTransport)/100000)%>)</td>	
			  		<td class="border-black"style="text-align:right;font-size:13px;">0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((transportation + Equipment + CARS + CAPSI + Consultancy + TechnicalServices + ProjectVehicles + Miscellaneous + Works)/100000)%> 
			  		<br>(<%=nfc.convert((FEtransportation + FEEquipment + FECARS + FECAPSI + FEConsultancy + FETechnicalServices + FEProjectVehicles + FEMiscellaneous + FEWorks+FEHiringofTransport)/100000)%>)</td>
			  	</tr>
			  	<tr>
			 	 	<td class="border-black"rowspan="3"> 052 <br>(Code Head - <br>929/24)*** </td>
			  		<td class="border-black"style="padding:12px;"> Plant & Machinery </td>
			  		<td class="border-black"rowspan="2" style="font-size:13px;;text-align:right;"> <%=nfc.convert((PlantMachinery + ProjectrelatedVehicles)/100000) %> <br>(<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles)/100000) %>)</td>
			  		<td class="border-black"rowspan="2" style="font-size:13px;text-align:right;">0.00</td>
			  		<td class="border-black"rowspan="2" style="text-align:right;font-size:13px;"> <%=nfc.convert((PlantMachinery + ProjectrelatedVehicles)/100000) %><br> (<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles)/100000) %>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black" style="padding:12px;"> Project related Vehicles </td>
			  		
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"> Works </td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(CapWorks/100000) %><br> (<%=nfc.convert(FECapWorks/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(CapWorks/100000) %><br> (<%=nfc.convert(FECapWorks/100000)%>)</td>
			  	</tr>
			  	
			  	
			  	
			  	<tr>
			  		<td class="border-black"style="padding:12px;"colspan="2" class="border_black"> Total (Capital)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((PlantMachinery + ProjectrelatedVehicles+CapWorks)/100000)%><br> (<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles + FECapWorks)/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;">0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"><%=nfc.convert((PlantMachinery + ProjectrelatedVehicles+CapWorks)/100000)%> <br>(<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles + FECapWorks)/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td class="border-black"style="padding:12px;"colspan="2" class="border_black "> Grand Total (Revenue & Capital)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(grandtotal/100000)%> <br>  (<%=nfc.convert((FEtransportation + FEEquipment + FECARS + FECAPSI + FEConsultancy + FETechnicalServices + FEProjectVehicles + FEMiscellaneous + FEWorks+ FEPlantMachinery + FEProjectrelatedVehicles+FECapWorks+FEHiringofTransport)/100000)%>)</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> 0.00</td>
			  		<td class="border-black"style="text-align:right;font-size:13px;"> <%=nfc.convert(grandtotal/100000)%></td>
			  	</tr>
		  </tbody>
  
 </table>
  <h1 class="break"></h1>
  <%}%>
 
 
  <!-- Project Schedule -->
  <div align="center" style="font-size: 25px"><b>Annexure - B </b></div>
<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Project Schedule/Timelines</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<%if(!ScheduleList.isEmpty()){ %>

	<table  class="executive editor-text-font" style="margin-top:10px; margin-bottom: 10px;margin-left: 3px;width:707px;  ">
		<tr>
		<th colspan="1" class="border_black weight_700 center grey" style=";width:7%"><span >SN</span></th>
		<th colspan="3" class="border_black weight_700 center grey" style=";width:50%"><span >Milestone Activity</span></th>
		<td colspan="4" class="border_black  center" style="font-weight: 600"><span >Milestone TotalMonth</span></td>
		<th colspan="2" class="border_black weight_700 center grey" ><span >Milestone Remarks</span></th>
		</tr> 
		<%
		int count=1;
		for(Object[] obj : ScheduleList){ %> 
		<tr>
		<td colspan="1" class="border_black weight_700 center" style=";width:7%;font-weight: 300"><span ><%=count %>.</span></td>
		<td colspan="3" class="border_black weight_700 left" style="padding:5px;font-weight: 300;text-align:justify;" ><span ><%=obj[1] %></span></td>
		<td colspan="4" class="border_black  center" style="font-weight: 300"><%if(obj[5]!=null && obj[2]!=null){ %><%= "T"%><sub><%=obj[5] %></sub><%="+"%><%=obj[2]%><%}else{ %> - <%} %></td>
		<td colspan="2" class="border_black weight_700 center" style="font-weight: 300"><span ><%=obj[4]%></span></td>
		</tr> 
<%
count++;
}
		%>
				<%if(PfmsInitiationList!= null) { Object[] obj = PfmsInitiationList; %>
			
			<tr>
				<td colspan="12" class="border_black right" style=""  ><span ><b style="background: white; margin-right:190px;"><%if(obj[7]!=null && Integer.parseInt(obj[7].toString()) >0 ){ %>Total Duration :&nbsp;<%=obj[7]+" Months" %></b ></span><%}%></td>
			</tr>
			<%} %>
</table>
	
<%}else{ %>	


<table  class="executive" style="margin-top:10px; margin-bottom: 10px;margin-left: 3px;width:707px; font-size: 22px; ">

<tr>
	<th colspan="1" class="border_black weight_700 left grey" style=";width:9%"><span >SN</span></th>
	<th colspan="5" class="border_black weight_700 center grey" style=";width:80%"><span >Milestone Activity</span></th>
	<th colspan="2" class="border_black weight_700 center grey" ><span >Time(Months)</span></th>
</tr> 
<tr>
	<th colspan="8" class="border_black weight_700 center" ><span >No Data Available</span></th>
</tr> 

</table>

<%} %>

 <h1 class="break"></h1>
 
  <!-- Realization --> 
 
<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:615px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Realization Plan </th>
		</tr>
		<tr>
		<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 0px;width:715px; font-size: 22px; ">
<%
if(!DetailsList.isEmpty()){
for(Object[] obj : DetailsList){   %>
	
		<tbody>
			<tr>
			<%if(obj[10]!=null){  %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[10] %></td>
			<%}else{ %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
			<%} %>
			</tr>
			
			<%}}else {%>
			<tr>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
			</tr>
			<%} %>
	</tbody>
</table>



 



<%-- <%if(!RequirementList.isEmpty()){ %>
 <h1 class="break"></h1>
 <br>
 <div align="center" style="font-size: 25px"><b>Annexure - C </b></div>
 <table class="editor-text-font" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 30px; width: 600px; border-collapse:collapse;font-size: 17px !important" >
 <tr style="">
			<td  class="border_black  center" style=";width:140px;font-weight: 600;padding:5px !important;">Requirement ID</td>
				<td class="border_black  center" style="font-weight: 600"><span >Description</span></td>
 </tr>
 <%
 for(Object obj[]:RequirementList){
 %>
 <tr style="font-size: 16px;">
 	<td  class="border_black  center" style=";width:140px;"><%=obj[1]%></td>
	<td class="border_black  center" style="text-align: justify;padding:10px;"><span ><%=obj[4] %></span></td>
 </tr>
 <%} %>
 </table>
<%} %> --%>

  <!-- Thank You Page -->
  
   <h1 class="break"></h1>
<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:600px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size: 55px" class="heading-color"><br><br><br><br><br><br>THANK YOU<br><br><br></th>
		</tr>
		
	</tbody>
</table>
</body>
</html>