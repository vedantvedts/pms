<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Final SoO</title>
<%
CARSInitiation carsIni =(CARSInitiation)request.getAttribute("CARSInitiationData");
CARSContract carsContract =(CARSContract)request.getAttribute("CARSContractData");
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
 

 @page  {             
          size: 790px 980px;
          margin-top: 20px;
          margin-left: 60px;
          margin-right: 60px;
          margin-buttom: 50px; 	
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
}
#tabledata td,th{
 border : 1px solid black;
 padding : 5px;
}

p{
  text-align: justify !important;
  text-justify: inter-word;
}
p,td,th
{
  word-wrap: break-word;
  word-break: normal ;
}
</style>
</head>
<body>
<%
Object[] emp = (Object[])request.getAttribute("EmpData");
Object[] dPandC = (Object[])request.getAttribute("DPandC");

String lablogo=(String)request.getAttribute("lablogo");
LabMaster labMaster = (LabMaster)request.getAttribute("LabMasterData");

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();

String labcode = (String)session.getAttribute("labcode");

%>
<jsp:include page="../static/LetterHead.jsp"></jsp:include>
<br>
<table style="width: 100%;font-size: 14px !important;">
	<tr>
		<td style="text-align: left;width: 50%;">No&nbsp;:&nbsp;<span style="font-size: 13px"><%if(carsIni!=null) {%><%=carsIni.getCARSNo()!=null?carsIni.getCARSNo(): " - " %> <%} %></span></td>
		<td style="text-align: right;width: 50%;">Date&nbsp;:&nbsp;<span style="font-size: 13px"><%if(carsContract!=null && carsContract.getFinalSoODate()!=null) {%><%=fc.SqlToRegularDate(carsContract.getFinalSoODate()) %> <%} %></span></td>
	</tr>
</table>

<br>
<table style="font-size: 14px !important;">
	<tr>
		<td>To</td>
	</tr>
	<tr><td></td></tr>
	<tr>
		<td>
			The Registrar <br>
			<%=carsIni.getRSPInstitute()!=null?carsIni.getRSPInstitute(): " - " %> <br>
			<%=carsIni.getRSPAddress()!=null?carsIni.getRSPAddress(): " - "%> <%=", " %> <br>
			<%=carsIni.getRSPCity()!=null?carsIni.getRSPCity(): " - "%> <%=", " %> 
			<%=carsIni.getRSPState()!=null?carsIni.getRSPState(): " - "%> <%=" - " %> 
			<%=carsIni.getRSPPinCode()!=null?carsIni.getRSPPinCode(): " - " %>.
		</td>
	</tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr>
		<td style="font-weight: 600;">Kind Attn : <%if(carsIni!=null) {%><%=carsIni.getPITitle()!=null?carsIni.getPITitle(): " - "%> <%=". "%> <%=carsIni.getPIName()!=null?carsIni.getPIName(): " - "%>, <%=carsIni.getPIDesig()!=null?carsIni.getPIDesig(): " - " %><%} %></td>
	</tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr>
		<td>Sir/Madam,</td>
	</tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr>
		<td  style="font-weight: 600;text-indent: 20px;"><%if(carsIni!=null && carsIni.getInitiationTitle()!=null) {%>"<%=carsIni.getInitiationTitle()%>".<%} %></td>
	</tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr>
		<td>Refer your summary of Offer Letter dated <span style="font-size: 13px"><%if(carsIni!=null && carsIni.getInvForSoODate()!=null) {%><%=fc.SqlToRegularDate(carsIni.getInvForSoODate()) %> <%} %></span></td>
	</tr>
