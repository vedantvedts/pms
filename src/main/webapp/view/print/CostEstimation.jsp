<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>PMS</title>
<style type="text/css">
table{
	align: left;	
	margin-left:10px;
	border-collapse:collapse;
	
}
th,td
{
	text-align: left;
	border: 1px solid black;
	padding-left: 4px;
} 	

p{
font-size: 20px;
margin-left: 10%;

}
</style>
</head>
<body>
<%
List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");

%>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
						<div class="row card-header">
				   			<div class="col-md-6">
								<h3>Project Document List</h3>
							</div>
			
							<div class="col-md-6 justify-content-end" >
								<table style="float: right; " >
									<tr>
										<td style="border: none;"><h4>Project :</h4></td>
										<td style="border: none;">
											<form method="post" action="ProjectSanctionPreview.htm" >
												<select class="form-control selectdee"  data-container="body" data-live-search="true"  name="projectid"  required="required" style="width:200px;"  onchange="submitForm('projectchange');">
													<option disabled  selected value="">Choose...</option>
													<%for(Object[] obj : projectslist){ %>
													<option value="<%=obj[0]%>" ><%=obj[1] %></option>
													<%} %> 
												</select>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										</td>
									</tr>
								</table>							
							</div>
						 </div>
					 </div>
					</div>
</div>


<div align="left">

<p>Lab Name &emsp;&emsp;&emsp;&emsp;      :</p>
<p>Project Name  &emsp;&emsp;&ensp;&nbsp; :</p> 
<p>Cost in Cr / Lakh &emsp;&ensp;:</p>
</div>
<div align="center">

<table style="width: 90%;" >
	<thead>
		<tr>
				<th>Major Head</th>
				<th>Sub Head</th>
				<th>Items Description</th>
				<th>LPP/SO/BE/OWN COST</th>
				<th>Quantity</th>
				<th>Cost Per Unit</th>
				<th>Currency Rate</th>
				<th>Year of Reference </th>
				<th>Year of Realization</th>
				<th>Total Without Taxes</th>
				<th>Cost Esc %Amount (Rs in lakhs)</th>
				<th>Import Duty%Amount (Rs in lakhs)</th>
				<th>GST % Amount (Ruppes in lakhs)</th>
				<th>Total Cost (Rs in lakhs)</th>
				<th>Copy of Enclosure</th>
		</tr>
	</thead>
	<tbody>
		<tr> 
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		     <td></td>
		</tr>
	</tbody>
</table>

</div>

<div >
 
 	<p style="margin-bottom: -0.5%;">Total Capital </p>
 	<p style="margin-bottom: -0.5%;">Total Revenue </p>
 
 	<p>Grand Total</p>
 	
 
</div>

</body>
</html>