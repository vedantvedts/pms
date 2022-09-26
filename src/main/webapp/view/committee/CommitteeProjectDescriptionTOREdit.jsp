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
Object[] committeeprojectdata=(Object[])request.getAttribute("committeeprojectdata"); 
Object[] committeemaindata=(Object[])request.getAttribute("committeemaindata");
String committeemainid=committeemaindata[0].toString();
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
    
    
	<div class="container">

		<div class="row">

			<div class="col-md-12">

				<div class="card shadow-nohover">
					<div class="card-header"
						style=" background-color: #055C9D;margin-top: ">

						<b class="text-white">Description and Terms of Reference</b>

					</div>
					<form action="ProjectCommitteeDescriptionTOREditSubmit.htm" method="post" name="addcommitteefrm" id="addcommitteefrm" >
					
						<div class="card-body">				
						
					
						<div class="row">
							<div class="col-md-6">
								
								<div class="form-group">
									<label class="control-label">Description</label>
									<textarea class="form-control"  name="description" required placeholder="Enter Description" rows="5" cols="50" maxlength="1000"><%if(committeeprojectdata[1]!=null){ %><%=committeeprojectdata[1] %>   <% }%></textarea>
								</div>

							</div>
							<div class="col-md-6">
								
								<div class="form-group">
									<label class="control-label">Terms Of Reference </label>
									<textarea class="form-control"  name="TOR" required placeholder="Enter Terms Of Reference" rows="5" cols="50" maxlength="1000"><%if(committeeprojectdata[2]!=null){ %><%=committeeprojectdata[2] %>   <% }%></textarea>
								</div>

							</div>
						</div>
					</div>
					<div class="row" >
					<div class="col-md-5"></div><div class="col-md-3"  style="margin-bottom: 15px;" > 
						
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								
								
								<input type="hidden" name="committeeprojectid" value="<%=committeeprojectdata[0] %>" />
								<input type="hidden" name="committeemainid" value="<%=committeemainid %>" />
								
							
							<button type="submit" class="btn btn-sm edit" value="SUBMIT"  onclick="return confirm('Are You Sure Update ?');" >UPDATE</button>
							<button type="button" class="btn btn-primary btn-sm back" onclick="submitForm('backfrm')" >BACK</button>
					</form>
					
								
							<form action="CommitteeMainMembers.htm" method="post" id="backfrm">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="committeemainid" value="<%=committeemainid %>" />	
							</form>
						
						
						</div>
					</div></div>
					</div>
					</div>
					<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px; ">
					</div>
				</div>
			</div>
		</div>
		<div class="modal" id="loader">
			<!-- Place at bottom of page -->
		</div>

	
<script type='text/javascript'> 
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