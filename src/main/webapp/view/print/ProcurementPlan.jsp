	<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal,java.util.stream.Collectors"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Part-I</title>
<%Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes"); 
String initiationid = (String) request.getAttribute("initiationid");
String ProjectTitle=(String)request.getAttribute("ProjectTitle");
String Labcode=(String)request.getAttribute("LabCode");
List<Object[]>DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
List<Object[]> ProjectInitiationLabList = (List<Object[]>) request.getAttribute("ProjectInitiationLabList");
Object[]MacroDetails=(Object[])request.getAttribute("MacroDetails");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
List<Object[]>ProcurementList=(List<Object[]>)request.getAttribute("ProcurementList");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf2=new SimpleDateFormat("MMMM yyyy");
NFormatConvertion nfc=new NFormatConvertion();
%>
<style type="text/css">

td{
	padding : -13px 5px;
}
p{
text-align:justify !important;
}

 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
		@page{             
          size:1120px 790px  ;
          margin-top: 49px;
          margin-left: 49px;
          margin-right: 49px;
          margin-buttom: 49px; 	
          border: 2px solid black;    
          @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
          
          @top-right {
          	 
          	 content : "Project : <%=ProjectTitle %>";
             margin-top: 30px;
             margin-right: 10px;
          }
          @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=Labcode%>";
          }            
           @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: "<%=Labcode%>";
          }     
 }
 .border_black{
 	border : 1px solid black;

 }

 th , td{
 
 font-size: 17px;
 } 
 hr{
background:black;
 }
 
 .border-black{
 border:1px solid black;
 border-collapse: collapse;
 }
 .border-black td th{
 padding:0px;
 margin: 0px;
 }
 </style>

</head>
<body>
<div style="text-align:center;">
		<h3 style="text-align: right;margin-right: 25px;"> Annexure-A</h3>
		</div>
		  <table class="border-black" style="margin-left:20px; margin-top:15px;border:0px solid black;font-family:FontAwesome; width:980px;">
		 								<thead style="background: #055C9D;color: black; font-size: 18px;">
								<tr>
								<th class="border-black" style="width:2%;text-align: center;">SN</th>
								<th class="border-black" style="width:14%;text-align: center; ">Name of the item/ Service</th>
									<th class="border-black" style="width:30%;text-align: center;">Description/Purpose </th>
								<th class="border-black" style="width:15%;text-align: center;">Source</th>
								<th class="border-black" style="width:10%;text-align: center;">Mode of tendering</th>
								<th class="border-black" style="width:6%;text-align: center;">Expected cost</th>
								<th class="border-black" style="width:10%;text-align: center;">ETS<br>( Months )</th>
										<th class="border-black" style="width:10%;text-align: center;">ED<br>( Months )</th>
								</tr>
							</thead>
							<tbody>
							<%int i=0;
							if(!ProcurementList.isEmpty()) {
							for(Object[]obj:ProcurementList){
							%><tr>
							<td class="border-black" style="width:2%;text-align: center;"><%=(++i) %></td>
							<td class="border-black" style="width:2%;text-align: center;"><%=obj[2] %></td>
							<td class="border-black" style="width:2%;text-align: center; padding:10px;" ><%=obj[3].toString() %></td>
							<td class="border-black" style="width:2%;text-align: center;"><%=obj[4].toString() %></td>
							<td class="border-black" style="width:2%;text-align: center;"><%=obj[5].toString() %></td>
							<td class="border-black" style="width:2%;text-align: right;"><%=nfc.convert(Double.parseDouble(obj[6].toString())/10000000)%></td>
							<td class="border-black" style="width:2%;text-align: center;"><%=obj[8].toString() %></td>
							<td class="border-black" style="width:2%;text-align: center;"><%=obj[9].toString() %></td>
							</tr>
							<%}} %>
							</tbody>
		  </table>
		<table class="border-black" style="margin-left:20px; border-top:none solid white;font-size:15px;font-family:FontAwesome; width:980px;">
		 					
		 				<thead style="background: #055C9D;color: black; font-size: "> 
						<tr>
						<td class="border-black" style="width:650px;text-align: left;">
						<h5>ETS-Expected Date of Tendering / Placing of SO&nbsp;, &nbsp;ED-Expected date of Delivery</h5>  </td>
						</tr>
						</thead>
						</table>
</body>

</html>