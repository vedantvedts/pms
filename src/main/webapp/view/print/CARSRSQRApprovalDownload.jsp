<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RSQR Approval</title>
<%
CARSInitiation carsIni =(CARSInitiation)request.getAttribute("CARSInitiationData");
%>
<style>

.break{
	page-break-after: always;
} 

.border_black {
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
          size: 790px 950px;
          margin-top: 49px;
          margin-left: 39px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black; 
          
          @bottom-left {          		
             content: "";
             margin-bottom: 30px;
             margin-right: 10px;
             font-size: 13px;
          }
             
                    
           @bottom-right  {
            content: "Page " counter(page) " of " counter(pages);
            margin-bottom: 30px;
          }
           @top-right {
             content: "<%=carsIni.getCARSNo()!=null?carsIni.getCARSNo(): " - "%>";
             margin-top: 30px;
             font-size: 13px;
          }
          
          @top-center {
             content: "";
             margin-top: 30px;
             font-size: 13px;
          }
          
          
          @top-left {
          	margin-top: 30px;
            content: "";
            font-size: 13px;
          }               
          
 }
       
#tabledata{
 margin-left : 10px;
 border-collapse : collapse;
 border : 1px solid black;
 width : 98.5%;
}
#tabledata th{
 text-align : center;
 font-size: 14px;
}
#tabledata td{
 text-align : left;
 vertical-align: top;
}
#tabledata td,th{
 border : 1px solid black;
 padding : 5px;
}

p
{
	text-align: justify !important;
  	text-justify: inter-word;
}
p,td,th
{
  word-wrap: break-word;
  word-break: normal ;
}

#timestamptable{
 margin-left : 10px;
 border-collapse : collapse;
 width : 98.5%;
}
</style>
</head>
<body>
<%
Object[] emp = (Object[])request.getAttribute("EmpData");
List<Object[]> rsqrApprovalEmpData = (List<Object[]>)request.getAttribute("RSQRApprovalEmpData");
List<Object[]> rsqrRemarksHistory = (List<Object[]>)request.getAttribute("CARSRSQRRemarksHistory");

List<String> rsqrforward = Arrays.asList("INI","RGD","RPD");

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();
%>

<div align="center">
   <h4 style="font-weight: bold;margin-top: 1.5rem;">Research Service Qualitative Requirement (RSQR) Approval</h4>
</div>
<table id="tabledata">
	<tr>
    	<td style="width: 5%;text-align: center;">1.</td>
        <td style="width: 40%;">RSQR Title</td>
        <td style="width: 53%;color: blue;">
        	Research Service Qualitative Requirement (RSQR) for <%=carsIni.getInitiationTitle()!=null?carsIni.getInitiationTitle(): " - " %>
        </td>
    </tr>
    <tr>
        <td style="width: 3%;text-align: center;">2.</td>
        <td style="width: 40%;">Name and address of the Academic Institution</td>
        <td style="width: 53%;color: blue;">
        	<%=carsIni.getRSPInstitute()!=null?carsIni.getRSPInstitute(): " - " %> <br>
            <%=carsIni.getRSPAddress()!=null?carsIni.getRSPAddress(): " - "%> <%=", "%> <%=carsIni.getRSPCity()!=null?carsIni.getRSPCity(): " - "%> <%=", "%> <%=carsIni.getRSPState()!=null?carsIni.getRSPState(): " - "%> <%=" - "%> <%=carsIni.getRSPPinCode()!=null?carsIni.getRSPPinCode(): " - " %>.
        </td>
    </tr>
    <tr>
		<td style="width: 5%;text-align: center;" >3.</td>
		<td style="width: 40%;" >Name of the Principal Investigator</td>
		<td style="width: 53%;color: blue;" >
			<%=carsIni.getPITitle()!=null?carsIni.getPITitle(): " - "%> <%=". "%> <%=carsIni.getPIName()!=null?carsIni.getPIName(): " - " %>,
			<%=carsIni.getPIDesig()!=null?carsIni.getPIDesig(): " - " %> <br>
			<%=carsIni.getPIDept()!=null?carsIni.getPIDept(): " - " %> <br>
			<%=carsIni.getPIMobileNo()!=null?carsIni.getPIMobileNo(): " - " %> <br>
			<%=carsIni.getPIEmail()!=null?carsIni.getPIEmail(): " - " %>
			<%if(carsIni.getPIFaxNo()!=null && !carsIni.getPIFaxNo().isEmpty()){ %>
				<br> <%=carsIni.getPIFaxNo() %>
			<%} %>
		</td>
	</tr>
	<tr>
		<td style="width: 5%;text-align: center;" >4.</td>
		<td style="width: 40%;">Duration of the Contract (Months)</td>
		<td style="width: 53%;color: blue;"><%=carsIni.getDuration()!=null?carsIni.getDuration(): " - " %> </td>
	</tr>
	<tr>
		<td colspan="3" style="font-size: 14px;">
			&nbsp;<input type="checkbox"  class="TCBox" <%if(carsIni.getEquipmentNeed().equalsIgnoreCase("Y")) {%>checked<%} %> >&nbsp;Necessary DRDO-owned equipment and Lab resources will be spared on need basis for execution of the CARS for the duration.
		</td>
	</tr>
</table>
               							
<br><br><br><br>
      
<table id="timestamptable">
	<tr>
		<td style="text-align: left;">
			<div style="line-height: 17px;">
    			<div style="font-size: 15px;margin-bottom: 10px;">Signature of the initiating officer</div>
				<label style="text-transform: capitalize;">
					<%if(emp!=null && emp[1]!=null){%> <%=emp[1].toString()%><%} %>,
				</label><!-- <br> -->
				<label style="text-transform: capitalize;">
					<%if(emp!=null && emp[2]!=null){%> <%=emp[2].toString()%><%} %>
				</label><br>
				<label style="font-size: 12px;">
					Date&nbsp;:&nbsp;<%if(carsIni.getInitiationDate()!=null) {%> <%=fc.SqlToRegularDate(carsIni.getInitiationDate()) %><%} else{%><%=rdf.format(new Date()) %> <%} %>
				</label>
			</div>
		</td>
		<td style="text-align: right;">
			<div style="line-height: 17px;">
    			<div style="font-size: 15px;margin-bottom: 10px;"> Signature of the <%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>GD<%} else{%>PD<%} %></div>
				<%for(Object[] apprInfo : rsqrApprovalEmpData){ %>
					<%if(apprInfo[8].toString().equalsIgnoreCase("AGD") || apprInfo[8].toString().equalsIgnoreCase("APD")){ %>
						<label style="text-transform: capitalize;"><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
						<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
						<label style="font-size: 12px;">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString()).substring(0, 10)  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
				<%break;}} %>  
			</div>	
		</td>
	</tr>
</table>       							

</body>
</html>