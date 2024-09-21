<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>OFFICER MASTER ADD</title>

</head>
<body>


<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> DesignationList=(List<Object[]>)request.getAttribute("DesignationList");
List<Object[]> DivisionList=(List<Object[]>)request.getAttribute("OfficerDivisionList");
List<Object[]> LabList=(List<Object[]>)request.getAttribute("LabList");
List<Object[]> OfficerList = (List<Object[]>)request.getAttribute("OfficerList");
%>


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<center>
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </center>
    
    
                    <%} %>


	

<div class="container-fluid">		
<div class="row"> 


<div class="col-sm-2"></div> 
	
 <div class="col-sm-8"  style="top:0px;">
<div class="card shadow-nohover"  >
<div class="card-header" style=" background-color: #055C9D;margin-top: "> <h4><b class="text-white">Officer Add</b></h4> </div>
<div class="card-body">


<form name="myfrm" action="OfficerMasterAddSubmit.htm" method="POST" id="myfrm" autocomplete="off">

<div class="row">
  
     <input type="hidden" name="labId" value="<%= session.getAttribute("labid")%>">
 
<div class="col-md-3">
              <div class="form-group">
					<label >Employee No:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="text" id="EmpNo"  name="EmpNo" required="required" maxlength="6" style="font-size: 15px;width:100%;text-transform: uppercase;"
					 placeholder="Employee No"/>
				</div>
</div>
<div class="col-md-3">
					 <div class="form-group">
			                <label>Rank/Salutation</label><br>
			                 <select class="form-control selectdee" id="title"  name="title" data-container="body" data-live-search="true"  style="font-size: 5px;">
								<option value=""  selected="selected"	hidden="true">--Select--</option>
								<option value="Prof.">Prof.</option>
								<option value="Lt.">Lt.</option>
								<option value="Dr.">Dr.</option>
								
							</select>
					</div>
</div>
<div class="col-md-3">
					 <div class="form-group">
			                <label>Title</label><br>
			                 <select class="form-control selectdee"  id="salutation" name="salutation" data-container="body" data-live-search="true"   style="font-size: 5px;">
								<option value=""  selected="selected"	hidden="true">--Select--</option>
								<option value="Mr.">Mr.</option>
								<option value="Ms.">Ms.</option>
							</select>
					</div>
	</div>
<div class="col-md-3">
              <div class="form-group">
					<label >Employee Name:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="text" name="EmpName"  id="EmpName"  required="required" maxlength="50" style="font-size: 15px;width:100%;text-transform: capitalize;" 
					 placeholder="Employee Name" onkeydown="return /[a-z ]/i.test(event.key)">
			  </div>
</div>
</div>

<div class="row">
<div class="col-md-3">
              <div class="form-group">
					<label >Designation:<span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control selectdee" id="Designation" name="Designation" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
								<option value="" disabled="disabled" selected="selected"	hidden="true">--Select--</option>					
										<%  for ( Object[]  obj :DesignationList) {%>			
										<option value="<%=obj[0] %>"> <%=obj[2] %></option>			
										<%} %>
					</select> 
			</div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Extension No:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control" type="text" id="ExtNo" name="ExtNo" required="required" maxlength="4" style="font-size: 15px;width:100%" 
					 placeholder="Extension Number" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"/>
			 </div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Mobile No:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control" type="text" id="mobilenumber" value="" name="mobilenumber" maxlength="10" style="font-size: 15px;width:100%"
					placeholder="Phone No" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
				</div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Lab Email:<span class="mandatory" style="color: red;">*</span></label>
					<input  class="form-control form-control"  type="email" name="Email" id="Email" required="required" maxlength="40" style="font-size: 15px;width:100%" placeholder="Lab Email">
			 </div>
</div>
</div>

