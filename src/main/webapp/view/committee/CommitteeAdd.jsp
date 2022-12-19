<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<jsp:include page="../static/header.jsp"></jsp:include>



	<title> ADD COMMITTEE</title>
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
String projectid=(String)request.getAttribute("projectid");
Object[] projectdetails=(Object[])request.getAttribute("projectdetails"); 
String projectappliacble=(String)request.getAttribute("projectappliacble");
%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></div>
                    <%} %>
    <br />
    
    
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header" style=" background-color: #055C9D; ">
						<div class="row">
							<div class="col-md-6">
								<b class="text-white">ADD NEW COMMITTEE</b>
							</div>
							<div class="col-md-6">
								<%if(Long.parseLong(projectid)>0){ %>
								<div align="right"><b class="text-white"  >Project : <%=projectdetails[4] %></b></div>
								<%} %>
							</div>
						</div>
					</div>
					<form action="CommitteeAddSubmit.htm" method="post" name="addcommitteefrm" id="addcommitteefrm" >
					
						<div class="card-body">
							<div class="row">							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">
											Committee Code
											<span class="mandatory" style="color: red;">*</span>
										</label>
										<input class="form-control" type="text" name="committeeshortname" id="committeeshortname" required maxlength="6">
									</div>
								</div>
							
							
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Committee Name<span class="mandatory" style="color: red;">*</span></label>
										<input class="form-control" type="text" name="committeename" id="committeename" required maxlength="255">
									</div>
								</div>

							
							<div class="col-md-4">
								<div class="form-group">
									<label class="control-label">Committee Type<span class="mandatory" style="color: red;">*</span></label>
									<select class="custom-select" id="ctype" required="required" name="committeetype" style="margin-top: -5px">
										<option disabled="true"  selected value="">Choose...</option>
										<option  value="S">Standard</option>
										<option  value="A">Adhoc</option>
									</select>
								</div>
							</div>
						
						
						</div>
						
						<div class="row">
						 <div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Project Applicable<span class="mandatory" style="color: red;">*</span></label>
									<select class="custom-select" id="proapplicable" required="required" name="projectapplicable" style="margin-top: -5px">
										<option disabled="true"  selected value="">Choose...</option>
										<%if(projectappliacble.equals("P")){ %>
										<option selected value="P">Project</option>
										<%}else if(projectappliacble.equals("N")){ %>
										<option selected value="N">Non-Project</option>										
										<%} %>
									</select>
									<input type="hidden" name="projectid" value="<%=projectid%>">
								</div>
							</div> 
							
							
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Tech / Non-Tech<span class="mandatory" style="color: red;">*</span></label>
									<select class="custom-select" id="technontech" required="required" name="technontech" style="margin-top: -5px">
										<option disabled="true"  selected value="">Choose...</option>
										<option  value="T">Technical</option>
										<option  value="N">Non-Technical</option>
									</select>
								</div>
							</div>
							
							<div class="col-md-3">
								<div class="form-group">
									<label class="control-label">Periodic / Non-Periodic<span class="mandatory" style="color: red;">*</span></label>
									<select class="custom-select" id="periodic" required="required" name="periodic" style="margin-top: -5px" >
										<option disabled="true"  selected value="">Choose...</option>
										<option  value="P">Periodic</option>
										<option  value="N">Non-Periodic</option>
									</select>
								</div>
							</div>
							
							<div class="col-md-3" style="display: none" id="periodicduration">
								<div class="form-group">
									<label class="control-label">Periodic Duration (Days)<span class="mandatory" style="color: red;">*</span></label>
									<input class="form-control" type="number" min="1" name="periodicduration" id="periodicdurationfield" placeholder="Days">
								</div>
							</div>
							
						</div>	
						
						<div class="row">
							
							
							<div class="col-md-12">								
								<div class="form-group">
									<label class="control-label">Guidelines<span class="mandatory" style="color: red;">*</span></label>
									<input class="form-control" type="text" name="guidelines" id="guidelines"  required maxlength="255">
								</div>

							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								
								<div class="form-group">
									<label class="control-label">Description<span class="mandatory" style="color: red;">*</span></label>
									<textarea class="form-control"  id="description" name="description" required placeholder="Enter Description" rows="5" cols="50" maxlength="1000"></textarea>
								</div>

							</div>
							<div class="col-md-6">
								
								<div class="form-group">
									<label class="control-label">Terms Of Reference <span class="mandatory" style="color: red;">*</span></label>
									<textarea class="form-control" id="TOR"  name="TOR" required placeholder="Enter Terms Of Reference" rows="5" cols="50" maxlength="1000"></textarea>
								</div>

							</div>
						</div>
					</div>
					<div class="row" ><div class="col-md-5"></div>
						<div class="col-md-3">
							<div class="form-group">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<button type="button" class="btn btn-primary btn-sm submit" value="SUBMIT"  onclick="return committeenamecheck('addcommitteefrm');" >SUBMIT</button>
								
								<button type="button" class="btn btn-primary btn-sm back" onclick="backsub();">BACK</button>
																					
							</div>
						</div>
					</div>					
				</form>
					<form method="post" action="CommitteeList.htm" name="backfrm" id="backfrm">
						<input type="hidden" name="projectid" value="<%=projectid%>">
						<input type="hidden" name="projectappliacble" value="<%=projectappliacble%>">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />					
					</form>
			
					</div>
					<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ">
					</div>
				</div>
			</div>
		</div>

	

<script type="text/javascript">
$('#projectid').select2();

function committeenamecheck(frmid){
	
	var projectidd=$('#projectid').val();
	
	
	var fullname=$('#committeename').val().trim();
	var shortname=$('#committeeshortname').val().trim();
	var proapplicable=$('#proapplicable').val().trim();
	var ctype=$('#ctype').val();
	var technontech=$('#technontech').val();
	
	var periodic=$('#periodic').val();
	var periodicduration=$('#periodicdurationfield').val().trim();
	var guidelines=$('#guidelines').val().trim();
	var description=$('#description').val().trim();
	var TOR=$('#TOR').val().trim();
	
	$.ajax({

		type : "GET",
		url : "CommitteeNamesCheck.htm",
		data : {
			
			fname:fullname.trim(),
			sname:shortname.trim(),
			
		},
		datatype : 'json',
		success : function(result) {
			var ajaxresult = JSON.parse(result);
			var count=0;
			if(ajaxresult[0]==1){
			
				alert('Commitee Code Already Exists');
				count++;
				return false;
			}
			if(ajaxresult[1]==1){
				
				alert('Commitee Name Already Exists');
				count++;
				return false;
			}			
			if(count==0)
			{
				if(confirm('Are you Sure To Save ?'))
				{
					if(fullname==="" ||shortname==="" ||proapplicable==="" || ctype===null || technontech==="" || periodic==="" || guidelines==="" || description==="" || TOR==="" || ( periodic==="P" && ( periodicduration==="0" ||  periodicduration==="") )  ) 
					{
						alert('Please Fill All the Fields ? ');
						
					}else
					{
						submitForm(frmid);
					}
				}
				else
				{
					
					return false;
				}
				
				
			}	else {
				return false;
				
			}	
		}
	});	
}

</script>
<script type='text/javascript'> 

$('#projectid').select2();

function backsub(){
		$('#backfrm').submit();
		}



function submitForm(myform)
{ 
  document.getElementById(myform).submit(); 
} 


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