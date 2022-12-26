<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet"/>
 

<title>New Action</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
.multiselect-container>li>a>label {
  padding: 4px 20px 3px 20px;
}
.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:150px !important;
}
</style>
</head>
 
<body>
  <%
  


  List<Object[]> AssignedList=(List<Object[]>)request.getAttribute("AssignedList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
 
  
  
 %>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>

    <br />
    
    


   
   
   
   <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
				
					<h5 class="card-header">Self Assigned List</h5>
					
					<div class="card-body">

						<div class="data-table-area mg-b-15">
							<div class="container-fluid">


								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
													<select class="form-control dt-tb">
														<option value="">Export Basic</option>
														<option value="all">Export All</option>
														<option value="selected">Export Selected</option>
													</select>
												</div>
												<table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead>

														<tr>
															<th>SN</th>
															<th style="text-align: left;">Action Item</th>
															<th class="width-110px">PDC</th>
															<th class="width-110px">Assigned Date</th>									
														 	<th style="">Assignee</th>	
														 	<th class="width-115px">Progress</th>
														
														 		
														 	
														</tr>
													</thead>
													<tbody>
														<%int  count=1;
															
														 	if(AssignedList!=null&&AssignedList.size()>0){
															for(Object[] obj: AssignedList){ %>
														<tr>
															<td style="width:1% !important; " class="center"><%=count %></td>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=obj[5] %></td>
															
															<td class="width-30px"><%=sdf.format(obj[4])%></td>
															<td style="width:8% !important; "><%=sdf.format(obj[3])%></td>
															<td style="width:18% !important; "><%=obj[1]%>, <%=obj[2]%></td>
															<td style="width:8% !important; "><%if(obj[11]!=null){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[11]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=obj[11]%>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Yet Started .
															</div>
															</div> <%} %></td>
													
		
														</tr>
												<% count++; } }else{%>
												<tr>
													<td colspan="6" style="text-align: center">No List Found</td>
												</tr>
												<%} %>
												</tbody>
												</table>
												
							<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />


											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
		
				</div>

	
			</div>

		</div>

	</div>
   

  
<script>



	 



</script>




<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			/* "minDate" : new Date(), */
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
	$(function() {
		  $('#chkveg').multiselect({
		    includeSelectAllOption: true
		  });
	});
		
	
	
	$("#OldList").hide();

	
	$("#ItemDescriptionSearchBtn").click(function(){
		   $('#OldActionNoId').empty();
		var $ItemSearch = $("#ItemDescriptionSearch").val();
		  $("#loader ").show(); 
		
		
		
		  if ($ItemSearch === ""){
			 alert("Search Content Requried");
			 $("#loader ").hide();
		  }else{
					  
			  $
				.ajax({

					type : "GET",
					url : "ActionNoSearch.htm",
					data : {
						ActionSearch : $ItemSearch
					},
					datatype : 'json',
					success : function(result) {

						var result = JSON.parse(result);
						var values = Object.values(result).map(function(key, value) {
							  return result[key,value]
							});
						var size = Object.keys(values).length;
						var s = '';
						
						if(size==0){
							document.getElementById('Message').innerHTML = " * Old Action Number doesn't Exist. Please Reset "; 
						}
						if(size!=0){
							document.getElementById('Message').innerHTML = " "; 
						}
						
						 $("#OldList").show(); 
					     $("#OldActionNoId").prop("disable",false);
					    $("#OldActionNoId").empty();
					     $.each(values, function(key, value) {   
					         $('#OldActionNoId')   
					             .append($("<option></option>")
					                        .attr("value", value[0])
					                        .text(value[1]+", "+value[2])); 
					    });
					    
						$("#loader ").hide(); 
					}
				}); 
			  
			  
			  
		  }
		}); 
	
	
	function resetSubmit(){
		event.preventDefault();
		 $("#OldList").hide(); 
	     $("#OldActionNoId").prop("disable",true);
	     document.getElementById('Message').innerHTML = " "; 

	}
		
	
	
	</script>  


</body>
</html>