<div class="row">
<div class="col-md-3">
              <div class="form-group">
					<label >Drona Email:</label>
					<input  class="form-control form-control"  type="email" name="DronaEmail" id="DronaEmail" required="required" maxlength="40" style="font-size: 15px;width:100%" placeholder="Drona Email">
			  </div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Internet Email:</label>
                    <input  class="form-control form-control"  type="email"id="InternetEmail" name="InternetEmail" required="required" maxlength="40" style="font-size: 15px;width:100%" placeholder="Internet Email">
			   </div>
</div>

<div class="col-md-3">
              <div class="form-group">
					<label >Division:<span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control selectdee" id="Division" name="Division" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
									<option value="0" selected="selected"	hidden="true">--Select--</option>
											<%  for ( Object[]  obj :DivisionList) {%>			
											<option value="<%=obj[0] %>"> <%=obj[1] %></option>			
											<%} %>
					
					</select> 
			 </div>
</div>

<div class="col-md-3">
	<div class="form-group">
		<label >Superior Officer:<span class="mandatory" style="color: red;">*</span></label>
		<select class="form-control selectdee" id="superiorOfficer" name="superiorOfficer" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
			<option value="0" selected="selected" hidden="true">--Select--</option>
			<%  for ( Object[]  obj :OfficerList) {%>			
				<option value="<%=obj[0] %>"> <%=obj[2]+", "+obj[3] %></option>			
			<%} %>
		</select> 
	</div>
</div>

</div>

<div class="row">
<div class="col-sm-5" ></div>
	<input type="button" value="SUBMIT"  class="btn btn-primary btn-sm submit" onclick="return empNoCheck('myfrm');" />
	<button type="submit" class="btn btn-info btn-sm shadow-nohover back" style="margin-left: 1rem;" formaction="Officer.htm" formmethod="get" formnovalidate="formnovalidate" >BACK</button>
</div>

	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"  />
	 
	 
	  </form>
	
	
	  </div>
	  </div>
	  </div>
	 
	 <div class="col-sm-2"></div> 
	 
	  </div>
	
</div>	
	


		<script type="text/javascript">
		
		
		
		
		function empNoCheck(frmid)
		{
			var EmpName=$('#EmpName').val().trim();
			var Designation=$('#Designation').val();
			var ExtNo=$('#ExtNo').val().trim();
			var mobilenumber=$('#mobilenumber').val().trim();
			var Email=$('#Email').val().trim();	
			var DronaEmail=$('#DronaEmail').val().trim();
			var InternetEmail=$('#InternetEmail').val().trim();
			var Division=$('#Division').val();
			var title=$('#title').val();
			var salutation=$('#salutation').val();
			var $empno=$('#EmpNo').val().trim();
			
			if($empno==="" ||EmpName==="" ||Designation===null || ExtNo===null || mobilenumber==="" ||  Division===null ) 
			{
				alert('Please Fill All the Mandatory Fields ');
			}else if(!Email.includes("@")){
				alert('please use correct email format(E.g. abc1@gmail.com)')
			} 
			
			else if((title==="" && salutation==="")||(title!=="" && salutation!=="")){
				alert('Please select either Title or Rank');
			}
			else if(isNaN(mobilenumber))
				{
				alert(' Enter Proper Mobile Number ');
				}
			else if(isNaN(ExtNo))
			{
			alert(' Enter Proper Extension Number ');
			}
			
			else
			{
					$.ajax({
						
						type : "GET",
						url : "EmpNoCheck.htm",
						data : {
							
							empno : $empno
							
						},
						datatype : 'json',
						success : function(result) {
							var count=0;
							if(result==='1' ){
								
								alert('Employee No Already Exists');
								count++;
								return false;
							}
								
							if(count==0)
							{
								if(confirm('Are you Sure To Save ?'))
								{
									$('#'+frmid).submit();
								}
								else
								{
									return false;
								}
							}
						}
					});
				}
		}
		</script>
		<script>
		
		    </script>
		    
	</body>
</html>