<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.net.Inet4Address"%>
<%@page import="com.vts.pfms.Zipper"%>
<%@page import="java.math.MathContext"%>
<%@page import="com.vts.pfms.model.TotalDemand"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="com.vts.pfms.committee.model.Committee"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="com.vts.pfms.print.model.TechImages"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="com.vts.pfms.AESCryptor"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="java.io.File"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.text.Format"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
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

String InitiationId=(String)request.getAttribute("InitiationId");

%>
<style>
  .break {
    page-break-before: always;
      }
     

	     
     @page {
       size: 1120px 790px; 
      /*     margin-top: 49px; */
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black; 
          padding-top: 15px;
          padding-left:10px;
		  padding-right:10px;       
       @bottom-left {          		
             content: "<%=LabList[1]!=null?StringEscapeUtils.escapeHtml4(LabList[1].toString()): " - "%>";
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
        }
        
        @bottom-right {
	            content: "Page " counter(page) " of " counter(pages);
	            margin-bottom: 30px;
		}
		
		@top-right {
             content: "Proposed Project: <%=PfmsInitiationList[4]!=null?StringEscapeUtils.escapeHtml4(PfmsInitiationList[4].toString()): " - " %>";
             margin-top: 30px;
             font-size: 13px;
         }
         
        @top-left {
             content: "<%=PfmsInitiationList[3]!=null?StringEscapeUtils.escapeHtml4(PfmsInitiationList[3].toString()): " - " %>";
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

#headername{
color:white;
}

p{
text-align: justify;
padding:20px;
padding-top: 5px !important;
}
</style>

</head>
<body style="background-color:#FBFCFC">

	<div class="firstpage"  > 

						<div align="center" ><h2 style="color: #145374 !important;font-family: 'Muli'!important">Presentation for<%if(PfmsInitiationList[5]!=null){ %><br><%=StringEscapeUtils.escapeHtml4(PfmsInitiationList[5].toString()) %><%}else{ %><i>Project Title</i><%} %></h2></div>
					     <div align="center" ><h3 style="color: #4C9100 !important"><%if(PfmsInitiationList[4]!=null){ %>(<%=StringEscapeUtils.escapeHtml4(PfmsInitiationList[4].toString()) %>)<%}else{ %><i> - </i><%} %></h3></div>	
					     <div align="center" ><h3 style="color: #145374 !important"><%if(PfmsInitiationList[10]!=null){%> <%=sdf2.format(PfmsInitiationList[10])%><%}else{ %>-<%} %></h3></div>
					    <br><br><br><br>
					     <div align="center" ><h3 style="color: #145374 !important"><img class="logo" style="width:120px;height: 120px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> ></h3></div>
						<br><br>
						<br>
						<div align="center"><h4 style="color: #145374 !important"><%if(LabList[1]!=null){ %><%=StringEscapeUtils.escapeHtml4(LabList[1].toString()) %><%}else{ %>-<%} %></h4></div>
						<div align="center"><h5 style="color: #145374 !important" >Government of India, Ministry of Defence</h5></div>
						<div align="center"><h5 style="color: #145374 !important" >Defence Research & Development Organization</h5></div>
						<div align="center"><h5 style="color: #145374 !important" ><%if(LabList[2]!=null){ %><%=StringEscapeUtils.escapeHtml4(LabList[2].toString()) %><%}else{ %> - <%} %></h5></div>
						</div>


<h1 class="break"></h1>

	
			<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Brief of Proposed Project</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
</table>
	<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 30px; width: 90%; font-size: 16px; border-collapse:collapse;" >
	
			<%if ( PfmsInitiationList !=null)
			{ 
				Object[] obj = PfmsInitiationList; %>
				
			 <tr>
				<th  class="border_black 700 center" style="width:10%" ><span >SN</span></th>
				<th  class="border_black 700 left" style="text-align: center;"><span >Content</span></th>
				</tr> 
				
				<tr>
					<th  class="border_black normal center" ><span >1.</span></th>
					<td class="border_black normal left" >
						<span class="bold">Title of the Project / Name of the project</span>
						<span style="color:#309322;"><%if(obj[5]!=null){ %><b> - <%=StringEscapeUtils.escapeHtml4(obj[5].toString()) %><%}else{ %><i></i><%} %></b></span>
					</td>
				</tr> 
				
					
				<tr>
					<th rowspan="3"  class="border_black normal center" style="vertical-align:top;"><span >2.</span></th>
					<td class="border_black normal left" >
						<span class="bold" >Name of the Main project</span>
						<span style="color:#309322;"> <%if(obj[12].toString().equalsIgnoreCase("N")){ %> - <%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()): " - "%><%} else{ %> <i> - NA </i> <%} %></span>
					</td>
				</tr> 
				
				<tr>
					<td class="border_black normal left" >
						<span class="bold">Main Project Sanction Date</span>
						<span ><%if(obj[12].toString().equalsIgnoreCase("N")){ %> - To Be Obtained<%} else{ %> <i> - NA </i> <%} %></span>
					</td>
				</tr>
				
				<tr>
					<td class="border_black normal left" >
						<span class="bold" >Main Project PDC</span>
						<span  ><%if(obj[12].toString().equalsIgnoreCase("N")){ %> - To Be Obtained<%} else{ %> <i> - NA </i> <%} %></span>
					</td>
				</tr>
			
				
				<tr>
					<th  class="border_black normal center" ><span >3.</span></th>
					<td class="border_black normal left" >
						<span class="bold">Security Classification</span>
						<span ><%if(obj[3]!=null){ %> - <%=StringEscapeUtils.escapeHtml4(obj[3].toString()) %><%}else{ %><i></i><%} %></span>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >4.</span></th>
					<td class="border_black normal left" >
						<span class="bold">Cost </span>
						<span class="editor-text" style=" font-family: 'Times New Roman', Times, serif; font-size: 15px !important" >
						<%if(obj[6]!=null){%>
										  - &#8377;  <span><%=nfc.convert(Double.parseDouble(obj[6].toString())/100000)%></span>  Lakhs<%}else{ %><i></i><%} %></span>
					</td>
				</tr>
			
				<tr>
					<th  class="border_black normal center" ><span >5.</span></th>
					<td class="border_black normal left" >
						<span class="bold">PDC </span>
						<span ><%if(obj[7]!=null){ %> - <%=StringEscapeUtils.escapeHtml4(obj[7].toString()) %> Months<%}else{ %><i></i><%} %></span>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >6.</span></th>
					<td class="border_black normal left" >
						<span class="bold">Whether Plan/Non Plan Project</span>
						<span ><%if(obj[8]!=null){ if(obj[8].toString().equalsIgnoreCase("P")){%> - Plan <%}if(obj[8].toString().equalsIgnoreCase("N")){ %> - Non-Plan - <%if(obj[14]!=null){ %> (Remarks : <%=StringEscapeUtils.escapeHtml4(obj[14].toString())%> ) <%}else{ %> Nil <%} %> <%}}else{ %><%} %></span>
					</td>
				</tr>
				
				<%} %>
				
				<tr>
					<th  class="border_black normal center" ><span >7.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold" ><u>Need of the Project</u> :</span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span  style="font-size:15px; max-width:200px; word-wrap:break-word;"><%if(obj[19]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[19].toString()) %><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >8.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Requirements</u> : </span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span  style="font-size:15px;" ><%if(obj[13]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[13].toString()) %><%}else{ %><i>-</i><%} %></span>
					<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >9.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>World Scenario</u> :</span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;" ><%if(obj[24]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[24].toString()) %><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >10.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Objective</u> : </span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;" ><%if(obj[14]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[14].toString()) %><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >11.</span></th>
					<td class="border_black normal left main-text"  >
						<span class="bold"><u>Scope</u> :</span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;" ><%if(obj[15]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[15].toString()) %><%}else{ %><i>-</i><%} %></span>
					<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				<%if(PfmsInitiationList!= null) { Object[] obj = PfmsInitiationList; %>
				
				<tr>
					<th  class="border_black normal center" ><span >12.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Deliverables/Output</u> : </span>
						<span style="font-size:15px;" ><%if(obj[11]!=null){ %> <br><%=StringEscapeUtils.escapeHtml4(obj[11].toString())%><%}else{ %><i>-</i><%} %></span>
					</td>
				</tr>
				
				<%} %>
				
				<tr>
					<th  class="border_black normal center" ><span >13.</span></th>
					<td class="border_black normal left" >
						<span class="bold"><u>Participating Labs with Work share</u> : </span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;"" ><%if(obj[16]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[16].toString()) %><%}else{ %><i>-</i><%} %></span>
					<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>

				<tr>
					<th  class="border_black normal center" ><span >14.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Brief of earlier work done</u> : </span>
							<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;" ><%if(obj[17]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[17].toString()) %><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >15.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Competency Established</u> : </span>
							<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;" ><%if(obj[18]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[18].toString())%><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				
				<tr>
					<th  class="border_black normal center" ><span >16.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Technology Challenges/Issues foreseen</u> : </span>
							<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;" ><%if(obj[20]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[20].toString()) %><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >17.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Risk involved and Mitigation Plan</u> : </span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;" ><%if(obj[21]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[21].toString()) %><%}else{ %><i>-</i><%} %></span>
					<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >18.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Proposal</u> : </span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;" ><%if(obj[22]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[22].toString()) %><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				 
				<tr>
					<th  class="border_black normal center" ><span >19</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Realization Plan</u> :</span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span class="editor-text" ><%if(obj[23]!=null){ %><%=StringEscapeUtils.escapeHtml4(obj[23].toString()) %><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>

			</table>
<h1 class="break"></h1>

			<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
	<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Need of the Project</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
</table>
				<div class="content" align="center" style="border:1px solid black;margin-top: 5px;" >
		
			
				<%
							if (!DetailsList.isEmpty()) {

								for (Object[] obj : DetailsList) {
							if(obj[6]!=null){%>
							<%=StringEscapeUtils.escapeHtml4(obj[6].toString())%>
							<%}else{ %>
							 <br><br><br>
						  <br><br><br>
						   <br><br><br>
							To be filled
							<%} %>
			
			<%}} %>
		
				</div>
				<h1 class="break"></h1>

			<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
				<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">World Scenario</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
			<div class="content" align="center" style="border:1px solid black;margin-top: 5px;">
	
							<%
							if (!DetailsList.isEmpty()) {

								for (Object[] obj : DetailsList) {
									if (obj[12] != null) {
							%>
							<%=StringEscapeUtils.escapeHtml4(obj[12].toString())%>
							<%
							} else {
							%>
							 <br><br><br>
						  <br><br><br>
						   <br><br><br>
							To be filled
							<%
							}
							%>

							<%
							}
							}
							%>
					
				</div>
<h1 class="break"></h1>
			<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
				<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Objective</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
		<div class="content" align="center" style="border:1px solid black;margin-top: 5px;">
	
							<%
							if (!DetailsList.isEmpty()) {

								for (Object[] obj : DetailsList) {
									if (obj[1] != null) {
							%>
							<%=StringEscapeUtils.escapeHtml4(obj[1].toString())%>
							<%
							} else {
							%>
							 <br><br><br>
						  <br><br><br>
						   <br><br><br>
							To be filled
							<%
							}
							%>

							<%
							}
							}
							%>
					
				</div>
<h1 class="break"></h1>
			<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
				<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Scope</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
			<div class="content" align="center" style="border:1px solid black;margin-top: 5px;">
	
							<%
							if (!DetailsList.isEmpty()) {

								for (Object[] obj : DetailsList) {
									if (obj[2] != null) {
							%>
							<%=StringEscapeUtils.escapeHtml4(obj[2].toString())%>
							<%
							} else {
							%>
							 <br><br><br>
						  <br><br><br>
						   <br><br><br>
							To be filled
							<%
							}
							%>

							<%
							}
							}
							%>
					
				</div>
<h1 class="break"></h1>
			<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
				<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Deliverables</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
				<div class="content" align="center" style="border:1px solid black;margin-top: 5px;">
	
					 <%if(PfmsInitiationList!=null){%>
						 <%if(PfmsInitiationList[11]!=null){  %>
						  <br><br><br>
						  <br><br><br>
						   <br><br><br>
						 <span style="font-size: 20px;"><%=StringEscapeUtils.escapeHtml4(PfmsInitiationList[11].toString())%></span>
						 <%} else{%>
						
						 <span style="font-size: 20px;"><i> To be filled</i></span>
						 <%} %>
						 <%} %>
					
				</div>
	<h1 class="break"></h1>
			<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
				<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Brief of Earlier Work Done</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
		<div class="content" align="center" style="border:1px solid black;margin-top: 5px;">
	
					
							<%
							if (!DetailsList.isEmpty()) {

								for (Object[] obj : DetailsList) {
									if (obj[4] != null) {
							%>
							<%=StringEscapeUtils.escapeHtml4(obj[4].toString())%>
							<%
							} else {
							%>
							To be filled
							<%
							}
							%>

							<%
							}
							}
							%>
					
				</div>
				<h1 class="break"></h1>
							<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
				<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Competency Established</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
			<div class="content" align="center" style="border:1px solid black;margin-top: 5px;">
	
					
							<%
							if (!DetailsList.isEmpty()) {

								for (Object[] obj : DetailsList) {
									if (obj[5] != null) {
							%>
							<%=StringEscapeUtils.escapeHtml4(obj[5].toString())%>
							<%
							} else {
							%>
							To be filled
							<%
							}
							%>

							<%
							}
							}
							%>
					
				</div>
								<h1 class="break"></h1>
							<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
				<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Risk Mitigation</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
				<div class="content" align="center" style="border:1px solid black;margin-top: 5px;">
	
					
							<%
							if (!DetailsList.isEmpty()) {

								for (Object[] obj : DetailsList) {
									if (obj[8] != null) {
							%>
							<%=StringEscapeUtils.escapeHtml4(obj[8].toString())%>
							<%
							} else {
							%>
							To be filled
							<%
							}
							%>

							<%
							}
							}
							%>
					
				</div>
		<h1 class="break"></h1>
							<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
				<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Proposal</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
				<div class="content" align="center" style="border:1px solid black;margin-top: 5px;">
	
					
							<%
							if (!DetailsList.isEmpty()) {

								for (Object[] obj : DetailsList) {
									if (obj[9] != null) {
							%>
							<%=StringEscapeUtils.escapeHtml4(obj[9].toString())%>
							<%
							} else {
							%>
							To be filled
							<%
							}
							%>

							<%
							}
							}
							%>
					
				</div>
				
		<h1 class="break"></h1>
		<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
		<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Cost Breakup as per proposal</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
				

	
					
				
					<%
					if (!CostDetailsList.isEmpty()) {
					%>

<table  class="executive editor-text-font" style="margin-right:2px;margin-top:5px; margin-bottom: 10px;margin-left: 15px;width:97%;;border-collapse: collapse; ">
	<tbody>
	<tr style="background: #629ed1;color:white;">
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
		<td colspan="2" class="border_black weight_700 right" style="padding-right:5px;color: maroon;" ><span >&#8377; <span><%=nfc.convert(Double.parseDouble(obj[3].toString())/100000)%></span></span></td>
	</tr> 
	</tbody>
	<%
	count++;
	} %>
			
			<%if(PfmsInitiationList!= null) { Object[] obj = PfmsInitiationList; %>
			
			<tr style="background: #C56824;">
				<td colspan="12" class="border_black weight_700 right"  ><span ><%if(obj[6]!=null && Double.parseDouble(obj[6].toString()) >0 ){ %>Total Cost : &#8377; <span><%=nfc.convert(Double.parseDouble(obj[6].toString())/100000)%></span> <%}else{ %>  <%} %> Lakhs</span></td>
			</tr>
			<%} %>
</table>
					<%
					} else {
					%>
			
   <table  class="executive editor-text-font" style="margin-top:5px; margin-bottom: 10px;margin-left: 12px; margin-right: 2px;width:97%;  ">

<tr style="background:#629ed1;color: white; ">
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
		<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
		<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Project Schedule/Timelines</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
	</tbody>
	</table>				
	<%if(!ScheduleList.isEmpty()){ %>

	<table  class="executive editor-text-font" style="margin-top:10px; margin-bottom: 10px;margin-left: 3px;width:97%;  ">
		<tr style="background:#629ed1;color: white; ">
		<th colspan="1" class="" style=";width:7%"><span >SN</span></th>
		<th colspan="3" class="" style=";width:50%"><span >Milestone Activity</span></th>
		<td colspan="4" class="" style="font-weight: 600 ; text-align: center; "><span >Milestone TotalMonth</span></td>
		<th colspan="2" class="" ><span >Milestone Remarks</span></th>
		</tr> 
		<%
		int count=1;
		for(Object[] obj : ScheduleList){ %> 
		<tr>
		<td colspan="1" style=";width:7%;text-align: center;"><span ><%=count %>.</span></td>
		<td colspan="3" style="padding-left:5px" ><span ><%=obj[1] %></span></td>
		<td colspan="4" style="font-weight: 600;color: maroon;text-align: center;"><%if(obj[5]!=null && obj[2]!=null){ %><%= "T"%><sub><%=obj[5] %></sub><%="+"%><%=obj[2]%><%}else{ %> - <%} %></td>
		<td colspan="2"  ><span ><%=obj[4]%></span></td>
		</tr> 
<%
count++;
}
		%>
				<%if(PfmsInitiationList!= null) { Object[] obj = PfmsInitiationList; %>
			
			<tr style="background: #C56824; color:white;">
				<td colspan="12" class="border_black right" style=""  ><span ><b style="background: #C56824;; margin-right:200px;"><%if(obj[7]!=null && Integer.parseInt(obj[7].toString()) >0 ){ %>Total Duration :<%=obj[7]+"Months" %></b ></span><%}%></td>
			</tr>
			<%} %>
</table>
	
<%}else{ %>	


<table  class="executive" style="margin-top:10px; margin-bottom: 10px;margin-left: 3px;width:97%; font-size: 22px; ">

<tr style="background:#629ed1;color: white; ">
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
		<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:95%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ; background: maroon;height:50px;border-radius: 10px;" >
		<tbody>
		<tr>
		<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
			<th colspan="4"  style="text-align:center; color:white;" class="heading heading-color">Realization Plan</th>
			<th colspan="4"  style="text-align:center;"> 
			<img class="logo" style="width:40px;;margin-top:px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
			</th>
		</tr>
		
	</tbody>
	</table>
				<div class="content" align="center" style="border:1px solid black;margin-top: 5px;">
		
			
							<%
							if (!DetailsList.isEmpty()) {

								for (Object[] obj : DetailsList) {
									if (obj[10] != null) {
							%>
							<%=StringEscapeUtils.escapeHtml4(obj[10].toString())%>
							<%
							} else {
							%>
							To be filled
							<%
							}
							%>

							<%
							}
							}
							%>
					
				</div>	
						<h1 class="break"></h1>
				<table  style="margin-top:300px;; margin-bottom: 0px;margin-left: 50%;height:100%; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;width: 100%;" >
	<tbody>
		
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size: 50px" class="heading-color">Thank You!</th>
		</tr>
		
	</tbody>
</table>	
	
</body>
</html>