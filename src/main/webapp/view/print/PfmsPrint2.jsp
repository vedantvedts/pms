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
<%-- <jsp:include page="../static/dependancy.jsp"></jsp:include> --%>

<title>Project Proposal</title>


<%

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf2=new SimpleDateFormat("MMMM yyyy");
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> costbreak = (List<Object[]>)request.getAttribute("costbreak");
List<Object[]> PfmsInitiationList=(List<Object[]>)request.getAttribute("PfmsInitiationList");
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
List<Object[]> CostDetailsList=(List<Object[]>)request.getAttribute("CostDetailsList");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
Object[] LabList=(Object[])request.getAttribute("LabList");
String lablogo=(String)request.getAttribute("lablogo");



%>


<style type="text/css">
 

  .break {
    page-break-before: always;
      }
     

	     
     @page {
      size: landscape; 
       margin-top: 49px;
          margin-left: 72px;
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
             content: "Proposed Project: <%=PfmsInitiationList.get(0)[4]%>";
             margin-top: 30px;
             font-size: 13px;
         }
         
        @top-left {
             content: "<%=PfmsInitiationList.get(0)[3]%>";
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
	width: 923px !important;
}



</style>


<meta charset="ISO-8859-1">
<title> Project Proposal </title>
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







<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >

	<tbody>
		<tr>
				<th colspan="8" style="  text-align: center; padding: 0 5px 5px;font-size:35px" class=" heading-color"><br>Project Proposal</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
		
	
		<tr>
				<th colspan="8" style="  text-align: center; padding: 0 5px 5px;font-size:35px"><%if(PfmsInitiationList.get(0)[5]!=null){ %><br><%=PfmsInitiationList.get(0)[5] %><%}else{ %><i>Project Title</i><%} %>
			</th>
		</tr>
	
		<tr>
			<th colspan="8" style="  text-align: center; padding: 0 5px 5px;font-size:26px"><%if(PfmsInitiationList.get(0)[4]!=null){ %>(<%=PfmsInitiationList.get(0)[4] %>)<%}else{ %><i> - </i><%} %>
			</th>
		</tr>
	
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size: 35px">
				<%if(PfmsInitiationList.get(0)[10]!=null){%> <%=sdf2.format(PfmsInitiationList.get(0)[10])%><%}else{ %>-<%} %>
			</th>
		</tr>
		
		<tr>			
			<th colspan="8" style="text-align: center; font-weight: 700;">
				<br><br>
				<img class="logo" style="width:120px;height: 120px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px;padding-top: 50px;">(ISO 9001-2015 Certified Establishment)</th>
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


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Brief of Proposed Project</th>
		</tr>
		<tr>
		<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey;"></th>
		</tr>
	</tbody>
