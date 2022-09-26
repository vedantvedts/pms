<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>LOGIN TYPE Edit</title>
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


/*new  */

.breadcrumb{
    padding: 15px 15px 15px 50px;
    margin: 0;
    /* background: #12abb3; */
    background: #1e3c72;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #2a5298, #1e3c72);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #2a5298, #1e3c72); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
    
    border-radius: 5px !important;
    overflow: hidden;
    font-family: 'Muli',sans-serif;
}
.breadcrumb li{
    float: left;
    position: relative;
}
.breadcrumb li:first-child{
    width: 70px;
    height: 70px;
    border-radius: 50%;
    background: #12abb3;
    box-shadow: 0 0 50px 0 rgba(0, 0, 0, 0.2);
    text-align: center;
    position: absolute;
    top: -10px;
    left: -10px;
    z-index: 1;
    transition: all 0.1s ease 0s;
}
.breadcrumb li:hover:first-child{ transform: scale(1.1); }
.breadcrumb li:first-child a{
    font-size: 30px;
    line-height: 70px;
}
.breadcrumb > li:first-child + li:before{ display: none; }
.breadcrumb li.active,
.breadcrumb li a{
    font-size: 14px;
    color: #fff;
}



</style>
</head>
<body>

<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> LoginTypeList=(List<Object[]>) request.getAttribute("LoginTypeList");
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
List<Object[]> RoleList=(List<Object[]>) request.getAttribute("RoleList");
DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
Object[] LoginTypeEditData=(Object[]) request.getAttribute("LoginTypeEditData");
%>



<%
String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	
	
<div align="center">	

	<div class="alert alert-danger" role="alert">
           <%=ses1 %>
    </div>
    
	<%}if(ses!=null){ %>
	
	<div class="alert alert-success" role="alert" >
          <%=ses %>
    </div>
            
</div>
    
  <%} %>
	
<!-- <div class="container" >
<div class="row">

<div class="col-md-12">
	<ol class="breadcrumb">
		<li><a href="MainDashBoard.htm" class="fa fa-home"></a></li>
		<li><a href="LoginTypeList.htm">Login Type List &nbsp;&nbsp;&nbsp;<i class="fa fa-chevron-right fa-4x" aria-hidden="true"></i></a></li>
		<li><a href="#">Login Type Edit</a></li>
		<li><a href="#">Modify</a></li>
		<li class="active"><a>Login Type Edit</a></li>	    	    
	</ol>
	
	<br>
</div>
</div>
</div>	 -->

<br>
	
<div class="container">
	<div class="row" style="">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">Login Type Edit</b>
        		</div>
        
        		<div class="card-body">
        			<form action="LoginTypeEditSubmit.htm" method="POST" name="myfrm" id="myfrm">
                		<div class="row">

                    		<div class="col-md-4 ">
                        		<div class="form-group">
                            		<label class="control-label">Username (Employee)</label>
                              		 <input  class="form-control form-control"  type="text"   readonly   value="<%=(LoginTypeEditData[0]) %> (<%=(LoginTypeEditData[1]) %>)">
                        		</div>
                    		</div> 
               
         					<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">Role</label>
    								<select class="custom-select" id="RoleId" required="required" name="RoleId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : RoleList) {%>
												<option value="<%=obj[0]%>" <%if(LoginTypeEditData[3].toString().equalsIgnoreCase(obj[1].toString())){ %> selected="selected" <%} %>><%=obj[1]%></option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                    
                    
                </div>

            
      	
         
        <div class="form-group" align="center" >
			
			
	 		<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub"  > 
			<!--  <a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm"  >Back</a> -->
		
		</div>

	<input type="hidden" name="LoginId" value="<%=LoginTypeEditData[4] %>">
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 	</form>
        
     </div>`     
        




<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ">
         
       
        </div>
        </div>
</div>
</div>
</div>	
	
	
<script type="text/javascript">

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
	
function Add(myfrm){
	
	event.preventDefault();
	
	bootbox.confirm({ 
 		
	    size: "small",
			message: "<center><i class='fa fa-trash-o fa-3x' aria-hidden='true'></i>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure ?</b></center>",
	    buttons: {
	        confirm: {
	            label: 'Yes',
	            className: 'btn-success'
	        },
	        cancel: {
	            label: 'No',
	            className: 'btn-danger'
	        }
	    },
	    callback: function(result){ 
	 
	    	if(result){
	    	
	    		$("sub").value;
	         $("#myfrm").submit(); 
	    	}
	    	else{
	    		event.preventDefault();
	    	}
	    } 
	}) 
	
	
}


$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 5
	})
})



</script>
<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>