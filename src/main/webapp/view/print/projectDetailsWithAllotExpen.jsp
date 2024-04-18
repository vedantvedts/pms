<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.text.DecimalFormat" %>
<%-- <%@page import="com.vts.pfms.utils.DateTimeFormatUtil" %> --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project Sanction Details with Allotment And Expenditure</title>
<style>
    table { page-break-inside:auto }
    tr    { page-break-inside:avoid; page-break-after:auto }
    thead { display:table-header-group }
    tfoot { display:table-footer-group }
#myTable1 {
   
    border-collapse: collapse;
     border: 1px solid black;
    width: 100%;
}

#myTable1 td, #myTable1 th {
    padding: 6px;
}
@page{
size:A4 landscape;
}
</style>
<style type="text/css">
.tdSize{
width:200px;
}
.tdSize2{
width:20px;
}
</style>
</head>
<body>
<%
DecimalFormat df=new DecimalFormat("####################");
DateFormat format=new SimpleDateFormat("dd-MM-yyyy");
Date date=new Date();
List<Object[]> ProjectDetails=(List<Object[]>)request.getAttribute("ProjectDetails");
Map<String, Map<String, String>> AllotExpListDetailList=(Map<String, Map<String, String>>)request.getAttribute("AllotExpListDetailList"); 
Map<String, BigDecimal> AllotmentMap = (Map<String, BigDecimal>) request.getAttribute("AllotmentMap");
String GetPdc=(String)request.getAttribute("GetPdc");
String Amount=(String)request.getAttribute("Amount");
String BudgetHeadCode=(String)request.getAttribute("BudgetHeadCode");
String LabCode=(String)request.getAttribute("LabCode");

