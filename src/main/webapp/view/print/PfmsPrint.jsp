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
<title>PFMS Print</title>
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

Object[] Labdata=(Object[])request.getAttribute("LabList");
Object[] PfmsInitiation=(Object[])request.getAttribute("PfmsInitiationList");
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
List<Object[]> CostDetailsList=(List<Object[]>)request.getAttribute("CostDetailsList");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
String lablogo=(String)request.getAttribute("lablogo");

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
 


 @page  {             
          size: 790px 1120px;
          margin-top: 49px;
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black; 
          
          @bottom-left {          		
             content: "DRDO";
             margin-bottom: 30px;
             margin-right: 10px;
          }
             
                    
           @bottom-right  {
           	  		
            content: "Page " counter(page) " of " counter(pages);
            margin-bottom: 30px;
            margin-right: 10px;
          }
           @top-right {
             content: "Proposed Project: <%= PfmsInitiation[4] %>";
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "Executive Summary";
          }               
          
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
		
		
		<div align="center" ><h1>Executive Summary</h1></div>
		
		<div align="center" ><h1>on</h1></div>
		
		<%if ( PfmsInitiation != null){ %>
			<br>
			<div align="center" ><h2><%if(PfmsInitiation[5]!=null){%><%=PfmsInitiation[5] %><%}else{ %>". . . . . . . ." (Project Title)<%} %></h2></div>
			<br>
			<div align="center" ><h2><%if(PfmsInitiation[10]!=null){%> <%=sdf2.format(PfmsInitiation[10])%><%}else{ %>Month Year<%} %></h2></div>
		<%} %>	
		
		<table style="align: center; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px" >
		<%
		if(Labdata!=null){
		 %>
		
			<tr>			
				<th colspan="8" style="text-align: center; font-weight: 700;">
				<br><br><br><br><br><br><br><br><br><br><br><br>
				<img class="logo" style="width:100px;height: 100px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
				
				</th>
			</tr>
			<tr>
				
				<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px;padding-top: 50px;">(ISO 9001-2015 Certified Establishment)</th>
			</tr>
			<tr>
				<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><br><br><br><br><%if(Labdata[1]!=null){ %><%=Labdata[1] %><%}else{ %>LAB NAME<%} %></th>
			</tr>
			
			<% } %>
		
		
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><br>Government of India, Ministry of Defence</th>
		</tr>
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
		</tr>
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(Labdata[2]!=null){ %><%=Labdata[2] %><%}else{ %>LAB NAME<%} %></th>
		</tr>
		</table>			
		
		
	</div>
	<h1 class="break secondpage"></h1> 
	<div class="secondpage" >

		<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse:collapse;" >
			<tr>
				<th colspan="8" style="text-align: center;font-size:22px">Executive Summary (ES) </th>
			</tr>
		
			<%if ( PfmsInitiation !=null)
			{ 
				Object[] obj = PfmsInitiation; %>
				
				<tr>
				<th colspan="1" class="border_black 700 left" style=";width:7%"><span >SN</span></th>
				<th colspan="2" class="border_black 700 left" style=";width:30%"><span >Content</span></th>
				<th colspan="5" class="border_black 700 left" ><span >Inputs</span></th>
				</tr> 
				
				<tr>
				<th rowspan="3" colspan="1" class="border_black normal center" style="vertical-align:top;width:7%"><span >1.</span></th>
				<th colspan="2" class="border_black normal left" ><span >Name of the Main project</span></th>
				<td colspan="5" class="border_black normal left" ><span > <%if(obj[12].toString().equalsIgnoreCase("N")){ %><%=obj[13]%><%} else{ %> <i> NA </i> <%} %></span></td>
				</tr> 
				
				<tr>
				<th colspan="2" class="border_black normal left" ><span >Main Project Sanction Date</span></th>
				<td colspan="5" class="border_black normal left" ><span ><%if(obj[12].toString().equalsIgnoreCase("N")){ %>To Be Obtained<%} else{ %> <i> NA </i> <%} %></span></td>
				</tr>
				
				<tr>
				
				<th colspan="2" class="border_black normal left" ><span >Main Project PDC</span></th>
				<td colspan="5" class="border_black normal left" ><span ><%if(obj[12].toString().equalsIgnoreCase("N")){ %>To Be Obtained<%} else{ %> <i> NA </i> <%} %></span></td>
				</tr>
				
				<tr>
				<th colspan="1" class="border_black normal center" style=";width:7%"><span >2.</span></th>
				<th colspan="2" class="border_black normal left" ><span >Title of the Project / Name of sub project</span></th>
				<td colspan="5" class="border_black normal left" ><span ><%if(obj[5]!=null){ %><%=obj[5] %><%}else{ %><i></i><%} %></span></td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center" style=";width:7%"><span >3.</span></th>
				<th colspan="2" class="border_black normal left" ><span >Security Classification</span></th>
				<td colspan="5" class="border_black normal left" ><span ><%if(obj[3]!=null){ %><%=obj[3] %><%}else{ %><i></i><%} %></span></td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center" style=";width:7%"><span >4.</span></th>
				<th colspan="2" class="border_black normal left" ><span >Cost (In Lakhs)</span></th>
				
				<td colspan="5" class="border_black normal left" >
					<span >
						<%if(obj[6]!=null){ 
							String split = obj[6].toString().split("\\.")[0]; 
								int length = split.length();
									String value= "0";
										if(length>2){
											Double cost= Double.parseDouble(obj[6].toString())/100000;
											value= cost.toString().substring(0, 3);
													}
										%>&#8377;  <%=value%>  Lakhs<%}else{ %><i></i><%} %></span>
				</td>
				
				</tr> 
				
				<tr>
					<th colspan="1" class="border_black normal center" style=";width:7%"><span >5.</span></th>
					<th colspan="2" class="border_black normal left" ><span >PDC (In Months)</span></th>
					<td colspan="5" class="border_black normal left" ><span ><%if(obj[7]!=null){ %><%=obj[7] %><%}else{ %><i></i><%} %></span></td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center" style=";width:7%"><span >6.</span></th>
				<th colspan="2" class="border_black normal left" ><span >Whether Plan/Non Plan Project</span></th>
				<td colspan="5" class="border_black normal left" ><span ><%if(obj[8]!=null){ if(obj[8].toString().equalsIgnoreCase("P")){%> Plan <%}if(obj[8].toString().equalsIgnoreCase("N")){ %>Non-Plan -> <%if(obj[14]!=null){ %> <%=obj[14]%> <%}else{ %> No  Remarks <%} %> <%}}else{ %><%} %></span></td>
				</tr> 
				
				<%} %>
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >7.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Requirements</span></th>
				<td colspan="5" class="border_black normal left" >
					<%for (Object[] obj : DetailsList){ %>
						<span ><%if(obj[0]!=null){ %><%=obj[0] %><%}else{ %><i></i><%} %></span>
					<%} %>	
				</td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >8.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Objective</span></th>
				<td colspan="5" class="border_black normal left" >
					<%for (Object[] obj : DetailsList){ %>
						<span ><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %><i></i><%} %></span>
					<%} %>
				</td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >9.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Scope</span></th>
				<td colspan="5" class="border_black normal left" >
					<%for (Object[] obj : DetailsList){ %>
						<span ><%if(obj[2]!=null){ %><%=obj[2] %><%}else{ %><i></i><%} %></span>
					<%} %>
				</td>
				</tr> 
				
				
				
				
				<%if(PfmsInitiation!= null) { Object[] obj = PfmsInitiation; %>
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >10.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Deliverables/Output</span></th>
				<td colspan="5" class="border_black normal left" ><span ><%if(obj[11]!=null){ %><%=obj[11] %><%}else{ %><i></i><%} %></</span></td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >11.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Participating Labs with Work share</span></th>
				<td colspan="5" class="border_black normal left" ><span ><%if(obj[3]!=null){ %><%=obj[3] %><%}else{ %><i></i><%} %></span></td>
				</tr> 
				
				
				<%} %>
				
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >12.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Brief of earlier work done</span></th>
				<td colspan="5" class="border_black normal left" >
				<%for (Object[] obj : DetailsList){ %>
					<span ><%if(obj[4]!=null){ %><%=obj[4] %><%}else{ %><i></i><%} %></span>
				<%} %>
				</td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >13.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Competency Established</span></th>
				<td colspan="5" class="border_black normal left" >
				<%for (Object[] obj : DetailsList){ %>
					<span ><%if(obj[5]!=null){ %><%=obj[5] %><%}else{ %><i></i><%} %></span>
				<%} %>
				</td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >14.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Need of the Project</span></th>
				<td colspan="5" class="border_black normal left" >
				<%for (Object[] obj : DetailsList){ %>
					<span ><%if(obj[6]!=null){ %><%=obj[6] %><%}else{ %><i></i><%} %></span>
				<%} %>
				</td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >15.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Technology Challenges/issues foreseen</span></th>
				<td colspan="5" class="border_black normal left" >
				<%for (Object[] obj : DetailsList){ %>
					<span ><%if(obj[7]!=null){ %><%=obj[7] %><%}else{ %><i></i><%} %></span>
				<%} %>
				</td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >16.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Risk involved and Mitigation Plan</span></th>
				<td colspan="5" class="border_black normal left" >
				<%for (Object[] obj : DetailsList){ %>
					<span ><%if(obj[8]!=null){ %><%=obj[8] %><%}else{ %><i></i><%} %></span>
				<%} %>
				</td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >17.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Proposal</span></th>
				<td colspan="5" class="border_black normal left" >
				<%for (Object[] obj : DetailsList){ %>
					<span ><%if(obj[9]!=null){ %><%=obj[9] %><%}else{ %><i></i><%} %></span>
				<%} %>
				</td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >18.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Cost estimate/Break-up</span></th>
				<td colspan="5" class="border_black normal left" > <span >Attached as Annexure - A</span></td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >19.</span></th>
				<th colspan="2" class="border_black normal left top" ><span >Major milestone/Project schedule</span></th>
				<td colspan="5" class="border_black normal left" ><span >Attached as Annexure - B</span></td>
				</tr> 
				
				<tr>
				<th colspan="1" class="border_black normal center top" style=";width:7%"><span >20.</span></th>
				<th colspan="2" class="border_black normal left top	" ><span >Realization Plan</span></th>
				<td colspan="5" class="border_black normal left" >
				<%for (Object[] obj : DetailsList){ %>
					<span ><%if(obj[10]!=null){ %><%=obj[10] %><%}else{ %><i></i><%} %></span>
				<%} %>
				</td>
				</tr> 
				
			</table>
			<h1 class="break"></h1> 
			<h1 class="break"></h1> 
		<br>
		<div align="center" style="font-size: 20px"><b>Annexure - A </b></div>
		<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse:collapse;" >
			
			
			<tr>
				<td colspan="1" class="border_black  left" style=";width:7%;font-weight: 600"><span >SN</span></td>
				<td colspan="2" class="border_black  center" style="font-weight: 600;width:25%;"><span >Head Code</span></td>
				<td colspan="5" class="border_black  center" style=";width:30%;font-weight: 600" ><span >Budget Item</span></td>
				<td colspan="2" class="border_black  center" style=";width:25%;font-weight: 600"><span >Item Cost (In Lakhs)</span></td>
			
			</tr>
			
			<%
			if(!CostDetailsList.isEmpty()){
			
			int count=1;
			for (Object[] obj: CostDetailsList) {%>
			 
			<tr>
			<td colspan="1" class="border_black  center" style=";width:7%"><span ><%=count %>. </span></td>
			<td colspan="2" class="border_black  left" ><span ><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %> - <%} %></span></td>
			<td colspan="5" class="border_black  left" ><span ><%if(obj[0]!=null){ %><%=obj[0] %><%}else{ %> - <%} %></span></td>
			<td colspan="2" class="border_black right"  ><span ><%if(obj[3]!=null && Double.parseDouble(obj[3].toString()) >0){ %>&#8377; <%=nfc.convert(Double.parseDouble(obj[3].toString())/100000)%> <%}else{ %> - <%} %></span></td>
			</tr> 
			
			<%
			count++;} }%>
			
			<%if(PfmsInitiation!= null) { Object[] obj = PfmsInitiation; %>
			
			<tr>
				<td colspan="12" class="border_black right"  ><span ><%if(obj[6]!=null && Double.parseDouble(obj[6].toString()) >0 ){ %>Total Cost : &#8377; <%=nfc.convert(Double.parseDouble(obj[6].toString())/100000)%> <%}else{ %>  <%} %> Lakhs</span></td>
			</tr>
			
			<%} %>
		
		</table> 
		<br><h1 class="break"></h1> 	
		<div align="center" style="font-size: 20px"><b>Annexure -B </b></div>
		<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 10px; width: 650px; font-size: 16px; border-collapse:collapse;" >
			
			<tr>
			<td colspan="1" class="border_black  left" style=";width:7%;font-weight: 600"><span >Mil No</span></td>
			<td colspan="5" class="border_black  center" style=";width:35%;font-weight: 600" ><span >Milestone Activity</span></td>
			<td colspan="2" class="border_black  center" style="font-weight: 600"><span >Milestone Month</span></td>
			<td colspan="2" class="border_black  center" style="font-weight: 600"><span >Milestone Remarks</span></td>
			</tr>
			
			<%
			if(!ScheduleList.isEmpty()){
			
			for (Object[] obj: ScheduleList) {%>
			 
			<tr>
			<td colspan="1" class="border_black  left" ><span ><%if(obj[0]!=null){ %><%=obj[0] %><%}else{ %> - <%} %></span></td>
			<td colspan="5" class="border_black  left" ><span ><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %> - <%} %></span></td>
			<td colspan="2" class="border_black center" ><span ><%if(obj[2]!=null){ %><%=obj[2] %><%}else{ %> - <%} %></span></td>
			<td colspan="2" class="border_black  left" ><span ><%if(obj[4]!=null){ %><%=obj[4] %><%}else{ %> - <%} %></span></td>
			</tr> 
			
			<%
			} }%>
			
			</table> 

			
	</div>

</div>
</div>

</body>



</html>