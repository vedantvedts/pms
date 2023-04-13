<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
    
<!DOCTYPE html>
<html>
<head>
<%String isprint = (String)request.getAttribute("isprint");
 %>

<meta charset="ISO-8859-1">
<title>PMS Print</title>
<%if(isprint==null || !isprint.equalsIgnoreCase("1")){ %>
<jsp:include page="../static/dependancy.jsp"></jsp:include> 
<%} %>

<meta charset="ISO-8859-1">
<title>Executive Summary</title>
<%

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf2=new SimpleDateFormat("MMMM yyyy");
NFormatConvertion nfc=new NFormatConvertion();

Object[] LabList=(Object[])request.getAttribute("LabList");
Object[] PfmsInitiation=(Object[])request.getAttribute("PfmsInitiationList");
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
List<Object[]> CostDetailsList=(List<Object[]>)request.getAttribute("CostDetailsList");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
String lablogo=(String)request.getAttribute("lablogo");
List<Object[]>headofaccountsList=(List<Object[]>)request.getAttribute("headofaccountsList");
String projecttypeid=(String)request.getAttribute("projecttypeid");
%>
<style>



.break
	{
		page-break-after: always;
		
	} 

.border_black
{
	border : 1px solid black;
	padding : 10px 5px;
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


#pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
.bold{
	font-weight: 800 !important;
}

 @page  {             
          size: 790px 1120px;
          margin-top: 49px;
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black; 
          
          @bottom-left {          		
             content: "<%=LabList[1]%>";
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
             
                    
           @bottom-right  {
            content: "Page " counter(page) " of " counter(pages);
            margin-bottom: 30px;
          }
           @top-right {
             content: "Proposed Project: <%= PfmsInitiation[4] %>";
             margin-top: 30px;
             font-size: 13px;
          }
          
          @top-center {
             content: "<%= PfmsInitiation[3] %>";
             margin-top: 30px;
             font-size: 13px;
          }
          
          
          @top-left {
          	margin-top: 30px;
            content: "Executive Summary";
            font-size: 13px;
          }               
          
 }
 
.editor-text span,p,h1,h2,h3,h4,h5,h6{
	font-size: 17px !important;
	font-family: 'Times New Roman', Times, serif !important;
}
          
.heading-color{
	color: #145374;
}

.editor-text table{
	width:  595px !important;
}

.editor-text span,p{
	font-weight: 500 !important;
}

.editor-text {
	font-size: 17px !important;
	font-family: 'Times New Roman', Times, serif !important;

}



.main-text{
	padding-right: 15px !important
}

.editor-text-font td{
	font-size : 17px !important;
	padding: 2px 4px !important;
}



</style>
  


</head>
<body >


<div  align="center" >

<%if(isprint==null || !isprint.equalsIgnoreCase("1")){ %>
	<div id="PrintButtons" align="center"  >
		<form action="ExecutiveSummaryDownload.htm" method="post" target="_blank"  >
			<input type="hidden" name="htmlstring" value="" id="htmlstring"  > 
			<br>
			<button type="submit" class="btn btn-sm prints" id="pdfdown" style="">
			<i class="fa fa-file-text-o" aria-hidden="true" style="color: white" ></i> &nbsp; Generate PDF</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="IntiationId" value="<%=PfmsInitiation[0] %>" id="htmlstring"  > 
		</form> 
	</div>
<%} %>

<div id="PrintContainer">
	
	<div class="firstpage" id="firstpage"> 
		
		
		<div align="center" ><h1 style="font-size:30px !important;" class="heading-color"><br>Executive Summary</h1></div>
		
		<!-- <div align="center" ><h1>on</h1></div> -->
		
		<%if ( PfmsInitiation != null){ %>
			<br>
			<div align="center" ><h2 style="font-size:22px !important;"><%if(PfmsInitiation[5]!=null){%><%=PfmsInitiation[5] %><%}else{ %> - <%} %></h2></div>
			<div align="center" ><h2 style="font-size:22px !important;"><%if(PfmsInitiation[4]!=null){%>(<%=PfmsInitiation[4] %>)<%}else{ %> - <%} %></h2></div>
			<br>
			<div align="center" ><h2 style="font-size:22px !important;"><%if(PfmsInitiation[10]!=null){%> <%=sdf2.format(PfmsInitiation[10])%><%}else{ %>Month Year<%} %></h2></div>
		<%} %>	
		
		<div align="center" >
		
			<table style="align: center;margin-left:90px !important;  font-size: 16px" >
			<%
			if(LabList!=null){
			 %>

				<tr>		
				<th colspan="8" style="text-align: center; font-weight: 700;">
					<br><br><br><br><br><br><br><br><br><br><br>
						<img class	="logo" style="width:100px;height: 100px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt=	Configurat	on"<%}else	{ %> alt="File Not Found" <%} %> >
					</th>
				</tr>
				<tr>
					<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px;padding-top: 50px;"></th>
				</tr>
				<tr>
					<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><br><br><br><br><%if(LabList[1]!=null){ %><%=LabList[1] %><%}else{ %>LAB NAME<%} %></th>
				</tr>


				
			
			
			<tr>
				<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><br>Government of India, Ministry of Defence</th>
			</tr>
			<tr>
				<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
			</tr>
			<tr>
				<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(LabList[2]!=null){ %><%=LabList[2] %><%}else{ %>LAB NAME<%} %></th>
			</tr> 

				<% } %>


			</table>			 
		
		</div>
		
	</div>
	<h1 class="break secondpage"></h1> 
	<div class="secondpage" >
		
			<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse:collapse;" >
			<tr>
				<th colspan="8" style="text-align: center;font-size:22px;">Executive Summary (ES) </th>
			</tr>
		
			<%if ( PfmsInitiation !=null)
			{ 
				Object[] obj = PfmsInitiation; %>
				
			 <tr>
				<th  class="border_black 700 center" style="width:5%" ><span >SN</span></th>
				<th  class="border_black 700 left" ><span >Content</span></th>
				</tr> 
				
				<tr>
					<th  class="border_black normal center" ><span >1.</span></th>
					<td class="border_black normal left" >
						<span class="bold">Title of the Project / Name of the project</span>
						<span ><%if(obj[5]!=null){ %> - <%=obj[5] %><%}else{ %><i></i><%} %></span>
					</td>
				</tr> 
				
					
				<tr>
					<th rowspan="3"  class="border_black normal center" style="vertical-align:top;"><span >2.</span></th>
					<td class="border_black normal left" >
						<span class="bold" >Name of the Main project</span>
						<span > <%if(obj[12].toString().equalsIgnoreCase("N")){ %> - <%=obj[13]%><%} else{ %> <i>- <%=obj[5]  %></i> <%} %></span>
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
						<span ><%if(obj[3]!=null){ %> - <%=obj[3] %><%}else{ %><i></i><%} %></span>
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
						<span ><%if(obj[7]!=null){ %> - <%=obj[7] %> Months<%}else{ %><i></i><%} %></span>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >6.</span></th>
					<td class="border_black normal left" >
						<span class="bold">Whether Plan/Non Plan Project</span>
						<span ><%if(obj[8]!=null){ if(obj[8].toString().equalsIgnoreCase("P")){%> - Plan <%}if(obj[8].toString().equalsIgnoreCase("N")){ %> - Non-Plan - <%if(obj[14]!=null){ %> (Remarks : <%=obj[14]%> ) <%}else{ %> Nil <%} %> <%}}else{ %><%} %></span>
					</td>
				</tr>
				
				<%} %>
				
				<tr>
					<th  class="border_black normal center" ><span >7.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold" ><u>Need of the Project</u> :</span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span  style="font-size:15px; max-width:200px; word-wrap:break-word;"><%if(obj[19]!=null){ %><%=obj[19] %><%}else{ %><i>-</i><%} %></span>
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
							<span  style="font-size:15px;" ><%if(obj[13]!=null){ %><%=obj[13] %><%}else{ %><i>-</i><%} %></span>
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
							<span style="font-size:15px;" ><%if(obj[24]!=null){ %><%=obj[24] %><%}else{ %><i>-</i><%} %></span>
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
							<span style="font-size:15px;" ><%if(obj[14]!=null){ %><%=obj[14] %><%}else{ %><i>-</i><%} %></span>
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
							<span style="font-size:15px;" ><%if(obj[15]!=null){ %><%=obj[15] %><%}else{ %><i>-</i><%} %></span>
					<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>
				
				<%if(PfmsInitiation!= null) { Object[] obj = PfmsInitiation; %>
				
				<tr>
					<th  class="border_black normal center" ><span >12.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Deliverables/Output</u> : </span>
						<span style="font-size:15px;" ><%if(obj[11]!=null){ %> <br><%=obj[11] %><%}else{ %><i>-</i><%} %></span>
					</td>
				</tr>
				
				<%} %>
				
				<tr>
					<th  class="border_black normal center" ><span >13.</span></th>
					<td class="border_black normal left" >
						<span class="bold"><u>Participating Labs with Work share</u> : </span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span style="font-size:15px;"" ><%if(obj[16]!=null){ %><%=obj[16] %><%}else{ %><i>-</i><%} %></span>
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
							<span style="font-size:15px;" ><%if(obj[17]!=null){ %><%=obj[17] %><%}else{ %><i>-</i><%} %></span>
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
							<span style="font-size:15px;" ><%if(obj[18]!=null){ %><%=obj[18] %><%}else{ %><i>-</i><%} %></span>
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
							<span style="font-size:15px;" ><%if(obj[20]!=null){ %><%=obj[20] %><%}else{ %><i>-</i><%} %></span>
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
							<span style="font-size:15px;" ><%if(obj[21]!=null){ %><%=obj[21] %><%}else{ %><i>-</i><%} %></span>
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
							<span style="font-size:15px;" ><%if(obj[22]!=null){ %><%=obj[22] %><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>

				<tr>
					<th  class="border_black normal center" ><span >19.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Cost estimate/Break-up</u> : </span>
						<span style="font-size:15px;" >  Attached as Annexure - A</span>
					</td>
				</tr>
				
				<tr>
					<th  class="border_black normal center" ><span >20.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Major milestone/Project schedule</u> :</span>
						<span style="font-size:15px;" >  Attached as Annexure - B</span>
					</td>
				</tr>
				 
				<tr>
					<th  class="border_black normal center" ><span >21.</span></th>
					<td class="border_black normal left main-text" >
						<span class="bold"><u>Realization Plan</u> :</span>
						<%if(!DetailsList.isEmpty()){%>
						<%for (Object[] obj : DetailsList){ %>
							<span class="editor-text" ><%if(obj[23]!=null){ %><%=obj[23] %><%}else{ %><i>-</i><%} %></span>
						<%}}else{ %>
						<span><i>-</i></span>
						<%} %>
					</td>
				</tr>

			</table>
	
	

			
			
			<h1 class="break"></h1> 
		
		<br>
		<div align="center" style="font-size: 20px"><b>Annexure - A </b></div>
<table class="editor-text-font" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 10px; width: 650px; border-collapse:collapse;font-size: 17px !important" >
			
			
			<tr>
				<td colspan="1" class="border_black  center" style=";width:7%;font-weight: 600"><span >SN</span></td>
			<!-- 	<td colspan="2" class="border_black  center" style="font-weight: 600;width:20%;"><span >Head Code</span></td> -->
				<td colspan="5" class="border_black  center" style=";width:50%;font-weight: 600" ><span >Budget Item</span></td>
				<td colspan="2" class="border_black  center" style=";width:25%;font-weight: 600"><span >Item Cost (Lakhs)</span></td>
			
			</tr>
			
			<%
			if(!CostDetailsList.isEmpty()){
			
			int count=1;
			for (Object[] obj: CostDetailsList) {%>
			 
			<tr>
			<td colspan="1" class="border_black  center" style=";width:7%"><span ><%=count %>. </span></td>
		<%-- 	<td colspan="2" class="border_black  left" ><span ><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %> - <%} %></span></td> --%>
			<td colspan="5" class="border_black  left" ><span ><%if(obj[0]!=null){ %><%=obj[0]+"("+obj[5]+")"+"("+obj[1]+")" %><%}else{ %> - <%} %></span></td>
			<td colspan="2" class="border_black right"  ><span ><%if(obj[3]!=null && Double.parseDouble(obj[3].toString()) >0){ %>&#8377; <span><%=nfc.convert(Double.parseDouble(obj[3].toString())/100000)%></span> <%}else{ %> - <%} %></span></td>
			</tr> 
			
			<%
			count++;} %>
			
			<%if(PfmsInitiation!= null) { Object[] obj = PfmsInitiation; %>
			
		    <tr>
				<td colspan="12" class="border_black weight_700 right"  ><span ><%if(obj[6]!=null && Double.parseDouble(obj[6].toString()) >0 ){ %>Total Cost : &#8377; <span><%=nfc.convert(Double.parseDouble(obj[6].toString())/100000)%></span> <%}else{ %>  <%} %> Lakhs</span></td>
			</tr>
			
			<%} }else{%>
		
			<tr>
				<th colspan="12" class="border_black 700 center" ><span >No Data Available</span></th>
			</tr> 
			
		
			<%} %>
			
		</table> 
		<br><h1 class="break"></h1> 
		<br>	
		<div align="center" style="font-size: 20px"><b>Annexure -B </b></div>
		<table class="editor-text-font" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 10px; width: 650px; font-size: 17px; border-collapse:collapse;" >
			
			<tr>
			<td colspan="1" class="border_black  left" style=";width:10%;font-weight: 600"><span >Mil No</span></td>
			<td colspan="5" class="border_black  center" style=";width:30%;font-weight: 600" ><span >Milestone Activity</span></td>
			<td colspan="4" class="border_black  center" style="font-weight: 600"><span >Milestone TotalMonth</span></td>
		<!-- 	<td colspan="1" class="border_black  center" style="font-weight: 600"><span >Mil Month</span></td> -->
			<td colspan="2" class="border_black  center" style="font-weight: 600"><span >Milestone Remarks</span></td>
			</tr>
			
			<%
			if(!ScheduleList.isEmpty()){
			
			for (Object[] obj: ScheduleList) {%>
			 
			<tr>
			<td colspan="1" class="border_black  center" ><span ><%if(obj[0]!=null){ %><%=obj[0] %><%}else{ %> - <%} %></span></td>
			<td colspan="5" class="border_black  left" ><span ><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %> - <%} %></span></td>
<!-- 			<td colspan="1" class="border_black  left" ><span ></span></td> -->
			<td colspan="4" class="border_black center" ><span ><%if(obj[5]!=null && obj[2]!=null){ %><%= "T"%><sub><%=obj[5] %></sub><%="+"%><%=obj[2]%><%}else{ %> - <%} %>
			
			</span></td>
			<td colspan="2" class="border_black  left" ><span ><%if(obj[4]!=null){ %><%=obj[4] %><%}else{ %> - <%} %></span></td>
			</tr> 
			
			<%
			} }%>
			
						<%if(PfmsInitiation!= null) { Object[] obj = PfmsInitiation; %>
			
			<tr style="  font-weight: bold;">
				<td colspan="12" class="border_black right"  ><%if(obj[7]!=null && Integer.parseInt(obj[7].toString()) >0 ){ %><span ><b>Total Duration : <%=obj[7]+"Months" %></b></span><%}%></td>
			</tr>
			
			<%}else{%>
			
				<tr>
					<th colspan="12" class="border_black 700 center" ><span >No Data Available</span></th>
				</tr> 
			
			
			<%} %>
			</table> 


	</div>

</div>
</div>

</body>



</html>