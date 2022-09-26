	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>TCC MODIFY</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}
b{
	font-family: 'Lato',sans-serif;
}

</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

Object[] TccData=(Object[])request.getAttribute("TccData");
List<Object[]> TccMemberList=(List<Object[]>)request.getAttribute("TccMemberList");
List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
List<Object[]> EmployeeList1=(List<Object[]>)request.getAttribute("EmployeeList1");

%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></center>
                    <%} %>



<div class="container">
	<div class="row" style="">
		<div class="col-md-12">
		
		 <div class="card shadow-nohover" >
			 <div class="card-header">
				 <div class="row" >
					<div class="col-md-12 ">
					  <h4>Technology Council Committee</h4>
					 </div>
				 </div>
			  </div>
			  
		      <div class="card-body">
		   		
		<div id="hideonedit"> <!-- --------------------------------- -->
            
            <div class="row">
            
            <div class="col-md-12">
            
            <div class="row">
            
                <div class="col-md-6 ">
                        <div class="form-group">
                            <label class="control-label">Chairperson : </label>
                              <b> <%=TccData[3]%> (<%=TccData[5] %>) </b>
                        </div>
                    </div>
                    
                <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label">Member Secretary : </label>
                              <b> <%=TccData[4]%> (<%=TccData[6] %>) </b>
                        </div>
                    </div>
                    
               </div>
               
		        <div class="row">     
		               <div class="col-md-6">
		                        <div class="form-group">
		                            <label class="control-label">Valid From: </label>
		                              <b> <%=sdf.format(TccData[1])%></b>
		                        </div>
		                    </div>
		                    
		                    
		                    <div class="col-md-6 ">
		                        <div class="form-group">
		                            <label class="control-label">Valid To: </label>
		                              <b><%=sdf.format(TccData[2])%> </b>
		                        </div>
		                    </div>
		                    
		         </div>
                    
                   
                    <div align="center" >
                        <div class="form-group">
						        <button class=" btn btn-warning edit" onclick="myFunction()" >Edit</button>   		
						    
                        </div>
                    </div>
                    
                  </div>
                
                </div>
                
                </div>
  
         	</div>
         		
         		  <!-- ----------------- hide on edit -----------------  -->
	   
         <div id="showonedit" style="display: none;">
       <form action="TccUpdate.htm" method="POST"  > 

            <div class="row">  
    				           
                <div class="col-md-6 ">
                        <div class="form-group">
                        	 <table><tr>
                        	<td>
                            <label class="control-label">Chairperson : </label>
                            </td>
                            <td>
                              <select class="form-control "name="ChairMain" required="required" style=" font-weight: bold; text-align-last: left; width: 280px	;" data-live-search="true" data-container="body">										
				          					<option disabled="true"  selected value="">Choose...</option>
						    					<% for (Object[] obj : EmployeeList1) {%>
			       									<option value="<%=obj[0]%>" <%if(TccData[8].toString().equals(obj[0].toString())){ %>selected<%} %>><%=obj[1]%> ( <%=obj[2] %> ) </option>
			    								<%} %>					
										</select></td></tr>
	  					</table>
 
                        </div>
                    </div>
                    
                    
                <div class="col-md-6 ">
                        <div class="form-group">
                        	 <table>
                        	 <tr>
                        	<td>
                            <label class="control-label">Secretary : </label>
                            </td>
                            <td>
                              <select class="form-control "name="Secretary"  required="required" style=" font-weight: bold; text-align-last: left; width: 280px;" data-live-search="true" data-container="body">										
				          					<option disabled="true"  selected value="">Choose...</option>
						    					<% for (Object[] obj : EmployeeList1) {%>
			       									<option value="<%=obj[0]%>" <%if(TccData[7].toString().equals(obj[0].toString())){ %>selected<%} %> ><%=obj[1]%> ( <%=obj[2] %> ) </option>
			    								<%} %>					
										</select></td>
							</tr>
	  					</table>
 
                        </div>
                    </div>    
                    
                    
               </div>    <!-- row end -->
               
               
               <div class="row">     
                 <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label">Valid From: </label>
                              <b> <%=sdf.format(TccData[1])%></b>
                        </div>
                    </div>
                    
                    
                    <div class="col-md-6 ">
                        <div class="form-group">
                            <label class="control-label">Valid To: </label>
                              <b><%=sdf.format(TccData[2])%> </b>
                        </div>
                    </div>
                    
              </div>
                    <div align="center" >
                        <div class="form-group">
                          
						    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />                  	
							    <input type="hidden" name="pfmstccid" value="<%=TccData[0]%>" /> 	
						        <button class=" btn btn-warning edit" type="submit" name="sub" value="SUBMIT">Update</button>   		
						    
                        </div>
                    </div>
                 </form>  
     
           </div> 
        
                 
