	<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>COMMITTEE MAIN MODIFY</title>
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
<%

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

Object[] committeemaineditdata=(Object[])request.getAttribute("committeemaineditdata");
List<Object[]> committeemainmemberlist=(List<Object[]>)request.getAttribute("committeemainmemberlist");
List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("employeelist");
List<Object[]> EmployeeList1=(List<Object[]>)request.getAttribute("employeelist1");
List<Object[]> projectlist=(List<Object[]>)request.getAttribute("projectlist");
String projectid=(String) request.getAttribute("projectid");
%>

<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>



<div class="container">

	<div class="row" style="">
		<div class="col-md-12">
		
		 <div class="card shadow-nohover" >
			 <div class="card-header">
			 
				 <div class="row" >
					<div class="col-md-12 ">
					  <%-- <b style="color: green;">Title : &nbsp;<%=ProjectTccData[2] %> ( <%=ProjectTccData[1] %> ) &nbsp;&nbsp;&nbsp;&nbsp; ||
					  &nbsp;&nbsp;&nbsp;&nbsp; Chairperson : &nbsp;<%=ProjectTccData[3]%>&nbsp;&nbsp;&nbsp;&nbsp; || &nbsp;&nbsp;&nbsp;&nbsp; Secretary :&nbsp;<%=ProjectTccData[4]%>
					  </b> --%>
					<table>	<tr>	
						<td>    <h4><%=committeemaineditdata[6]!=null?StringEscapeUtils.escapeHtml4(committeemaineditdata[6].toString()): " - "%> (<%=committeemaineditdata[7]!=null?StringEscapeUtils.escapeHtml4(committeemaineditdata[7].toString()): " - "%>) </h4></td><td>
					  
					  <form action="ProjectCommitteeMainEdit.htm" method="post" name="projectidselect" id ="projectidselect">
		    			<select class="form-control" id="projectid" required="required" name="projectid" onchange='submitForm("projectidselect");' >	
							<option disabled="true"  selected value="">Choose...</option>
							<% for (Object[] obj : projectlist) {%>						    				 	
								<option value="<%=obj[0]%>" <%if(projectid.equals(obj[0].toString())) {%>selected<%} %>><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%> (<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>)</option>
							<%} %>					
						</select>
							
							<input type="hidden" name="committeeid" value="<%=committeemaineditdata[1]%>"/>
						  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
		    		  </form></td>
					</tr>
					  
					
					  <form method="post" action="CommitteeDetails.htm">
					 <button  type="submit" class="btn btn-sm add" style="float:right;" >CONSTITUTE NEW COMMITTEE</button>
					  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
					  	<input type="hidden" name="committeemainid" value="<%=committeemaineditdata[1]%>">
					  </form>
					 </table>
					 
					 </div>
				 </div>
			  </div>
			
		      <div class="card-body">
		      		      
		   	   <div id="hideonedit">   <!-- hideonedit -->
                <div class="row">
                
                <div class="col-md-6 ">
                        <div class="form-group">
                            <label class="control-label">Chairperson : </label>
                              <b> <%=committeemaineditdata[4]!=null?StringEscapeUtils.escapeHtml4(committeemaineditdata[4].toString()): " - "%> (<%=committeemaineditdata[9]!=null?StringEscapeUtils.escapeHtml4(committeemaineditdata[9].toString()): " - "%>) </b>
                        </div>
                    </div>
                    
                <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label">Member Secretary : </label>
                              <b> <%=committeemaineditdata[5]!=null?StringEscapeUtils.escapeHtml4(committeemaineditdata[5].toString()): " - "%> (<%=committeemaineditdata[11]!=null?StringEscapeUtils.escapeHtml4(committeemaineditdata[11].toString()): " - "%>)</b>
                        </div>
                    </div>
                 
                  
                    
               </div>
               
              <div class="row">   
              
              	<div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label">Valid From: </label>
                             <b> <%=committeemaineditdata[2]!=null?sdf.format(committeemaineditdata[2]):" - " %></b> 
                        </div>
                    </div>
                
       
                  <%-- <div class="col-md-6 ">
                        <div class="form-group">
                            <label class="control-label">Valid To: </label>
                            <b><%=sdf.format(committeemaineditdata[3])%> </b> 
                        </div>
                    </div> --%>

              </div>
              
              
              <div align="center">
               <button class=" btn btn-warning edit" onclick="myFunction()" align="center" >Edit</button>
               </div> 
             </div>     <!--    --------------------------------- hideonedit --------------------------------- -->
              <!--    --------------------------------- showonedit --------------------------------- -->
           <form action="CommitteeMainEditSubmit.htm" method="post"> 
           <div id="showonedit" style="display: none;"> 
            
                <div class="row">
                
                <div class="col-md-6 ">
                        <div class="form-group">
                        
                        <table><tr>
                        	<td>
                            <label class="control-label">Chairperson : </label>
                            </td>
                            <td>
                             <select class="custom-select" id="chairperson" required="required" name="chairperson" style="margin-top: -5px"> 
									    <option disabled="true"  selected value="">Choose...</option>
									    	<% for (Object[] obj : EmployeeList1) {%>
										<option value="<%=obj[0]%>" <%if(committeemaineditdata[8].toString().equals(obj[0].toString())){ %>selected<%} %> ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%> (<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>) </option>
												<%} %>
	  							   </select></td></tr>
	  					</table>
                        </div>
                    </div>
                    
                <div class="col-md-6">
                        <div class="form-group">
                        
                        <table><tr>
                        	<td>
                            	<label class="control-label">Member Secretary : </label>
                            </td>
                            <td>
                           	<select class="custom-select" id="secretary" required="required" name="Secretary" style="margin-top: -5px">
				    			<option disabled="true"  selected value="" >Choose...</option>
				    				<% for (Object[] obj : EmployeeList1) {%>
									<option value="<%=obj[0]%>" <%if(committeemaineditdata[10].toString().equals(obj[0].toString())){ %>selected<%} %> ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%> (<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>)</option>
									<%} %>
				  			</select></td>
				  			</tr>
                        
                        </table>
                        </div>
                    </div>
                    
               </div>
               <div class="row">     
                
              
               <div class="col-md-6">
                        <div class="form-group">
                            <label class="control-label">Valid From: </label>
                             <b> <%=committeemaineditdata[2]!=null?sdf.format(committeemaineditdata[2]):" - "%></b> 
                        </div>
                    </div>
                    
                    
                   
              </div>
               <div align="center">
              	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />                  	
				<input type="hidden" name="committeemainid" value="<%=committeemaineditdata[0] %>" /> 	
					<input type="hidden" name="committeeid" value="<%=committeemaineditdata[1] %>" />
					<input type="hidden" name="projectid" value="<%=projectid%>"/>
                <button class=" btn btn-warning edit" type="submit" align="center" >UPDATE</button>
               </div> 
               </form>
             </div> <!-- showonedit -->
             
      
         		
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
         		</script>
         		
         		<br>

				<hr>
				<br>
	
		
			<div class="row" style="">
			<div class="col-md-1"></div>
				<div class="col-md-10">
				<%if(committeemainmemberlist.size()>0){ %>
		         	<table  class="table table-bordered table-hover table-striped table-condensed ">
		            	<thead>
		               		<tr>
		                    	<th >Member</th>
		                       	<th >Delete</th> 
		                    </tr>
		              	</thead>                        
			    		<tbody>
							<%int count=0;
								for(Object[] 	obj:committeemainmemberlist){ count++;%>
									
						<form action="CommitteeMemberDelete.htm" method="POST"  >
							<tr>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						        <input type="hidden" name="committeemainid" value="<%=committeemaineditdata[1] %>" /> 	
						        <input type="hidden" name="committeememberid" value="<%=obj[0] %>" /> 		
								<td><%=obj[2] %> ( <%=obj[4] %> )</td>
								<td>
									<button class="fa fa-trash btn btn-danger " type="submit" ></button>
								</td>
							</tr>
						</form>
								<%} %>
						</tbody>
			    
		             </table>
		         
		             <%} %>
		        
		        
		            <form action="CommitteeMainMembersAddSubmit.htm" method="POST" name="myfrm" id="myfrm">
		        
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
			       									<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%> (<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>) </option>
			    								<%} %>					
										</select>
									</td>									
			                     	<td><i class="btn btn-sm fa fa-minus" style="color: red;" id="MemberMinus0" onclick="Memberremove(this)" ></i></td>								
								</tr>
							</thead>
						</table>  
				
						<input type="hidden" name="committeemainid" value="<%=committeemaineditdata[0] %>" /> 
						<input type="hidden" name="committeeid" value="<%=committeemaineditdata[1] %>" />
						<input type="hidden" name="projectid" value="<%=projectid%>"/>
					 	<div class="form-group" align="center">
							<input type="submit" class="btn btn-primary btn-sm submit "  value="SUBMIT"  name="sub"> 
							<!-- <input type="button" class="btn btn-primary btn-sm submit back" formaction="CommitteeMainList.htm"  value="BACK"   name="sub" > -->
							<!-- <a href="CommitteeMainList.htm" class="btn btn-primary btn-sm submit back">BACK</a> -->
							<a href="CommitteeList.htm" class="btn btn-primary btn-sm submit back">BACK</a>
 						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<input type="hidden" name="pfmstccid" value="<%=committeemaineditdata[0] %>" /> 	
	
		 			</form>												

				 </div> 
		       </div> 
					 
		    </div> <!-- card end -->
		    
		</div>
	</div>
</div>

  

	
<script type="text/javascript">

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

<script type='text/javascript'> 
function submitForm(formid)
{ 
  document.getElementById(formid).submit(); 
} 
</script>




</body>
</html>