<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Milestone List</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 14px;
}
.table thead tr,tbody tr{
    font-size: 14px;
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
  width: 120px;
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
	width:210px !important;
}
.bootstrap-select {
  width: 400px !important;
}
input[type=checkbox] {
	accent-color: green;
}
</style>
</head>
 
<body>
  <%
  

  
  List<Object[]> ProductTreeList=(List<Object[]>)request.getAttribute("ProductTreeList");
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  
  
 %>


    
  <%-- <div class="row W-100" style="width: 100%;">

 
	
                                    <div class="col-md-2">
                            		<label class="control-label">Project Name :</label>
                            		</div>
                            		<div class="col-md-2" style="margin-top: -7px;">
                              		<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ProjectList) {
    										String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
    										%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>> <%=obj[4]+projectshortName%>  </option>
											<%} %>
  									</select>
  									</div>
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
 </div> --%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){	%>
	<div align="center">
		<div class="alert alert-danger" role="alert" >
	    <%=ses1 %>
	     <br />
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert"  >
	    	<%=ses %>
	    	 <br />
	    </div>
	</div>
<%} %>

   
   <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0px;">
				<div class="row card-header">
			     <div class="col-md-10">
					<h5 ><%if(ProjectId!=null){
						Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
						%>
						<%=ProjectDetail[2] %> ( <%=ProjectDetail[1] %> ) 
					<%} %>
					</h5>
					</div>
					
					 </div>
					<div class="card-body">
                        <div class="table-responsive"> 
									<table class="table  table-hover table-bordered">
													<thead>

														<tr>
															<th>Expand</th>
															
															<th style="text-align: left;">Level </th> 
															<th style="text-align: left;max-width: 200px;">Level Name</th>
															
																											
														 	<th style="max-width: 200px;" >Action</th>
														 		
														 	
														</tr>
													</thead>
													<tbody>
														<%int  count=1;
															
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level1: ProductTreeList){
																 if(level1[2].toString().equalsIgnoreCase("1")) { %>	
																
														<tr>
															<td style="width:2% !important; " class="center"><span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span></td>
															
															
															
															<td style="">Level-1</td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level1[3] %></td>
															
															
															<td  style="width:20% !important; text-align: center;">		
																<form action="" method="POST" name="myfrm"  style="display: inline">
																	
																	 
		                                                              <button  class="editable-click" name="sub" value="E" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													                  <button  class="editable-click" name="sub" value="D" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button> 
		                                                            
													                  
		                                                             
		                                                            <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
																    <input type="hidden" name="MainId" value="<%=level1[0]%>"/>
																    <input type="hidden" name="projectid" value="<%=ProjectId%>"/>
															 </form> 
															 
															 	
															</td>
														</tr>
														
														  <tr class="collapse row<%=count %>" style="font-weight: bold;">
                                                         <td></td>
                                                         <td>Sub</td>
                                                         <td>Level Name</td>
                                                         <td>Action</td>
                                                         
                                                         </tr>
                                                         
                                                         <% int countA=1;
                                                          
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level2: ProductTreeList){
																 if(level2[2].toString().equalsIgnoreCase("2") && level1[0].toString().equalsIgnoreCase(level2[1].toString())){%>
	
																
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> A-<%=countA%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level2[3] %></td>
														 	<td class="width-30px" style="text-align: center;">
														 	
														 	
														 	<button  class="editable-click" name="sub" value="E" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													                  <button  class="editable-click" name="sub" value="D" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
														 	
														 	
														 	
														 	
														 	</td>
                                                         </tr>
                                                         <% int countB=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level3: ProductTreeList){
																  if(level3[2].toString().equalsIgnoreCase("3") && level2[0].toString().equalsIgnoreCase(level3[1].toString()) ){
	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;B-<%=countB%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level3[3] %></td>
															
															<td class="width-30px"  style="text-align: center;">
															
															
															<button  class="editable-click" name="sub" value="E" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													                  <button  class="editable-click" name="sub" value="D" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															
															
															
															</td>
															
                                                         </tr>
                                                         <% int countC=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level4: ProductTreeList){
																  if(level4[2].toString().equalsIgnoreCase("4") && level3[0].toString().equalsIgnoreCase(level4[1].toString())) {
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C-<%=countC%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level4[3] %></td>
															
															<td class="width-30px"  style="text-align: center;">
															
															
															
															<button  class="editable-click" name="sub" value="E" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													                  <button  class="editable-click" name="sub" value="D" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															
															
															
															
															</td>
															
                                                         </tr>
                                                         <% int countD=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level5: ProductTreeList){
															if(level5[2].toString().equalsIgnoreCase("5") && level4[0].toString().equalsIgnoreCase(level5[1].toString()) ){%>
	
																
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D-<%=countD%></td>
														
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level5[3] %></td>
															
															
																<td class="width-30px">
															
															
															
															<button  class="editable-click" name="sub" value="E" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													                  <button  class="editable-click" name="sub" value="D" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															
															
															
															
															</td>
															
                                                         </tr>
                                                         <% int countE=1;
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
															for(Object[] level6: ProductTreeList){ 
																if(level6[2].toString().equalsIgnoreCase("6") && level5[0].toString().equalsIgnoreCase(level6[1].toString())) {
																	
																%>
															
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-<%=countE%></td>
															
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=level6[3] %></td>
															
														    <td class="width-30px">
															
															
															
															<button  class="editable-click" name="sub" value="E" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
													                        <span>Edit</span>
													                      </div>
													                     </div>
													                  </button> 
													                  
													                  
													                  <button  class="editable-click" name="sub" value="D" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
													                        <span>Delete</span>
													                      </div>
													                     </div>
													                  </button>
															
															
															
															
															</td>
															
															
                                                         </tr>
												<% countE++;} }}%>
												<% countD++;} }}%>
												<% countC++;} }}%>
												<% countB++;} }}%>
												<% countA++;} }}else{%>
												<tr class="collapse row<%=count %>">
													<td colspan="9" style="text-align: center" class="center">No Sub List Found</td>
												</tr>
												<%} %> 
												<% count++; }} }else{%>
												<tr >
													<td colspan="9" style="text-align: center" class="center">No List Found</td>
												</tr>
												<%} %>
												
												</tbody>
												</table>
												</div>
							


											</div>
							
						</div>

					</div>
		
				</div>

	
			</div>





	
<script type="text/javascript">
function MainDOCEditModal(mainid, DOC)
{
	$('#MSMainid').val(mainid);			
	$('#MainDOCDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"startDate" : new Date(DOC),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	$('#MainDOCEditModal').modal('toggle');
	
}
															 
</script>  

  
<script>


$(document).ready(function() {
	   $('#ProjectId').on('change', function() {
	     $('#submit').click();

	   });
	});
	
	 
function ChangeButton(id) {
	console.log($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString());
	if($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
	$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
	$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
    }else{
	$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
	$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
    }
}


</script>




<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"minDate" : new Date(),
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

	$('#DateCompletion2').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : new Date(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	
	function updateBpPoints(ele){
		var a=ele.value;
		var value1=a.split("/")[0];
		var value2=a.split("/")[1];
		var value3=a.split("/")[2]
		console.log(value1+"-"+value2+"-"+value3);
		$.ajax({
			type:'GET',
			url:'BriefingPointsUpdate.htm',
			datatype:'json',
			data:{
				ActivityId:value1,
				point:value3,
				status:value2,
			}
		});
		
		
		if(value2==="Y"){
		ele.value=value1+"/N/"+value3
		}else{
			ele.value=value1+"/Y/"+value3
		}
	}
</script>  


</body>
</html>