</table>
<br>
<% for (Object[] obj : PfmsInitiationList){ %>
<table  class="brieftable executive" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:820px; font-size: 20px;border-collapse: collapse; ">
	<tbody>
		<tr>
			<th  class="border_black weight_700 left" ><span >Title of the Project</span></th>
			<td  class="border_black weight_700 left" ><span ><%if(obj[5]!=null){ %><%=obj[5] %><%}else{ %><i></i><%} %></span></td>
		</tr>
		<tr>
			<th  class="border_black weight_700 left" ><span >Cost</span></th>
			<td  class="border_black weight_700 left" ><span ><%if(obj[6]!=null){ %><i>&#8377;</i> <%=nfc.convert(Double.parseDouble(obj[6].toString())/100000)%> Lakhs<%}else{ %><i></i><%} %></span></td>
		</tr>
		<tr>
			<th	 class="border_black weight_700 left" ><span >PDC</span></th>
			<td  class="border_black weight_700 left" ><span ><%if(obj[7]!=null){ %><%=obj[7] %> Months <%}else{ %><i></i><%} %></span></td>
		</tr>
		<tr>
			<th  class="border_black weight_700 left"> <span >Security Classification</span></th>
			<td  class="border_black weight_700 left" ><span ><%if(obj[3]!=null){ %><%=obj[3] %><%}else{ %><i></i><%} %></span></td>
		</tr>
		<tr>
			<th  class="border_black weight_700 left"> <span >Whether Plan/Non-Plan</span></th>
			<td class="border_black weight_700 left" ><span ><%if(obj[8]!=null){ if(obj[8].toString().equalsIgnoreCase("P")){%> Plan <%}if(obj[8].toString().equalsIgnoreCase("N")){ %>Non-Plan - <%if(obj[14]!=null){ %> (Remarks : <%=obj[14]%> ) <%}else{ %> No  Remarks <%} %> <%}}else{ %><%} %></span></td>
		</tr> 
		
	</tbody>
</table>
<%} %>
		
<h1 class="break"></h1>

<!-- Need For Project -->

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Need of the Project</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
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

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Requirements</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
	<tbody>
<%if(!DetailsList.isEmpty()){
	
	for(Object[] obj: DetailsList){
	%>
	
		<tr>
		<%if(obj[0]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[0] %></td>
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


<!-- World Scenario -->

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">World Scenario</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
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


<!-- Objective and Scope-->

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Objective & Scope</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
	<tbody>
<%if(!DetailsList.isEmpty()){
	
	for(Object[] obj: DetailsList){
	
	%>
		<tr>
		<th colspan="8" style="  text-align: left; padding: 0 5px 5px;font-size:20px;font-family:Gadugi">Objective : 
		</tr>
		<tr>
		<%if(obj[1]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[1] %></td>
		<%}else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" ><i class="normal">To be filled</i></td>
		<%} %>
		</tr>
		
		<tr>
		<th colspan="8" style="  text-align: left; padding: 0 5px 5px;font-size:20px;font-family:Gadugi">Scope : 
		</tr>
		<tr>
		<%if(obj[2]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[2] %></td>
		<%}else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
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

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Deliverables</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>
 
<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
			<%if(!PfmsInitiationList.isEmpty()){
				
				for(Object[] obj: PfmsInitiationList){
				
				%>
		<tr>
		<%if(obj[11]!=null){  %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><br>
		
		
		<%=obj[11] %></td>
		<%}else{ %>
		<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
		<%} %>
		</tr>
	<%}} %>
	</tbody>
</table>

 
<h1 class="break"></h1> 
 

<!-- Participating Labs with Work Share -->


<%for(Object[] obj : PfmsInitiationList){

	if(obj[9]!=null){ if(obj[9].toString().equalsIgnoreCase("Y")){
	
	%>


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
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

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
	<tbody>
		<tr>
			<td colspan="8" style="  text-align: left; padding: 0 5px 5px;font-size:20px" class="editor-text"><%if(obj1[3]!=null){%><%=obj1[3]%><%}else{%>To be filled<%} %>
			</td>
		</tr>
	</tbody>
</table>

<%} %>

 <h1 class="break"></h1>

 <%}}}%>
 
 
<!-- Brief of Earlier Work Done -->

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Brief of Earlier Work Done </th>
		</tr>
		<tr>
		<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
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

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Competency Established </th>
		</tr>
		<tr>
		<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
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

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
			<th colspan="4"  style="text-align:center;" class="heading heading-color">Technology Challenges</th>
		</tr>
		<tr>
			<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
		<tr>
			<th colspan="8" style="  text-align: left; padding: 0 5px 5px;font-size:20px"><br>Technology Challenges/Issues Foreseen : 
		</th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
	<tbody>
		<%
		if(!DetailsList.isEmpty()){
		for(Object[] obj : DetailsList){ %>
			<tr>
			<%if(obj[7]!=null){  %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px" class="editor-text"><%=obj[7] %></td>
			<%}else{ %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled<br><br></i></td>
			<%} %>
			</tr>
			
			<%}}else {%>
			<tr>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled<br><br></i></td>
			</tr>
			
			<%} %>
			
			
			<tr>
			<th colspan="8" style="text-align: left; font-weight: 700;font-size: 20px;font-family:Gadugi">Risk Mitigation : 
			</tr>
			<%
			if(!DetailsList.isEmpty()){
			for(Object[] obj : DetailsList){ %>
			<tr>
			<%if(obj[8]!=null){  %>
			<td colspan="8" style="text-align:justify; padding: 0 5px 5px;" class="editor-text"><br><%=obj[8] %></td>
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
 
 
 <!-- Proposal -->

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Proposal </th>
		</tr>
		<tr>
		<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
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
 
<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
	   <tr>
		   <th colspan="4"  style="text-align:center;" class="heading heading-color">Cost Breakup as per proposal</th>
	   </tr>
	   <tr>
		   <th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
	   </tr>
	</tbody>
</table>

<%if(!CostDetailsList.isEmpty()){ %>

<table  class="executive editor-text-font" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px;border-collapse: collapse; ">
	<tbody>
	<tr>
		<th colspan="1" class="border_black weight_700 center" style=";width:7%"><span >SN</span></th>
		<th colspan="3" class="border_black weight_700 center" style=";width:15%"><span >Head Code</span></th>
		<th colspan="2" class="border_black weight_700 center" style=";width:45%"><span >Item</span></th>
		<th colspan="2" class="border_black weight_700 center"style=";width:20%"> <span >Cost (Lakhs)</span></th>
	</tr>
		<%int count=1;
		for(Object[] obj : CostDetailsList){ %> 
	<tr>
		<td colspan="1" class="border_black weight_700 center" style=";width:7%"><span ><%=count %>.</span></td>
		<td colspan="3" class=" left" style="padding-left:5px" ><span ><%=obj[1] %></span></td>
		<td colspan="2" class=" left" style="padding-left:5px" ><span ><%=obj[2] %></span></td>
		<td colspan="2" class="border_black weight_700 right" style="padding-right:5px" ><span >&#8377; <span><%=nfc.convert(Double.parseDouble(obj[3].toString())/100000)%></span></span></td>
	</tr> 
	</tbody>
	<%
	count++;
	} %>
	
</table>

<%}else{ %>
<table  class="executive editor-text-font" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:820px;  ">

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
 if(PfmsInitiationList.get(0)[18]!=null && PfmsInitiationList.get(0)[18].toString().equalsIgnoreCase("1") ||
		 PfmsInitiationList.get(0)[18].toString().equalsIgnoreCase("2")|| PfmsInitiationList.get(0)[18].toString().equalsIgnoreCase("4") ||
		 PfmsInitiationList.get(0)[18].toString().equalsIgnoreCase("6") ||PfmsInitiationList.get(0)[18].toString().equalsIgnoreCase("7") ||
		 PfmsInitiationList.get(0)[18].toString().equalsIgnoreCase("8")){ 
		 
		 
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
			if("1".equalsIgnoreCase(obj[1].toString()) ||"2".equalsIgnoreCase(obj[1].toString()) ||
			   "23".equalsIgnoreCase(obj[1].toString())||"24".equalsIgnoreCase(obj[1].toString())){ 
				transportation+=Double.parseDouble(obj[0].toString()); 	
			if("FE".equalsIgnoreCase(obj[2].toString())){FEtransportation+=Double.parseDouble(obj[0].toString()); }
				}  
			if("3".equalsIgnoreCase(obj[1].toString()) ||"4".equalsIgnoreCase(obj[1].toString()) ||
					   "25".equalsIgnoreCase(obj[1].toString())||"26".equalsIgnoreCase(obj[1].toString())){ 
				Equipment+=Double.parseDouble(obj[0].toString());
				if("FE".equalsIgnoreCase(obj[2].toString())){FEEquipment+=Double.parseDouble(obj[0].toString()); }
			}
			if("5".equalsIgnoreCase(obj[1].toString()) ||"6".equalsIgnoreCase(obj[1].toString()) ||
					   "27".equalsIgnoreCase(obj[1].toString())||"28".equalsIgnoreCase(obj[1].toString()) ||
					   "29".equalsIgnoreCase(obj[1].toString())||"30".equalsIgnoreCase(obj[1].toString())){ 
				CARSCAPSI+=Double.parseDouble(obj[0].toString()); 
				if("FE".equalsIgnoreCase(obj[2].toString())){FECARSCAPSI+=Double.parseDouble(obj[0].toString()); }
			}
			if("7".equalsIgnoreCase(obj[1].toString()) ||"8".equalsIgnoreCase(obj[1].toString()) ||
					   "31".equalsIgnoreCase(obj[1].toString())||"32".equalsIgnoreCase(obj[1].toString())){ 
				Consultancy+=Double.parseDouble(obj[0].toString()); 
				if("FE".equalsIgnoreCase(obj[2].toString())){FEConsultancy+=Double.parseDouble(obj[0].toString()); }	
			}
			if("9".equalsIgnoreCase(obj[1].toString()) ||"10".equalsIgnoreCase(obj[1].toString()) ||
					   "33".equalsIgnoreCase(obj[1].toString())||"34".equalsIgnoreCase(obj[1].toString())){ 
				TechnicalServices+=Double.parseDouble(obj[0].toString()); 
				if("FE".equalsIgnoreCase(obj[2].toString())){FETechnicalServices+=Double.parseDouble(obj[0].toString()); }
			}
			if("11".equalsIgnoreCase(obj[1].toString()) ||"12".equalsIgnoreCase(obj[1].toString()) ||
					   "35".equalsIgnoreCase(obj[1].toString())||"36".equalsIgnoreCase(obj[1].toString())){ 
				HiringofTransport+=Double.parseDouble(obj[0].toString()); 
				if("FE".equalsIgnoreCase(obj[2].toString())){FEHiringofTransport+=Double.parseDouble(obj[0].toString()); }	
			}
			if("13".equalsIgnoreCase(obj[1].toString()) ||"14".equalsIgnoreCase(obj[1].toString()) ||
					   "37".equalsIgnoreCase(obj[1].toString())||"38".equalsIgnoreCase(obj[1].toString())){ 
				ProjectVehicles+=Double.parseDouble(obj[0].toString());
				if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectVehicles+=Double.parseDouble(obj[0].toString()); }	
			}
			if("15".equalsIgnoreCase(obj[1].toString()) ||"16".equalsIgnoreCase(obj[1].toString()) ||
					   "39".equalsIgnoreCase(obj[1].toString())||"40".equalsIgnoreCase(obj[1].toString())){ 
				Miscellaneous+=Double.parseDouble(obj[0].toString()); 
				if("FE".equalsIgnoreCase(obj[2].toString())){FEMiscellaneous+=Double.parseDouble(obj[0].toString()); }	
			}
			if("17".equalsIgnoreCase(obj[1].toString()) ||"18".equalsIgnoreCase(obj[1].toString()) ||
					   "43".equalsIgnoreCase(obj[1].toString())||"44".equalsIgnoreCase(obj[1].toString())){ 
				PlantMachinery+=Double.parseDouble(obj[0].toString());
				if("FE".equalsIgnoreCase(obj[2].toString())){FEPlantMachinery+=Double.parseDouble(obj[0].toString()); }	
			}
			if("19".equalsIgnoreCase(obj[1].toString()) ||"20".equalsIgnoreCase(obj[1].toString()) ||
					   "45".equalsIgnoreCase(obj[1].toString())||"46".equalsIgnoreCase(obj[1].toString())){ 
				ProjectrelatedVehicles+=Double.parseDouble(obj[0].toString());
				if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectrelatedVehicles+=Double.parseDouble(obj[0].toString()); }	
			}
			
			if("21".equalsIgnoreCase(obj[1].toString()) ||"22".equalsIgnoreCase(obj[1].toString()) ||
					   "41".equalsIgnoreCase(obj[1].toString())||"42".equalsIgnoreCase(obj[1].toString())||
					   "47".equalsIgnoreCase(obj[1].toString())||"48".equalsIgnoreCase(obj[1].toString())   
					){ 
				Works+=Double.parseDouble(obj[0].toString()); 
				if("FE".equalsIgnoreCase(obj[2].toString())){FEWorks+=Double.parseDouble(obj[0].toString()); }	
			}
	  
	  }
		 
		 
		 %>

 <table class="executive editor-text-font" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px;  ">
		  <thead>
			  	<tr> 
				  	 <th colspan="5" class="border_black weight_700 center">
				 		 	 Cost Break-Up Table for MM, TD, UT & IF Projects  <br> (in &#x20B9; Lakhs.)
				  	</th>
			  	</tr>
			  	<tr>
			  		<th rowspan="2" class="border_black weight_700 center"> Minor Head </th>
			  		<th class="border_black weight_700 center"> Major Head 2080 - Revenue </th>
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
				  		<td> Transportation (Movement of Stores)</td>
				  		<td><%=nfc.convert(transportation/100000)%> (<%=nfc.convert(FEtransportation/100000)%>)</td>
				  		<td>0.00</td>
				  		<td><%=nfc.convert(transportation/100000)%> (<%=nfc.convert(FEtransportation/100000) %>)</td>
				   </tr>
				   <tr>
				   		<td> Equipment/Stores</td>
				   		<td><%=nfc.convert(Equipment/100000)%> (<%=nfc.convert(FEEquipment/100000)%>)</td>
				  		<td>0.00</td>
				  		<td><%=nfc.convert(Equipment/100000)%> (<%=nfc.convert(FEEquipment/100000)%>)</td>
				   </tr>	 	
				  <tr>
				 		<td> CARS/CAPSI </td>
				  		<td><%=nfc.convert(CARSCAPSI/100000)%> (<%=nfc.convert(FECARSCAPSI/100000)%>)</td>
				  		<td>0.00</td>
				  		<td><%=nfc.convert(CARSCAPSI/100000)%> (<%=nfc.convert(FECARSCAPSI/100000)%>)</td>
				  </tr>
				  <tr>
				 		<td> Consultancy Contracts </td>
				  		<td><%=nfc.convert(Consultancy/100000)%> (<%=nfc.convert(FEConsultancy/100000)%>)</td>
				  		<td> 0.00</td>
				  		<td><%=nfc.convert(Consultancy/100000)%> (<%=nfc.convert(FEConsultancy/100000)%>)</td>
				  </tr> 
				  <tr>
				  		<td> Job Work/Contracts/Technical Services</td>
				  		<td><%=nfc.convert(TechnicalServices/100000)%> (<%=nfc.convert(FETechnicalServices/100000)%>)</td>
				  		<td> 0.00</td>
				  		<td><%=nfc.convert(TechnicalServices/100000)%> (<%=nfc.convert(FETechnicalServices/100000)%>)</td>
				  </tr>

				  <tr>
				 	 <td> Hiring of Transport </td>
				 	 <td><%=nfc.convert(HiringofTransport/100000)%> (<%=nfc.convert(FEHiringofTransport/100000)%>)</td>
				  	 <td> 0.00</td>
				  	 <td><%=nfc.convert(HiringofTransport/100000)%> (<%=nfc.convert(FEHiringofTransport/100000)%>)</td>
				 </tr>
				 <tr>
				 	<td> Fuel/Oil/Lubricants for Project Vehicles</td>
				 	<td><%=nfc.convert(ProjectVehicles/100000)%> (<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
				  	<td> 0.00</td>
				    <td><%=nfc.convert(ProjectVehicles/100000)%> (<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
				 </tr>	
				  <tr>
				 	<td> Contingency & Miscellaneous</td>
				 	<td><%=nfc.convert(Miscellaneous/100000)%> (<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
				  	<td> 0.00</td>
				  	<td><%=nfc.convert(Miscellaneous/100000)%> (<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
				 </tr>	 
				 <tr>
				  	<td> Plant & Machinery</td>
				  	<td><%=nfc.convert(PlantMachinery/100000)%> (<%=nfc.convert(FEPlantMachinery/100000)%>)</td>
				  	<td> 0.00</td>
				  	<td><%=nfc.convert(PlantMachinery/100000)%> (<%=nfc.convert(FEPlantMachinery/100000)%>)</td>
				</tr>
			    <tr>
			  		<td> Project related Vehicles </td>
			  		<td><%=nfc.convert(ProjectrelatedVehicles/100000)%> (<%=nfc.convert(FEProjectrelatedVehicles/100000)%>)</td>
				  	<td> 0.00</td>
				  	<td><%=nfc.convert(ProjectrelatedVehicles/100000)%> (<%=nfc.convert(FEProjectrelatedVehicles/100000)%>)</td>
			  	</tr>
			  	 <tr>
			  		<td> 111 </td>
			  		<td> Works</td>
			  		<td><%=nfc.convert(Works/100000)%> (<%=nfc.convert(FEWorks/100000)%>)</td>
				  	<td> 0.00</td>
				  	<td><%=nfc.convert(Works/100000)%> (<%=nfc.convert(FEWorks/100000)%>)</td>
				  	
			  	</tr>
			  	<tr>
			  		<td colspan="2" class="border_black weight_700 right"> Total </td>
			  		<td><%=nfc.convert(totalcost/100000)%> (<%=nfc.convert((FEtransportation + FEEquipment + FECARSCAPSI + FEConsultancy + FETechnicalServices + FEHiringofTransport + FEProjectVehicles + FEMiscellaneous + FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td>
			  		<td>0.00</td>
			  		<td><%=nfc.convert(totalcost/100000)%> (<%=nfc.convert((FEtransportation + FEEquipment + FECARSCAPSI + FEConsultancy + FETechnicalServices + FEHiringofTransport + FEProjectVehicles + FEMiscellaneous + FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td></td>
			  	</tr>
		  </tbody>
  
 </table>
 <h1 class="break"></h1>
  <%}%>
  <%if(PfmsInitiationList.get(0)[18]!=null && PfmsInitiationList.get(0)[18].toString().equalsIgnoreCase("3") ||
		 PfmsInitiationList.get(0)[18].toString().equalsIgnoreCase("5")){
		 
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
		  for(Object[] obj:costbreak){ 
				if("1".equalsIgnoreCase(obj[1].toString()) ||"2".equalsIgnoreCase(obj[1].toString()) ||
				   "23".equalsIgnoreCase(obj[1].toString())||"24".equalsIgnoreCase(obj[1].toString())){ 
					transportation+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FEtransportation+=Double.parseDouble(obj[0].toString());}
				}  
				if("3".equalsIgnoreCase(obj[1].toString()) ||"4".equalsIgnoreCase(obj[1].toString()) ||
						   "25".equalsIgnoreCase(obj[1].toString())||"26".equalsIgnoreCase(obj[1].toString())){ 
					Equipment+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FEEquipment+=Double.parseDouble(obj[0].toString());}
				}
				
				if("29".equalsIgnoreCase(obj[1].toString()) ||"30".equalsIgnoreCase(obj[1].toString())
						   ){ 
					CAPSI+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FECAPSI+=Double.parseDouble(obj[0].toString());}
					
				}
				if("27".equalsIgnoreCase(obj[1].toString()) ||"28".equalsIgnoreCase(obj[1].toString())){ 
					CARS+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FECARS+=Double.parseDouble(obj[0].toString());}
				}
				if("7".equalsIgnoreCase(obj[1].toString()) ||"8".equalsIgnoreCase(obj[1].toString()) ||
						   "31".equalsIgnoreCase(obj[1].toString())||"32".equalsIgnoreCase(obj[1].toString())){ 
					Consultancy+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FEConsultancy+=Double.parseDouble(obj[0].toString());}
				}
				if("9".equalsIgnoreCase(obj[1].toString()) ||"10".equalsIgnoreCase(obj[1].toString()) ||
						   "33".equalsIgnoreCase(obj[1].toString())||"34".equalsIgnoreCase(obj[1].toString())){ 
					TechnicalServices+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FETechnicalServices+=Double.parseDouble(obj[0].toString());}
				}
				if("11".equalsIgnoreCase(obj[1].toString()) ||"12".equalsIgnoreCase(obj[1].toString()) ||
						   "35".equalsIgnoreCase(obj[1].toString())||"36".equalsIgnoreCase(obj[1].toString())){ 
					HiringofTransport+=Double.parseDouble(obj[0].toString());
					if("FE".equalsIgnoreCase(obj[2].toString())){FEHiringofTransport+=Double.parseDouble(obj[0].toString());}
				}
				if("13".equalsIgnoreCase(obj[1].toString()) ||"14".equalsIgnoreCase(obj[1].toString()) ||
						   "37".equalsIgnoreCase(obj[1].toString())||"38".equalsIgnoreCase(obj[1].toString())){ 
					ProjectVehicles+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectVehicles+=Double.parseDouble(obj[0].toString());}
				}
				if("15".equalsIgnoreCase(obj[1].toString()) ||"16".equalsIgnoreCase(obj[1].toString()) ||
						   "39".equalsIgnoreCase(obj[1].toString())||"40".equalsIgnoreCase(obj[1].toString())){ 
					Miscellaneous+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FEMiscellaneous+=Double.parseDouble(obj[0].toString());}
				}
				if("17".equalsIgnoreCase(obj[1].toString()) ||"18".equalsIgnoreCase(obj[1].toString()) ||
						   "43".equalsIgnoreCase(obj[1].toString())||"44".equalsIgnoreCase(obj[1].toString())){ 
					PlantMachinery+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FEPlantMachinery+=Double.parseDouble(obj[0].toString());}
				}
				
				if("19".equalsIgnoreCase(obj[1].toString()) ||"20".equalsIgnoreCase(obj[1].toString()) ||
						   "45".equalsIgnoreCase(obj[1].toString())||"46".equalsIgnoreCase(obj[1].toString())){ 
					ProjectrelatedVehicles+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FEProjectrelatedVehicles+=Double.parseDouble(obj[0].toString());}
				}
				if("21".equalsIgnoreCase(obj[1].toString()) ||"22".equalsIgnoreCase(obj[1].toString()) ||
						   "41".equalsIgnoreCase(obj[1].toString())||"42".equalsIgnoreCase(obj[1].toString())||
						   "47".equalsIgnoreCase(obj[1].toString())||"48".equalsIgnoreCase(obj[1].toString()) ){ 
					Works+=Double.parseDouble(obj[0].toString()); 
					if("FE".equalsIgnoreCase(obj[2].toString())){FEWorks+=Double.parseDouble(obj[0].toString());}
				}
		  }
			 
		 
		 
		 %>  
  <table class="executive editor-text-font" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px;  ">
		  <thead>
			  	<tr> 
				  	 <th colspan="5">
				  	 		Cost Break-up Table for S&T & PS Projects  <br> (in &#x20B9; Lakhs.) 
				  	</th> 
			  	</tr>
			  	<tr>
			  		<th rowspan="2"> Minor Head </th>
			  		<th> Major Head 4076 - Capital <br> Sub Major Head - 05 </th>
			  		<th> Nodal <br> Lab</th>
			  		<th> Participating <br> Lab, if any</th>
			  		<th rowspan="2"> Total <br> (FE) </th>
			  	</tr>
			  	<tr>
			  		<th> Heads of Expenditure </th>
			  		<th> Total (FE) </th>
			  		<th> Total (FE)</th>
			  	</tr>
		  </thead>
		  
		  <tbody>
			  	<tr>
			  		<td> 105</td>
			  		<td> Transportation (Movement of Stores) </td>
			  		<td><%=nfc.convert(transportation/100000)%> (<%=nfc.convert(FEtransportation/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td><%=nfc.convert(transportation/100000)%> (<%=nfc.convert(FEtransportation/100000)%>)</td>
			  	</tr>
			  	
			  	<tr>
			  		<td rowspan="7"> 110 <br> (Code Head - <br>856/01)**</td>
			  		<td> Equipment/Stores </td>
			     	<td><%=nfc.convert(Equipment/100000)%> (<%=nfc.convert(FEEquipment/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td><%=nfc.convert(Equipment/100000)%> (<%=nfc.convert(FEEquipment/100000)%>)</td>
			  		
			  	</tr>
			  	<tr>
			  		<td> CARS</td>
			  		<td><%=nfc.convert(CARS/100000)%> (<%=nfc.convert(FECARS/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td><%=nfc.convert(CARS/100000)%> (<%=nfc.convert(FECARS/100000)%>)</td>
			  		
			  	</tr>
			  	<tr>
			  		<td> CAPSI</td>
			  		<td><%=nfc.convert(CAPSI/100000)%> (<%=nfc.convert(FECAPSI/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td><%=nfc.convert(CAPSI/100000)%> (<%=nfc.convert(FECAPSI/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td> Consultancy Contracts </td>
			  		<td><%=nfc.convert(Consultancy/100000)%> (<%=nfc.convert(FEConsultancy/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td><%=nfc.convert(Consultancy/100000)%> (<%=nfc.convert(FEConsultancy/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td> Job Work/Contracts/Hiring of <br>Technical Services</td>
			  		<td> <%=TechnicalServices %></td>
			  		<td><%=nfc.convert(TechnicalServices/100000)%> (<%=nfc.convert(FETechnicalServices/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td><%=nfc.convert(TechnicalServices/100000)%> (<%=nfc.convert(FETechnicalServices/100000)%>)</td>

			  	</tr> 
				<tr>
			  		<td> Hiring of Transport,  <br>Fuel/Oil/Lubricants for Project <br> Vehicles</td>
			  		<td><%=nfc.convert(ProjectVehicles/100000)%> (<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td><%=nfc.convert(ProjectVehicles/100000)%> (<%=nfc.convert(FEProjectVehicles/100000)%>)</td>
			  		
			  	</tr>
			  	<tr>
			  		<td>Contingency & Miscellaneous</td>
			  		<td><%=nfc.convert(Miscellaneous/100000)%> (<%=nfc.convert(FEMiscellaneous/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td><%=nfc.convert(Miscellaneous/100000)%> (<%=nfc.convert(FEMiscellaneous/100000)%>)</td>

			  	</tr>
			  	<tr>
			 	 	<td> 111</td>
			  		<td> Works</td>
			  		<td><%=nfc.convert(Works/100000)%> (<%=nfc.convert(FEWorks/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td><%=nfc.convert(Works/100000)%> (<%=nfc.convert(FEWorks/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td colspan="2" class="border_black weight_700 right"> Total (Revenue)</td>
			  	    <td><%=nfc.convert((transportation + Equipment + CARS + CAPSI + Consultancy + TechnicalServices + ProjectVehicles + Miscellaneous + Works)/100000)%> 
			  	    (<%=nfc.convert((FEtransportation + FEEquipment + FECARS + FECAPSI + FEConsultancy + FETechnicalServices + FEProjectVehicles + FEMiscellaneous + FEWorks)/100000)%>)</td>	
			  		<td>0.00</td>
			  		<td><%=nfc.convert((transportation + Equipment + CARS + CAPSI + Consultancy + TechnicalServices + ProjectVehicles + Miscellaneous + Works)/100000)%> 
			  		(<%=nfc.convert((FEtransportation + FEEquipment + FECARS + FECAPSI + FEConsultancy + FETechnicalServices + FEProjectVehicles + FEMiscellaneous + FEWorks)/100000)%>)</td>
			  	</tr>
			  	<tr>
			 	 	<td rowspan="3"> 052 <br>(Code Head - <br>929/24)*** </td>
			  		<td> Plant & Machinery </td>
			  		<td rowspan="2"> <%=nfc.convert((PlantMachinery + ProjectrelatedVehicles)/100000) %> (<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles)/100000) %>)</td>
			  		<td rowspan="2">0.00</td>
			  		<td rowspan="2"> <%=nfc.convert((PlantMachinery + ProjectrelatedVehicles)/100000) %> (<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles)/100000) %>)</td>
			  	</tr>
			  	<tr>
			  		<td> Project related Vehicles </td>
			  		
			  	</tr>
			  	<tr>
			  		<td> Works </td>
			  		<td> <%=nfc.convert(Works/100000) %> (<%=nfc.convert(FEWorks/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td> <%=nfc.convert(Works/100000) %> (<%=nfc.convert(FEWorks/100000)%>)</td>
			  	</tr>
			  	
			  	
			  	
			  	<tr>
			  		<td colspan="2" class="border_black weight_700 right"> Total (Capital)</td>
			  		<td><%=nfc.convert((PlantMachinery + ProjectrelatedVehicles+Works)/100000)%> (<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td>
			  		<td>0.00</td>
			  		<td><%=nfc.convert((PlantMachinery + ProjectrelatedVehicles+Works)/100000)%> (<%=nfc.convert((FEPlantMachinery + FEProjectrelatedVehicles + FEWorks)/100000)%>)</td>
			  	</tr>
			  	<tr>
			  		<td colspan="2" class="border_black weight_700 right"> Grand Total (Revenue & Capital)</td>
			  		<td> <%=nfc.convert(grandtotal/100000)%>   (<%=nfc.convert((FEtransportation + FEEquipment + FECARS + FECAPSI + FEConsultancy + FETechnicalServices + FEProjectVehicles + FEMiscellaneous + FEWorks+ FEPlantMachinery + FEProjectrelatedVehicles)/100000)%>)</td>
			  		<td> 0.00</td>
			  		<td> <%=nfc.convert(grandtotal/100000)%></td>
			  	</tr>
		  </tbody>
  
 </table>
  <h1 class="break"></h1>
  <%}%>
 
 
  <!-- Project Schedule -->
  
<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
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

	<table  class="executive editor-text-font" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px;  ">
		<tr>
		<th colspan="1" class="border_black weight_700 center grey" style=";width:7%"><span >SN</span></th>
		<th colspan="5" class="border_black weight_700 center grey" style=";width:80%"><span >Milestone Activity</span></th>
		<th colspan="2" class="border_black weight_700 center grey" ><span >Time(Months)</span></th>
		</tr> 
		<%
		int count=1;
		for(Object[] obj : ScheduleList){ %> 
		<tr>
		<td colspan="1" class="border_black weight_700 center" style=";width:7%"><span ><%=count %>.</span></td>
		<td colspan="5" class="border_black weight_700 left" style="padding-left:5px" ><span ><%=obj[1] %></span></td>
		<td colspan="2" class="border_black weight_700 center" ><span ><%=obj[2]%></span></td>
		</tr> 
<%
count++;
} %>

</table>
	
<%}else{ %>	


<table  class="executive" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:820px; font-size: 22px; ">

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
 
<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;" class="heading heading-color">Realization Plan </th>
		</tr>
		<tr>
		<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
		</tr>
	</tbody>
</table>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:920px; font-size: 22px; ">
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


 <h1 class="break"></h1>
 

  <!-- Thank You Page -->
  
<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
	<tbody>
		
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size: 55px" class="heading-color"><br><br><br><br>THANK YOU<br><br><br></th>
		</tr>
		
	</tbody>
</table>


</body>
</html>