</table>
<br>
<table style="font-size: 14px !important;">
	<tr>
		<td style="width: 5%;vertical-align: top;">2. </td>
		<td>
			Contract for Acquisition of Research Services (CARS) between <%=labcode!=null?labcode: " - " %> and <%=carsIni.getRSPInstitute()!=null?carsIni.getRSPInstitute(): " - "%>, <%=carsIni.getRSPAddress()!=null?carsIni.getRSPAddress(): " - " %>, 
			Bearing No. <%if(carsContract!=null && carsContract.getContractNo()!=null) {%><%=carsContract.getContractNo() %><%} %> 
			Dated <%if(carsContract!=null && carsContract.getContractDate()!=null) {%><%=fc.SqlToRegularDate(carsContract.getContractDate()) %><%} %>
			on the subject is sent herewith for your necessary action please.
		</td>
	</tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr>
		<td style="width: 5%;vertical-align: top;">3. </td>
		<td>
			For claiming advance payment you are required to produces the following documents: <br>
			<div  style="margin-left: -30px;">
				<ul style="list-style-type: none;">
					<li>a) Original Invoice</li>
					<li>b) Contractor's Bill</li>
					<li>c) ECS Form</li>
					<li>d) Copy of the PAN cars of the institute</li>
					<li>e) Cancelled Cheque</li>
				</ul>
			</div>
			
		</td>
	</tr>
	<tr>
		<td style="width: 5%;vertical-align: top;">4. </td>
		<td>
			For claiming Final Milestone payment, you are required to produce all the document mentioned Sl. No 3 along with Fund utilization certificate
			(clearly indicating the funds received, expenditure, Commitments and Balance.)
		</td>
	</tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr>
		<td style="width: 5%;vertical-align: top;">5. </td>
		<td>
			As per General Conditions of CARS (refer 2.2 C, Which is printed on back of the enclosed Original Contract form), you are requested to maintain
			copies of books, bills, vouchers, and other financial records related to the contract for submission to <%=labcode!=null?labcode: " - " %> during final Milestone Payment &
			financial closure of CARS.
		</td>	
	</tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr><td></td></tr>
	<tr>
		<td colspan="2">Thanking you,</td>
	</tr>
	<tr><td></td></tr>
	<tr>
		<td></td>
		<td style="text-align: right;">(<%if(dPandC!=null) {%><%if(dPandC[4]!=null) {%><%=dPandC[4].toString() %><%} else{%><%=dPandC[5]!=null?dPandC[5].toString(): " - " %><%} %><%=dPandC[1]!=null?dPandC[1].toString(): " - " %> <%} %>)</td>
	</tr>
	<tr>
		<td></td>
		<td style="text-align: right;"><%if(dPandC!=null && dPandC[2]!=null) {%><%=dPandC[2].toString() %><%} %></td>
	</tr>
	<tr>
		<td></td>
		<td style="text-align: right;">For Director, <%=labcode!=null?labcode: " - " %></td>
	</tr>
</table>
<h1 class="break"></h1>
<jsp:include page="../static/LetterHead.jsp"></jsp:include> 
<table style="font-size: 14px !important;">
	<tr>
		<td style="width: 58%;vertical-align: top;">
			<ul style="list-style-type: none;">
				<li>The CDA (R&D)</li>
				<li><%=labMaster.getLabAddress()!=null?labMaster.getLabAddress(): " - " %> </li>
				<li><%=labMaster.getLabCity()!=null?labMaster.getLabCity(): " - "%>, <%=labMaster.getLabPin() !=null?labMaster.getLabPin(): " - "%></li>
			</ul>
		</td>
		<td style="width: 42%;vertical-align: top;">
			<ul style="list-style-type: none;">
				<li>The Director</li>
				<li>Dte of Planning & Coordination (D-P&C)</li>
				<li>Ministry of Defence, DRDO Bhavan</li>
				<li>Rajaji Marg, New Delhi - 11011</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td style="width: 58%;vertical-align: top;">
			<ul style="list-style-type: none;">
				<li>The Director General (ECS)</li>
				<li>Ministry of Defence, DRDO</li>
				<li><%=labcode %></li>
				<li><%=labMaster.getLabAddress()!=null?labMaster.getLabAddress(): " - " %> </li>
				<li><%=labMaster.getLabCity()!=null?labMaster.getLabCity(): " - "%>, <%=labMaster.getLabPin()!=null?labMaster.getLabPin(): " - " %></li>
			</ul>
		</td>
		<td style="width: 42%;vertical-align: top;">
			<ul style="list-style-type: none;">
				<li>The Director</li>
				<li>Dte of Finance & Material Management</li>
				<li>Ministry of Defence, DRDO Bhavan</li>
				<li>Rajaji Marg, New Delhi - 11011</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td style="width: 58%;vertical-align: top;">
			<ul style="list-style-type: none;">
				<li>The Director</li>
				<li>Dte of ER & IPR</li>
				<li>Ministry of Defence, DRDO Bhavan</li>
				<li>Rajaji Marg, New Delhi - 11011</li>
			</ul>
		</td>
		<td style="width: 42%;vertical-align: top;">
			<ul style="list-style-type: none;">
				<li>Internal copies to:</li>
				<li>DRAM</li>
				<li>MMFD (Accts Group)</li>
			</ul>
		</td>
	</tr>
</table>
</body>
</html>