if(ProjectDetails!=null && ProjectDetails.size()>0){
	for(Object[] obj:ProjectDetails){
		BigDecimal Cost=new BigDecimal(obj[6].toString());
		int OrCost=Cost.intValue();
		
		FormatConverter fc = new FormatConverter();
%>
<table id="myTable1" border="1" align="center">
<tr>
<td colspan="12"  style="background-color:#d4e4f3; height: 1rem; margin-top: 50px;" align="center"><font size="5" ><b>Project Details</b></font> 
 		<%if(Amount!=null){ 
 		String inRupeeValue=null;
 		if(Amount.equalsIgnoreCase("R")){
 			inRupeeValue="In Rupees";
 		}else if(Amount.equalsIgnoreCase("L")){
 			inRupeeValue="In Lakhs";
 		}else if(Amount.equalsIgnoreCase("C")){
 			inRupeeValue="In Crore";
 		}
 		%>
 		<div align="right"><b>
 		(<%=inRupeeValue %>)</b></div>
 		<%} %>
 		</td>
 		</tr>
 		<tr>
        <td class="tdSize2" align="center">1</td>
 		<td class="tdSize" colspan="4">Project Title</td>
 		<td colspan="5"><%if(obj[0]!=null){%><%=obj[0]%><%}else{ %>-<%} %></td>
 		</tr>
 		
		<tr>
		<td class="tdSize2" align="center">2</td>
 		<td class="tdSize" colspan="4">Project No.</td>
 		<td colspan="5"><%if(obj[1]!=null){%><%=obj[1]%><%}else{ %>-<%} %></td>
 		</tr>
	<tr>
		<td class="tdSize2" align="center">3</td>
 		<td class="tdSize" colspan="4">Unit Code</td>
 		<td colspan="5"><%if(obj[9]!=null){%><%=obj[9]%><%}else{ %>-<%} %></td>
 		</tr>
 		
		<tr>
		<td class="tdSize2" align="center">4</td>
 		<td class="tdSize" colspan="4">Sanctioned Cost</td>
 		<%if(obj[6]!=null && OrCost==0){ %>
 		<td colspan="5"><%= df.format(obj[2]) %> (FE : <%=df.format(obj[8]) %>)</td>
 		<%}else{ %>
 		<td colspan="5"><%=df.format(obj[6]) %> (FE : <%=df.format(obj[10]) %>)</td>
 		<%} %>
 		</tr>
 		
		<tr>
		<td class="tdSize2" align="center">5</td>
 		<td class="tdSize" colspan="4">Revised Cost</td>
 		<%if(obj[6]!=null && OrCost!=0){ %>
 		<td colspan="5"><%=obj[2] %> (FE : <%=df.format(obj[8]) %>)</td>
 		<%}else{ %>
 		<td colspan="5">No Revision.</td>
 		<%} %>
 		</tr>
 		
		<tr>
		<td class="tdSize2" align="center">6</td>
 		<td class="tdSize" colspan="4">Sanction Letter No. & Date</td>
 		<td colspan="5"><%if(obj[3]!=null){%><%=obj[3]%><%} %>&nbsp;&nbsp;&nbsp;Dt.- <%if(obj[4]!=null){%><%=obj[4].toString()%><%} %></td>
 		</tr>
 		
		<tr>
		<td class="tdSize2" align="center">7</td>
 		<td class="tdSize" colspan="4">PDC Original</td>
 		<%if(obj[7]!=null){ %>
 		<td colspan="5"><%if(obj[7]!=null){%><%=obj[7].toString()%><%}%></td>
 		<%}else{ %>
 		<td colspan="5"><%if(obj[5]!=null){%><%=obj[5].toString()%><%}%></td>
 		<%} %>
 		</tr>
 		
		<tr>
		<td class="tdSize2" align="center">8</td>
 		<td class="tdSize" colspan="4">Revised PDC</td>
 		<%if(obj[7]!=null){ %>
 		<td colspan="5"><%-- <%=format.format(obj[5]) %> --%> <%=GetPdc.substring(1) %></td>
 		<%}else{ %>
 		<td colspan="5">No revision.</td>
 		<%} %>
 		</tr>
</table>
<br>
 <table id="myTable1" border="1">
           <tr>
     		<td colspan="12" align="center" style="background-color:#d4e4f3;"><font size="4"><b>Yearwise Allotment & Expenditure details</b></font></td>
     		</tr>
    	<%
     		ArrayList<String> bheads = new ArrayList<String>();
     		int no=0;
     		int i=0;
     		int REV=0;
     		int CAP=0;
     		int BEL=0;
     		int IAF=0;
     		int RDR=0;
     		int ATV=0;
     		int NAV=0;
     		int AD=0;
     		int ARM=0;
     		int ISR=0;
     		
     		if(AllotExpListDetailList!=null && AllotExpListDetailList.size()>0) {
     		for(String Year : AllotExpListDetailList.keySet()){
     			no++;
     		%>
     		<%String RevAllotment=nullCheck(AllotExpListDetailList.get(Year).get("REV_allotmentCost")); 

     		String CapAllotment=nullCheck(AllotExpListDetailList.get(Year).get("CAP_allotmentCost")); 
     
     		String BelAllotment=nullCheck(AllotExpListDetailList.get(Year).get("BEL_allotmentCost")); 

     		String IafAllotment=nullCheck(AllotExpListDetailList.get(Year).get("IAF_allotmentCost")); 

     		String RdrAllotment=nullCheck(AllotExpListDetailList.get(Year).get("RDR_allotmentCost")); 

     		String AtvAllotment=nullCheck(AllotExpListDetailList.get(Year).get("ATV_allotmentCost")); 

     		String NavAllotment=nullCheck(AllotExpListDetailList.get(Year).get("NAV_allotmentCost")); 
     		
     		String AdAllotment=nullCheck(AllotExpListDetailList.get(Year).get("AD_allotmentCost")); 
     		
     		String ArmAllotment=nullCheck(AllotExpListDetailList.get(Year).get("ARM_allotmentCost")); 
     		
     		String IsrAllotment=nullCheck(AllotExpListDetailList.get(Year).get("ISR_allotmentCost")); 
     		%>
    		 <%
     	     if(!RevAllotment.equals("-")){++REV; }
     		 if(!CapAllotment.equals("-")){++CAP;} 
     		 if(!BelAllotment.equals("-")){ ++BEL;}
     		 if(!IafAllotment.equals("-")){++IAF; }
     		 if(!RdrAllotment.equals("-")){ ++RDR;}
     		 if(!AtvAllotment.equals("-")){ ++ATV;}
     		 if(!NavAllotment.equals("-")){ ++NAV;}
     		 if(!AdAllotment.equals("-")){ ++AD;}
     		 if(!ArmAllotment.equals("-")){ ++ARM;}
     		 if(!IsrAllotment.equals("-")){ ++ISR;}
     		 %>
    <%}%>

    <tr>
     		<th rowspan="2">SN</th>
     		<th rowspan="2">Financial Year</th>
     		<%if(REV>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>REV</th>
     	    <%}if(CAP>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>CAP</th>
     		<%}if(BEL>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>BEL</th>
     		<%}if(IAF>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>IAF</th>
     		<%}if(RDR>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>RDR</th>
     		<%}if(ATV>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>ATV</th>
     		<%}if(NAV>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>NAVY</th>
     		<%}if(AD>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>AD</th>
     		<%}if(ARM>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>ARM</th>
     		<%}if(ISR>0){%>
     		<th <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %>colspan="3" <%}else{ %>colspan="2"<%} %>>ISRO</th>
     		<%} %>
     		</tr>
     		
     	<tr style="background-color:#ffb734;">
     		<!-- revenue -->
     		<%if(REV>0){%>
     		<td align="center">Allotment</td>
     		<td align="center">Expenditure</td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     		<%}%>
     		<!-- Capital -->
     		<%if(CAP>0){%>
     		<td align="center">Allotment</td>
     		<td align="center">Expenditure</td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     		<%}%>
     		<!--Bel-->
     		<%if(BEL>0){%>
     		<td align="center">Allotment</td>
     		<td align="center">Expenditure</td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     		<%}%>
     		 <!--IAF-->
     		<%if(IAF>0){%>
     		<td align="center">Allotment</td>
     		<td align="center">Expenditure</td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     		<%}%>
     	    <!--RDR-->
     	    <%if(RDR>0){%>
     		<td align="center">Allotment</td>
     		<td align="center">Expenditure</td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     		<%} %>
     		<!--ATV-->
     	     <%if(ATV>0){%>
     	     <td align="center">Allotment</td>
     		 <td align="center">Expenditure</td>
     		 <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     		<%} %>
     		<!--NAV-->
     	     <%if(NAV>0){%>
     	     <td align="center">Allotment</td>
     		 <td align="center">Expenditure</td>
     		 <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     		<%} %>
     		<!--AD-->
     	     <%if(AD>0){%>
     	     <td align="center">Allotment</td>
     		 <td align="center">Expenditure</td>
     		 <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     	     <%} %>
     	      <%if(ARM>0){%>
     	     <td align="center">Allotment</td>
     		 <td align="center">Expenditure</td>
     		 <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     	     <%} %>
     	      <%if(ISR>0){%>
     	     <td align="center">Allotment</td>
     		 <td align="center">Expenditure</td>
     		 <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="center">Non-Allot Expenditure</td><%}%>
     	     <%} %>
         </tr>
     	<%}%>
     	
     	 <%! public String nullCheck(String data){
     			  return data == null? "-" : data;} %>
     			  
     	<%
     		int count=0;
     		if(AllotExpListDetailList!=null && AllotExpListDetailList.size()>0) {
     		for(String Year : AllotExpListDetailList.keySet()){
     			count++;
     		%>
     		<!-- allotment and expenditure for budget heads of project -->
     		<tr>
     		
     		<td align="center"><%=count %></td>
     		<td align="center"><%=Year %></td>
     		
     		<!-- Revenue -->
     		<%if(REV>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("REV_allotmentCost")) %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("REV_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("REV_expAginestNonAllotment"))  %></td><%}%>
     		<%} %>
     		
     		<!-- Capital -->
     		<%if(CAP>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("CAP_allotmentCost"))  %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("CAP_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("CAP_expAginestNonAllotment"))  %></td><%}%>
     		<%}%>
     		
     		<!-- BEL -->
     		<%if(BEL>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("BEL_allotmentCost"))  %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("BEL_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("BEL_expAginestNonAllotment"))  %></td><%}%>
     		<%} %>
     		
     		<!--IAF -->
     		<%if(IAF>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("IAF_allotmentCost"))  %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("IAF_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("IAF_expAginestNonAllotment"))  %></td><%}%>
     		<%} %>
     		
     		
     		<!-- RDR -->
     		 <%if(RDR>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("RDR_allotmentCost"))  %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("RDR_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("RDR_expAginestNonAllotment"))  %></td><%}%>
     		<%} %>
     		
     		<!-- ATV -->
     		<%if(ATV>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("ATV_allotmentCost"))  %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("ATV_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("ATV_expAginestNonAllotment"))  %></td><%}%>
     		<%} %>
     		
     		<!-- NAV -->
     		<%if(NAV>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("NAV_allotmentCost"))  %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("NAV_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("NAV_expAginestNonAllotment"))  %></td><%}%>
     		<%} %>
     		
     		<!-- AD -->
     		<%if(AD>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("AD_allotmentCost"))  %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("AD_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("AD_expAginestNonAllotment"))  %></td><%}%>
     		<%} %>
     		
     		<!-- ARM -->
     		<%if(ARM>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("ARM_allotmentCost"))  %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("ARM_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("ARM_expAginestNonAllotment"))  %></td><%}%>
     		<%} %>
     		
     		<!-- ISR -->
     		<%if(ISR>0){ %>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("ISR_allotmentCost"))  %></td>
     		<td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("ISR_expAginestAllotment"))  %></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td align="right"><%=nullCheck(AllotExpListDetailList.get(Year).get("ISR_expAginestNonAllotment"))  %></td><%}%>
     		<%} %>
     		</tr>
     		<%}} %>
     		
     		<!--Total of allotment and expenditure based on budget heads   -->
     		
     		<tr>
     		<%if(REV>0 || CAP>0 || BEL>0 || IAF>0 || RDR>0 || ATV>0 || NAV>0 || AD>0 || ARM>0 || ISR>0  ) { %>
     		<td colspan="2" rowspan="2" align="center"><font size="5"><b>Total</b></font></td>
     		<%}%>
     	
     		<%if(REV>0){ %>
     			<!-- Rev -->
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalRevAlotment")%></b></td>
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalRevAllotment")%></b></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td rowspan="2" align="right"><b><%=AllotmentMap.get("totalRevNonAllotment")%></b></td><%}%>
     		<%} %>
     		
     		
     		<%if(CAP>0){ %>
     		<!-- Cap -->
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalCapAlotment")%></b></td>
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalCapAllotment")%></b></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td rowspan="2" align="right"><b><%=AllotmentMap.get("totalCapNonAllotment")%></b></td><%}%>
        	<%} %>
     		
     		
     		<%if(BEL>0){ %>
     		<!-- Bel -->
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalBelAlotment")%></b></td>
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalBelAllotment")%></b></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td rowspan="2" align="right"><b><%=AllotmentMap.get("totalBelNonAllotment")%></b></td><%}%>
     		 <%} %>
     		
     		<%if(IAF>0){ %>
     		<!--IAF -->
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalIafAlotment")%></b></td>
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalIafAllotment")%></b></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td rowspan="2" align="right"><b><%=AllotmentMap.get("totalIafNonAllotment")%></b></td><%}%>
     		 <%} %>
     		 

     		 <%if(RDR>0){ %>
     		<!--RDR-->
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalRdrAlotment")%></b></td>
     		<td rowspan="2" align="right"><b><%=AllotmentMap.get("totalRdrAllotment")%></b></td>
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td rowspan="2" align="right"><b><%=AllotmentMap.get("totalRdrNonAllotment")%></b></td><%}%>
     		 <%} %>
     		 
     		 <%if(ATV>0){ %>
     		<!--ATV-->
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalAtvAlotment")%></b></td>
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalAtvAllotment")%></b></td> 
     		<%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %> <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalAtvNonAllotment")%></b></td><%}%> 
     		 <%} %>
     		 
     		  <%if(NAV>0){ %>
     		<!--NAV-->
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalNavAlotment")%></b></td>
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalNavAllotment")%></b></td> 
     		 <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td rowspan="2" align="right"><b><%=AllotmentMap.get("totalNavNonAllotment")%></b></td><%}%> 
     		 <%} %>
     		 
     		  <%if(AD>0){ %>
     		<!--AD-->
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalAdAlotment")%></b></td>
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalAdAllotment")%></b></td> 
     		 <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td rowspan="2" align="right"><b><%=AllotmentMap.get("totalAdNonAllotment")%></b></td><%}%> 
     		 <%} %>
     		 
     		  <%if(ARM>0){ %>
     		<!--ARM-->
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalArmAlotment")%></b></td>
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalArmAllotment")%></b></td> 
     		 <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td rowspan="2" align="right"><b><%=AllotmentMap.get("totalArmNonAllotment")%></b></td><%}%> 
     		 <%} %>
     		 
     		  <%if(ISR>0){ %>
     		<!--ISR-->
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalIsrAlotment")%></b></td>
     		 <td rowspan="2" align="right"><b><%=AllotmentMap.get("totalIsrAllotment")%></b></td> 
     		 <%if(LabCode!=null && LabCode.equalsIgnoreCase("LRDE")){ %><td rowspan="2" align="right"><b><%=AllotmentMap.get("totalIsrNonAllotment")%></b></td><%}%> 
     		 <%} %>
     		</tr>
    </table>

<%}}%>
<br>
<div>Printed on "<%=format.format(date)%>" IBAS by VTS.</div>
</body>
</html>