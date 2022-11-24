<%@page import="com.google.gson.Gson"%>
<%@page import="com.vts.pfms.master.dto.DemandDetails"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Procurement Status</title>


 <style type="text/css">
 
 p{
  text-align: justify;
  text-justify: inter-word;
}

  
 th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 }
 
  }
 .textcenter{
 	
 	text-align: center;
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }
 
 #containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

summary[role=button] {
  background-color: white;
  color: black;
  border: 1px solid black ;
  border-radius:5px;
  padding: 0.5rem;
  cursor: pointer;
  
}
summary[role=button]:hover
 {
color: white;
border-radius:15px;
background-color: #4a47a3;

}
 summary[role=button]:focus
{
color: white;
border-radius:5px;
background-color: #4a47a3;
border: 0px ;

}
summary::marker{
	
}
details { 
  margin-bottom: 5px;  
}
details  .content {
background-color:white;
padding: 0 1rem ;
align: center;
border: 1px solid black;
}

}


		.input-group-text {
			font-weight: bold;
		}

		label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}

		hr {
			margin-top: -2px;
			margin-bottom: 12px;
		}

		.card b {
			font-size: 20px;
		}
		
		input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    /* display: none; <- Crashes Chrome on hover */
    -webkit-appearance: none;
    margin: 0; /* <-- Apparently some margin are still there even though it's hidden */
}

input[type=number] {
    -moz-appearance:textfield; /* Firefox */
}
		
	</style>


<meta charset="ISO-8859-1">

</head>
<body>

<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();
SimpleDateFormat sdf2=new SimpleDateFormat("dd-MM-yyyy");
List<DemandDetails> demandList=(List<DemandDetails>)request.getAttribute("demandList");
String projectId=request.getAttribute("projectId").toString();

%>

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">

					<div class="card-header" style="background-color: #055C9D; margin-top:">

						<form action="ProcurementStatus.htm" method="post">
							<b class="text-white">Add Demand File</b>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" name="projectid" <%if(projectId!=null){%> value="<%=projectId%>" <%}%>>
							<button type="submit" class="btn btn-info btn-sm shadow-nohover back" name="back" style="float: right;" > BACK </button>
						</form>
						<b class="text-white">Add Demand File</b>
						
						
						<form action="ProcurementStatus.htm" style="float:right; " method="post">
							<button type="submit" class="btn btn-sm back">Back</button>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" name="projectid" value="<%=projectId%>">
							
						</form>
					</div>
					<div class="card-body">
						<table class="table table-bordered table-hover table-striped table-condensed dataTable no-footer" id="myTable" role="grid" aria-describedby="myTable_info"> 
							<thead>
								<tr>
									<th>SN</th>
									<th>Demand No</th>
									<th>Demand Date</th>
									<th>Item Nomenclature</th>
									<th>Estimated Cost</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<%if(demandList!=null){ int count=1; %>
									<%for(DemandDetails demand : demandList){ %>
										
											<tr>
												<td><%=count++ %></td>
												<td><%=demand.getDemandNo() %></td>
												<td><%=sdf.format(sdf1.parse(demand.getDemandDate())) %></td>
												<td><%=demand.getItemFor() %></td>
												<td><%=demand.getEstimatedCost() %></td>
												<td>
													<form action="AddDemandFileSubmit.htm" method="post">
														<input type="hidden" name="DemandNo" id="DemandNoId" value="<%=demand.getDemandNo() %>" >
														<input type="hidden" name="projectId" id="projectIdId" value="<%=demand.getProjectId() %>" >
														<input type="hidden" name="demandDate" id="demandDateId" value="<%=demand.getDemandDate() %>" >
														<input type="hidden"  name="ItemNomcl" id="ItemNomclId" value= "<%=demand.getItemFor() %>" >
														<input type="hidden"  name="Estimtedcost" id="EstimtedcostId"  value= "<%=demand.getEstimatedCost() %>" >
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

														<button class="btn" onclick="return confirm('Are You Sure To Add This Demand?');"><i class="fa fa-plus-square" aria-hidden="true"></i></button>

														<button type="submit" class="btn" onclick="return confirm('Are You Sure To Add This Demand?');"><i class="fa fa-plus-square" aria-hidden="true"></i></button>

												
													</form>
												</td>
											</tr>
											
										
									<%} %>
								<%} %>
							</tbody>
						</table>
					</div>				
				</div>
			</div>
		</div>
	</div>

	
<script type="text/javascript">

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
             var demandList_json=null;
             $(document).ready(function(){
                <%
                Gson gson = new Gson();
                String json = gson.toJson(demandList); 
                %>
                demandList_json=<%=json%>
            });
             
                 $( "#selectDemand" ).change(function() {
            	     var selectId=$("#selectDemand").val();
            	     var date = new Date(demandList_json[selectId].DemandDate);
            	         var date1=date.getDate();
            	         if(date1<10){
            	        	 date1='0'+date1;
            	         }
            	         var month=(date.getMonth()+1);
            	         if(month<10){
            	        	 month='0'+month;
            	         }
            	         date=date1+'-'+month+'-'+date.getFullYear();
            	    $("#DemandNoId" ).val(demandList_json[selectId].DemandNo);
            	     $( "#projectIdId" ).val(demandList_json[selectId].ProjectId);
            	    $( "#demandDateId" ).val(date);
            	    $( "#ItemNomclId" ).val(demandList_json[selectId].ItemFor);
            	    $( "#EstimtedcostId" ).val(demandList_json[selectId].EstimatedCost);
            	     
            	});
</script>

</body>
</html>