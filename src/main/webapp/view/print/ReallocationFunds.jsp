<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
@media print {

    #printbtn {
        display :  none;
    }
}
</style>
</head>
<body>
<%
List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");

%>
<div class="container-fluid" id ="printbtn">
		<div class="row">
			<div class="col-md-12">
						<div class="row card-header">
						<div class="col-md-6 " >
								<table style="float: left; " >
									<tr>
										<td style="border: none;"><h4>Project :</h4></td>
										<td style="border: none;">
											<form method="post" action="ProjectSanctionPreview.htm" >
												<select class="form-control selectdee"  data-container="body" data-live-search="true"  name="projectinitiationid"  required="required" style="width:200px;"  onchange="this.form.submit()">
													<option disabled  selected value="">Choose...</option>
													<%if(projectslist!=null){ for(Object[] obj : projectslist){ %>
													<option value="<%=obj[0]%>" ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></option>
													<%}} %> 
												</select>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										</td>
									</tr>
								</table>							
				            </div>
				   		    <div class="col-md-6 justify-content-end" >
								<a class="btn btn-info btn-sm shadow-nohover back" href="ProjectDocs.htm" style="float: right; " > Back</a>
							</div>
			            </div>
		         </div>
	     </div>
</div>

<form action="" method="post">
<div>
<h4 align="center">SHEET_16</h4>

<div>
		<p align="right" style="padding-right: 35px;"> No.__________/___/D(R&D)
		<br>Government of India 
		<br>Ministry of Defence<br>
		Dept. of Defence Res & Dev
		<br>DRDO HQ,<br>New Dehli - 110 011
		<br>Date______ Month, Year</p>
</div>

<p style="padding-left: 35px;">To,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Chairman <br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Defense Research & Development Organizations<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DRDO HQ, New Delhi - 110 011
</p>

<p align="center"> (For projects, where CFA is Lab Director / Cluster DG, addressee will be Lab Director / cluster DG and corresponding entries will be change accordingly).</p>

<p align="center"><b>Subject: Re-allocation of Funds/Cost Revision under Project (Name) _______ (No)____</b></p>

<br>

<p align="center" style="padding-left: 35px; text-align: justify;">1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am directed to convey the sanction of the Competent Financial Authority for Cost revision/ reallocation of Project (Name) _________(No)____vide Govt. sanction letter no ______ dated _____ as amended vide corrigendum no.  _____ dated ____, from Rs. ____ (FE __ Cr) to Rs. ____ Cr (FE _____) as per following details (list of amendments):</p>
<p style="padding-left: 50px;"><b>For:</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Sanctioned project cost break-up table (existing)' </p>

<p style="padding-left: 50px;"><b>Read:</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Revised cost break-up table for cost-revision or re-allocation of funds' </p>
<p align="center" style="padding-left: 35px; text-align: justify;">2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	All other entries remain same. </p>

<p align="center" style="padding-left: 35px; text-align: justify;">3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Unique sanction code:&nbsp;<input type="text" name="USC" id="printbtn" required="required"></p>

<p align="center" style="padding-left: 35px; text-align: justify;">4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	This issues with the concurrence of Ministry of Defence (Finance / R&D) vide their Dy. No &nbsp;<input type="text"  name="USC" id="printbtn" required="required">  &nbsp;/MoD(Fin)/R&D dated <input style="width: 9%;" id="currentdate"  data-date-format="dd/mm/yyyy" readonly name="startDate" class="form-control form-control"></p>

<br>

<p align="right" style="padding-right: 50px;">Yours faithfully,()<br>Authorized signatory of CFA</p>

<br>
	<div align="center">
		<table>
				<tr>
					<td style=" border: 1px solid black;"><b><u>Ink Signed Copy to :</u></b></td>
					<td style=" border: 1px solid black;"><b><u>Copy to </u></b></td>
				</tr>
				
				<tr>
					<td style=" border: 1px solid black;">DG (Cluster) <br>
						Director Lab <br>
						Director P&C <br>
						CGDA, New Delhi<br>
						PCDA (R&D), New Delhi<br>
						CDA (R&D), Concerned<br>
						File copy<br>	
					</td>
					<td style=" border: 1px solid black;">The Director of Audit, Defence Services, New Delhi       <br>
						Addl FA  (R&D) & JS or IFA (R&D), Concerned (as applicable)<br>
						Director FMM		<br>
						Director CW&E       <br>
					</td>
				</tr>
		</table>
	</div>
</div>
<br>
	<div align="center">
			<button type="submit" id ="printbtn" class="btn btn-sm submit">Submit </button>
	</div>
</form>
<script type="text/javascript">
$('#currentdate,#datepicker').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
</script>
</body>
</html>