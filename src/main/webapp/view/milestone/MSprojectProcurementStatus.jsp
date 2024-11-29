<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
.left {
	text-align: left;
}

.center {
	text-align: center;
}

.right {
	text-align: right;
}

.data-table {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid black;
}

.data-table th, .data-table td{
	border: 1px solid black;
	padding: 5px;
}

</style>
</head>
<body>
	<%
		List<Object[]> msProcurementStatusList = (List<Object[]>)request.getAttribute("msProcurementStatusList");
		Object[] projectDetails = (Object[])request.getAttribute("projectDetails");
		String projectId = (String)request.getParameter("ProjectId");
	%>
	<% String ses=(String)request.getParameter("result");
	 	String ses1=(String)request.getParameter("resultfail");
		if(ses1!=null){
		%>
		<div align="center">
			<div class="alert alert-danger" role="alert">
		    <%=ses1 %>
		    </div>
		</div>
		<%}if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert" >
		    	<%=ses %>
			</div>
		</div>
	<%} %>
	
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
		
			<div class="card-header" style="background-color: transparent;height: 3rem;">
 				<div class="row">
 					<div class="col-md-7">
 						<h3 class="text-dark" style="font-weight: bold;">Procurement Status - <%=projectDetails!=null?(projectDetails[3]+" ("+projectDetails[1]+")"):"" %> </h3>
 					</div>
 					<div class="col-md-3"></div>
 					<div class="col-md-2 right">
	 					<a class="back btn back" href="MSProjectMilestone.htm?ProjectId=<%=projectId%>">Back</a>
 					</div>
 				</div>
       		</div>
       		
       		<div class="card-body">
       			<table class="data-table" >
					<thead class="center">
						<!-- <tr>
							<th colspan="28" ><span class="mainsubtitle">Procurement Status</span></th>
					 	</tr> -->
					 	<tr>
							<th style="width: 5%;">SN</th>
							<th style="width: 17%;">Demand No.</th>
							<%for(int demandStage=0; demandStage<=25; demandStage++) {%>
								<th style="width: 3%;"><%=demandStage %></th>
							<%} %>
					 	</tr>
					</thead>
					<tbody>
						<%if(msProcurementStatusList!=null && msProcurementStatusList.size()>0) {
							int slno=0;
							for(Object[] obj : msProcurementStatusList) {
						%>
							<tr>
								<td class="center"><%=++slno %></td>
								<td class="center"><%=obj[1] %></td>
								<%for(int demandStage=0; demandStage<=25; demandStage++) {%>
									<td <%if(obj[2]!=null && demandStage<=(Integer.parseInt(obj[2].toString())) ) {%> 
											style="background-color: green;color: white" class="center" 
										<%} else if(obj[2]==null && demandStage==0) {%>
											style="background-color: #F96E16;color: white" class="center" 
										<%} %>
										>
										<%if((obj[2]!=null && demandStage==Integer.parseInt(obj[2].toString())) || (obj[2]==null && demandStage==0)) {%>
											*
										<%} %>
									</td>
								<%} %>
							</tr>
						<%} }else{%>
							<tr><td colspan="28" class="center" >No Data Available</td></tr>
						<%} %>
					</tbody>	
				</table>
				
				<table class="data-table mt-4">
					<tbody>
						<tr>
							<td>0</td>
							<td>Demand to be Initiated</td>
							<td>7</td>
							<td>TCEC Approved</td>
							<td>14</td>
							<td>CDR</td>
							<td>21</td>
							<td>Inward Inspection Clearance</td>
						</tr>
						<tr>
				            <td>1</td>
							<td>Demand Initiated</td>
							<td>8</td>
							<td>TPC Approved</td>
							<td>15</td>
							<td>Acceptance of Critical BoM by Dev Partner</td>
							<td>22</td>
							<td>Payment Process</td>
						</tr>
						<tr>
							<td>2</td>
							<td>SPC Cleared</td>
						    <td>9</td>
							<td>Financial Sanction</td>
							<td>16</td>
							<td>Realization Completed</td>
							<td>23</td>
							<td>Partially Paid</td>
						</tr>
						<tr>
							<td>3</td>
							<td>Demand Approved</td>
						    <td>10</td>
							<td>Order Placement</td>
							<td>17</td>
							<td>FAT Completed</td>
							<td>24</td>
							<td>Payment Released</td>
						</tr>
						<tr>
							<td>4</td>
							<td>Tender Enquiry Floated</td>
							<td>11</td>
							<td>PDR</td>
							<td>18</td>
							<td>ATP/QTP Completed</td>
							<td>25</td>
							<td>Available for Integration</td>
						</tr>
						<tr>
							<td>5</td>
							<td>Receipt of Quotations</td>
							<td>12</td>
							<td>SO for Critical BoM by Dev Partner</td>
							<td>19</td>
							<td>Delivery at Stores</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>6</td>
							<td>Tender Opening</td>
							<td>13</td>
							<td>DDR</td>
							<td>20	</td>
							<td>SAT / SoFT</td>
							<td></td>
							<td></td>
						</tr>
					</tbody>	
				</table>
       		</div>
       	</div>
       </div>	
</body>
</html>