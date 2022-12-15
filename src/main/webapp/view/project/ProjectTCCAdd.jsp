<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title> TCC  ADD</title>
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
.card b{
	font-size: 20px;
}

</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
List<Object[]> ProjectListForCommeet=(List<Object[]>) request.getAttribute("ProjectListForCommeet");


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
<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;margin-top: ">
        
                    <b class="text-white">Technical Council Committe Add</b>
           
        </div>
        
        <div class="card-body">
        <form action="ProjectCommitteeCreate.htm" method="POST" name="myfrm" id="myfrm">
                <div class="row">
                    <div class="col-md-12 ">
                        <div class="form-group">
                            <label class="control-label">Project</label>
                            <select class="custom-select" id="IntiationId" required="required" name="IntiationId" >
    <option disabled="true"  selected value="">Choose...</option>
    <% for (Object[] obj : ProjectListForCommeet) {%>
<option value="<%=obj[0]%>"><%=obj[2]%>(<%=obj[1]%>)</option>
<%} %>
   
  </select>
                        </div>
                    </div>
                    </div>
                    
                     <div class="row">
                    <div class="col-md-6 ">
                        <div class="form-group">
                            <label class="control-label">Chairperson</label>
                              <select class="custom-select" id="ChairMain" required="required" name="ChairMain">
    <option disabled="true"  selected value="">Choose...</option>
    <% for (Object[] obj : EmployeeList) {%>
<option value="<%=obj[0]%>"><%=obj[1]%></option>
<%} %>
  </select>
                        </div>
                    </div>
                   
         <div class="col-md-6 ">
                        <div class="form-group">
                            <label class="control-label">Secretary</label>
    <select class="custom-select" id="secretary" required="required" name="Secretary">
    <option disabled="true"  selected value="">Choose...</option>
    <% for (Object[] obj : EmployeeList) {%>
<option value="<%=obj[0]%>"><%=obj[1]%> ( <%=obj[2] %> )</option>
<%} %>
  </select>
                        </div>
                    </div>
                    
                    
       
           

                    
                    
                    
                                   
              
                </div>

            
      		<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
													<thead>  
												<tr id="Memberrow0" ><th >Member Name</th><th><i class="btn btn-sm fa fa-plus" style="color: green;"  onclick="MemberAdd()"></i></th></tr>
													
													<input type="hidden"  id="MemberAdd" value="0" />
													<tr id="Memberrow0">
			<td ><select class="form-control "name="Member" id="Member0" required="required" style=" font-weight: bold; text-align-last: left; width: 500px;" data-live-search="true" data-container="body">
																
	          <option disabled="true"  selected value="">Choose...</option>
			    <% for (Object[] obj : EmployeeList) {%>
     <option value="<%=obj[0]%>"><%=obj[1]%></option>
    <%} %>					
</select>
</td>									
                                                       
														
													
					 <td><i class="btn btn-sm fa fa-minus" style="color: red;" id="MemberMinus0" onclick="Memberremove(this)" ></i></td>								
													</tr>
													</thead>
													</table>
      
      
         
        <div class="form-group">
<center>

 <input type="submit" class="btn btn-primary btn-sm submit " onclick="Add(myfrm)" value="SUBMIT"> 
<!--  <a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm"  >Back</a> -->
</center>
</div>

	<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> 
 	</form>
        
     </div>    
        







<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ">
         
       
        </div>
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
</body>
</html>