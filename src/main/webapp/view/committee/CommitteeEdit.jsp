<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<jsp:include page="../static/header.jsp"></jsp:include>



	<title> COMMITTEE EDIT</title>
	<style type="text/css">
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
	</style>
</head>

<body>

<%
Object[] committeedetails=(Object[])request.getAttribute("committeedetails"); 
String projectid=committeedetails[12].toString();
Object[] projectdetails=(Object[])request.getAttribute("projectdetails"); 
%>
<%
String ses=(String)request.getParameter("result"); 
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
    
    
	<div class="container">
		<div class="row">
			<div class="col-md-12">			
				<div class="card shadow-nohover">
					<div class="card-header" style=" background-color: #055C9D;margin-top: ">
						<div class="row">
							<div class="col-md-6">
								<b class="text-white">EDIT COMMITTEE</b>
							</div>
							<div class="col-md-6">
								<%if(Long.parseLong(projectid)>0){ %>
								<div align="right"><b class="text-white"  >Project : <%=projectdetails[4] %></b></div>
								<%} %>
							</div>
						</div>
					</div>

					<div class="card-body">
						<form action="CommitteeEditSubmit.htm" method="post" name="editfrm" id="editfrm" >
							<div class="row">
							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Committee Code</label>
										<input class="form-control" type="text" name="committeeshortname" required value="<%=committeedetails[1]%>" maxlength="20">
									</div>
								</div>
							
							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Committee Name</label>
										<input class="form-control" type="text" name="committeename" required value="<%=committeedetails[2]%>" maxlength="255">
									</div>
								</div>

							
							<div class="col-md-4">
								<div class="form-group">
									<label class="control-label">Committee Type</label>
									<select class="custom-select" id="secretary" required="required" name="committeetype" style="margin-top: -5px">
									
										<option <%if(committeedetails[3].toString().equalsIgnoreCase("S")){ %>selected <%} %> value="S">Standard</option>
										<option <%if(committeedetails[3].toString().equalsIgnoreCase("A")){ %>selected <%} %>value="A">Adhoc</option>
									</select>
								</div>
							</div>
						
						
						</div>
						
						<div class="row">
						
						 <div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Project Applicable</label>
									<select class="custom-select" id="secretary" required="required" name="projectapplicable" style="margin-top: -5px">
										<%if(committeedetails[4].toString().equalsIgnoreCase("P")){ %>
										<option selected value="P">Project</option>
										<option   value="N">Non-Project</option>
										<%}else if(committeedetails[4].toString().equalsIgnoreCase("N")){ %>
										<option  value="P">Project</option>
										<option selected  value="N">Non-Project</option>
										<%} %>
									</select>
									<input type="hidden" name="projectid" value="<%=committeedetails[12]%>">
								</div>
							</div> 
							
							
							
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Tech / Non-Tech</label>
									<select class="custom-select" id="" required="required" name="technontech" style="margin-top: -5px">
										
										<option <%if(committeedetails[5].toString().equalsIgnoreCase("T")){ %>selected <%} %> value="T">Technical</option>
										<option  <%if(committeedetails[5].toString().equalsIgnoreCase("N")){ %>selected <%} %> value="N">Non-Technical</option>
									</select>
								</div>
							</div>
							
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Periodic / Non-Periodic</label>
									<select class="custom-select" id="periodic"  name="periodic" style="margin-top: -5px" >
										
										<option <%if(committeedetails[7].toString().equalsIgnoreCase("P")){ %>selected <%} %> value="P">Periodic</option>
										<option <%if(committeedetails[7].toString().equalsIgnoreCase("N")){ %>selected <%} %> value="N">Non-Periodic</option>
									</select>
								</div>
							</div>
							
							<div class="col-md-3" <%if(!committeedetails[7].toString().equalsIgnoreCase("P")){ %> style="display: none" <%} %> id="periodicduration">
								<div class="form-group">
									<label class="control-label">Periodic Duration (Days)</label>
									<input class="form-control" type="number" id="periodicdurationfield" name="periodicduration" required min="1" placeholder="Days" <%if(committeedetails[7].toString().equalsIgnoreCase("P")){ %> value="<%=committeedetails[8]%>" <%} %>>
								</div>
							</div>
							
						</div>	
						
						<div class="row">
							<%-- <div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Project </label>
								
								  		<select class="form-control" name="projectid" required="required" id="projectid" >
											<option <%if(committeedetails[12].toString().equalsIgnoreCase("0")){ %> selected <%} %> value="0">Non - Project</option>
											<%for(Object[] obj : projectslist){ %>
											<option <%if(committeedetails[12].toString().equalsIgnoreCase(obj[0].toString())){ %> selected <%} %> value="<%=obj[0]%>"><%=obj[2] %></option>
											<%} %>
									  	</select>
								  	
								</div>
							</div> --%>
							<div class="col-md-12">
								
								<div class="form-group">
									<label class="control-label">Guidelines</label>
									<input class="form-control" type="text" name="guidelines" required value="<%if(committeedetails[6]!=null){ %><%=committeedetails[6]%><%} %>" maxlength="255">
									
								</div>

							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								
								<div class="form-group">
									<label class="control-label">Description</label>
									<textarea class="form-control"  name="description" required placeholder="Enter Description" rows="5" cols="50" maxlength="1000"><%if(committeedetails[10]!=null){ %><%=committeedetails[10]%><%} %></textarea>
								</div>

							</div>
							<div class="col-md-6">
								
								<div class="form-group">
									<label class="control-label">Terms Of Reference </label>
									<textarea class="form-control"  name="TOR" required placeholder="Enter Terms Of Reference" rows="5" cols="50" maxlength="1000"><%if(committeedetails[11]!=null){ %><%=committeedetails[11]%><%} %></textarea>
								</div>

							</div>
						</div>
						
						
						
						
						<input type="hidden" name="committeeid" value="<%=committeedetails[0]%>">
					
					
					<div class="row" >
						<div class="col-md-5"></div>
						<div class="col-md-3">
							<div class="form-group">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<button class="btn btn-primary btn-sm submit"  name="submit" value="SUBMIT"   onclick="return confirm('Are You Sure To Save ?');" >SUBMIT</button>
								<input type="hidden" name="id" value="<%=committeedetails[4]%>">							
								<button class="btn btn-primary btn-sm back" type="button"  onclick="submitForm('backfrm');">BACK</button>
							</div>
						</div>
					</div>
					</form>		
								
					<form method="post" action="CommitteeList.htm" name="backfrm" id="backfrm">
						<input type="hidden" name="projectid" value="<%=committeedetails[12]%>">
						<input type="hidden" name="projectappliacble" value="<%=committeedetails[4]%>">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />					
					</form>				
				</div>					
							
			</div>
			<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ">
			</div>
		</div>
	</div>
</div>
	
		
		
<script type="text/javascript">
$('#projectid').select2();
function submitForm1(myform)
{ 
	/* var periodic=$('#projectapplicable').val();
	var projectid=parseInt($('#projectid').val());
	
	if(periodic=='P')
	{
		if(projectid==0){
			alert('periodic ');
		}
	} */
 	myconfirm('Are You Sure To Edit This committee ?',myform);
 	event.preventDefault();
}

function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
</script>
	
<script>

$(document).ready(function(){
	$('#periodicdurationfield').prop("required",false); 
})


document.getElementById('periodic').addEventListener('change', function() {

if(this.value == "P"){

		document.getElementById('periodicduration').style.display="block";
		$('#periodicdurationfield').prop("required",true); 
		
	}
	if(this.value == "N"){
		
		document.getElementById('periodicduration').style.display="none";
		$('#periodicdurationfield').prop("required",false); 
	}
	
	
	});

</script>		
	
		
</body>

</html>