<!-- ----------------- show on edit -----------------  -->

				
         		<br>
				<hr>
				<br>
	
		
			<div class="row">
			<div class="col-md-1"></div>
				<div class="col-md-10">

		         	<table  class="table table-bordered table-hover table-striped table-condensed ">
		            	<thead>
		               		<tr>
		                    	<th >Member</th>
		                       	<th >Delete</th> 
		                    </tr>
		              	</thead>                        
			    		<tbody>
							<%int count=0;
								for(Object[] 	obj:TccMemberList){ count++;%>
									
						<form action="TCCMemberDelete.htm" method="POST"  >
							<tr>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						        <input type="hidden" name="PfmsTccMemberId" value="<%=obj[2] %>" /> 	
						        <input type="hidden" name="pfmstccid" value="<%=obj[0] %>" /> 		
								<td><%=obj[1] %> ( <%=obj[3] %> )</td>
								<td>
									<button class="fa fa-trash btn btn-danger " type="submit" ></button>
								</td>
							</tr>
						</form>
								<%} %>
						</tbody>
			    
		             </table>
		         
		             
		        
		        
		            <form action="TccMemberAdd.htm" method="POST" name="myfrm" id="myfrm">
		        
			      		<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
							<thead>  
								<tr id="Memberrow0" >
									<th >Member Name</th>
									<th><i class="btn btn-sm fa fa-plus" style="color: green;"  onclick="MemberAdd()"></i></th>
								</tr>
								<input type="hidden"  id="MemberAdd" value="0" />
								<tr id="Memberrow0">
									<td >
										<select class="form-control "name="Member" id="Member0" required="required" style=" font-weight: bold; text-align-last: left; width: 500px;" data-live-search="true" data-container="body">										
				          					<option disabled="true"  selected value="">Choose...</option>
						    					<% for (Object[] obj : EmployeeList) {%>
			       									<option value="<%=obj[0]%>"><%=obj[1]%> ( <%=obj[2] %> ) </option>
			    								<%} %>					
										</select>
									</td>									
			                     	<td><i class="btn btn-sm fa fa-minus" style="color: red;" id="MemberMinus0" onclick="Memberremove(this)" ></i></td>								
								</tr>
							</thead>
						</table>  
				
				<input type="hidden" name="pfmstccid" value="<%=TccData[0] %>" />
					 	<div class="form-group" align="center">
							<input type="submit" class="btn btn-primary btn-sm submit "  value="SUBMIT"  name="sub"> 
							<input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
 						</div>
		
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<input type="hidden" name="pfmstccid" value="<%=TccData[0] %>" /> 	
	
		 			</form>												

				 </div> 
		       </div> 
					 
		    </div> <!-- card end -->
		   
		</div>
	</div>
</div>
 

	
<script type="text/javascript">

	function myFunction() {
	var x = document.getElementById("hideonedit");
	var y = document.getElementById("showonedit");
	  if (x.style.display === "none") {
	    x.style.display = "block";
	  } else {
	    x.style.display = "none";
	  }
	  
	 if (y.style.display === "none") {
	    y.style.display = "block";
	  } else {
	    y.style.display = "none";
	  }
	}


function MemberAdd(){
	
	var colnerow=$('#myTable20 tr:last').attr('id');
	  

	  var MemberRowId=colnerow.split("Memberrow");
	  var MemberId=Number(MemberRowId[1])+1
	  var row = $("#myTable20 tr").last().clone().find('textarea').val('').end();
	 
      row.attr('id', 'Memberrow'+MemberId );
      
     
      row.find('#Member' + MemberRowId[1]).attr('id', 'Member' +MemberId);
  
      row.find('#MemberMinus' + MemberRowId[1]).attr('id', 'MemberMinus' +MemberId);  
    
      $("#myTable20").append(row);
	
     
	
	 $("#MemberAdd").val(PaymentRowId); 
 }
 
 
function Memberremove(elem){
	 
	  var id = $(elem).attr("id");
	  var Membersplitid=id.split("MemberMinus");
	  var Memberremoveid="#Memberrow"+Membersplitid[1];

	
		
		 $(Memberremoveid).remove();
		  

			$('#Member' + Membersplitid[0]).prop("required", false);

	}
 
 



</script>

</body>
</html>