<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>PROJECT  ADD</title>
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
List<Object[]> ProjectMainListNotAdded=(List<Object[]>) request.getAttribute("ProjectMainListNotAdded");
List<Object[]> ProjectMainList=(List<Object[]>) request.getAttribute("ProjectTypeMainList");
List<Object[]> OfficerList=(List<Object[]>) request.getAttribute("OfficerList");
List<Object[]> CategoryList=(List<Object[]>) request.getAttribute("CategoryList");
List<Object[]> ProjectTypeList=(List<Object[]>) request.getAttribute("ProjectTypeList");
List<Object[]> ProjectCatSecDetalis=(List<Object[]>) request.getAttribute("ProjectCatSecDetalis");
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
	</div></center>
                    <%} %>



<div class="container-fluid">

<div class="col-md-12">
<div class="card shadow-nohover" >
<div class="card-header"><h4>Project Add</h4>  </div>

<!-- -----------------------------------------------------------------------------------body -------------------------- -->
<div class="card-body" > 
<div class="row">


	<div class=" col-md-12 " >
			<table class="table table-bordered table-hover table-striped table-condensed " style="border: 1px solid black !important;background-color:white;font-family: 'Montserrat', sans-serif; width: 50%;" >
				<tr>
					<th>
						<label style="margin-bottom: -10px;"> Is Main Project </label>
					</th>
					 <td >
							<select required="required" id="ismaincheck" class="form-control form-control selectdee"
							  data-live-search="true" onchange="validateismaincheck()">
								<option disabled="disabled" selected="selected" value="">Choose...</option>
								<option  value="Y">Yes</option>
								<option  value="N">No</option>
							</select>
					</td>
					</tr>
				</table>
	</div>
	<div class=" col-md-12 " id="mainddlist" style="display: none;" >
				<form action="ProjectSubmit.htm" method="post">
						<table class="table table-bordered table-hover table-striped table-condensed " style="border: 1px  !important;background-color:white;font-family: 'Montserrat', sans-serif; width: 60%; "  >
						 
							<tr>
							<th style="width: 26%" >
								<label style="margin-bottom: -10px;"> Project Main: <span class="mandatory" style="color: red;">*</span></label>
							</th>
							
							<td >
								<select name="projectmainid" class="form-control form-control selectdee" 
								data-width="100%" data-live-search="true" required="required">
									<option disabled="disabled" selected="selected" value="">Choose...</option>
									<%for(Object[] protype:ProjectMainListNotAdded ){%>
										<option value="<%=protype[0] %>"><%=protype[1] %></option>
									<%} %>
								</select>
							</td>
							<td align="center" >
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="action" value="mainaddsubmit" />
								<button type="submit" class="btn btn-sm submit" > SUBMIT</button>
							</td>
							
						</tr>
					</table>
			</form>
	</div>


<script type="text/javascript">
function validateismaincheck()
{
	var ismain=$('#ismaincheck').val();
	if(ismain==='Y')
		{
			$('#mainddlist').css('display', 'block');3
			$('#isnotmain').css('display', 'none');
		
		}else if(ismain==='N')
		{
			$('#isnotmain').css('display', 'block');
			 $('#mainddlist').css('display', 'none');
		}
}
</script>





<div class=" col-md-12 " style="display:none;" id="isnotmain">
<form class="form-horizontal" role="form" action="ProjectSubmit.htm" method="POST">

<div class="tables">
  <div class="table-responsive">
  
	  
   <table class="table table-bordered table-hover table-striped table-condensed " style="border: 1px solid black !important;background-color:white;font-family: 'Montserrat', sans-serif;" >
<thead>


<tr>
<th>
<label style="margin-bottom: -10px;"> Project Main: <span class="mandatory" style="color: red;">*</span></label>
</th>
<td >
					<select required="required" id="selectbasic" name="projecttype" class="form-control form-control selectdee" data-width="100%" data-live-search="true" onchange="pmainchange();">
							<option disabled="disabled" selected="selected" value="">Choose...</option>
								<%for(Object[] protype:ProjectMainList ){
	
	                           %>
								<option value="<%=protype[0] %>"><%=protype[1] %></option>
								<%} %>
					</select>
</td>


  
<th>
<label style="margin-bottom: -10px;"> Project Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td>
<input type="text"   name="pname"  class="form-control" maxlength="255" required="required">

</td>
</tr>
<tr>
<th>
<label style="margin-bottom: -10px;"> Project Number:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
<td>
<input type="text"  name="desc"	class="form-control" maxlength="100" required="required">
 
</td>
<th>
<label style="margin-bottom: -10px;"> Project Unit Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
<td >
<input type="text"   name="unicode"	class="form-control" maxlength="20" required="required" >
 
</td>
 </tr>
 
  <tr>
 <th>
<label style="margin-bottom: -10px;"> Project Director:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
<td>
<select required="required" name="projectdirector" class="form-control form-control selectdee" id="officerPunchNo" data-width="100%" data-live-search="true" style="width: 100%">
						<option disabled="disabled" selected="selected" value="">Choose...</option>
							<%for(Object[] protype:OfficerList ){
	
	                           %>
								<option value="<%=protype[0] %>"><%=protype[2].toString() %> , <%=protype[3].toString() %></option>
								<%} %>
							</select>
</td>


<th>
<label style="margin-bottom: -10px;"> Project Short Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
<td>
 <input type="text"   name="projectshortname"	class="form-control" maxlength="20" required="required">
</td>
<!--   <th>
 <label style="margin-bottom: -10px;"> IsMainWorkCenter:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
	<select name="ismainwc" class="form-control selectpicker" data-width="100%">
							<option value="1">Yes</option>
							<option value="0">No</option>
							</select>
 
</td> -->
</tr>
 
<tr>
<%-- <th>
<label style="margin-bottom: -10px;"> Project Director:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
<td>
<select required="required" name="projectdirector" class="form-control form-control selectdee" id="officerPunchNo" data-width="100%" data-live-search="true">
							<%for(Object[] protype:OfficerList ){
	
	                           %>
								<option value="<%=protype[0] %>"><%=protype[2].toString() %></option>
								<%} %>
							</select>
</td> --%>
  <th>
 <label style="margin-bottom: -10px;"> End User:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
	<select name="enduser" 	class="form-control  form-control selectdee" data-width="100%" data-live-search="true">
							<option disabled="disabled" selected="selected" value="">Choose...</option>
							<option value="IA">Indian Army</option>
							<option value="IN">Indian Navy</option>
							<option value="IAF">Indian Air Force</option>
							<option value="HLS">Home Land Security</option>
							<option value="DRDO">DRDO</option>
							<option value="OH">Others</option>
	</select>
</td> 
<th>
 <label style="margin-bottom: -10px;"> Project Code:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 <input type="text"   name="pcode"
								class="form-control" maxlength="20" required="required">
 
</td>

<!--   <th>
 <label style="margin-bottom: -10px;"> WorkCenter Name:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input type="text"  name="wcname" class="form-control" maxlength="100" required="required">
 
</td> -->
</tr>
<tr>
<th>
<label style="margin-bottom: -10px;"> Project Sanc Authority:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
<td >
<!-- <input type="text"  class="form-control"  name="ProjectsancAuthority" maxlength="100" required="required">
 -->
<select required="required"
	name="ProjectsancAuthority"
	class="form-control  form-control selectdee"
	data-width="100%"
	data-live-search="true" >
		<option disabled="disabled" value="" selected="selected">Choose..</option>		
		<option value="DIR" >DIR</option>
		<option value="DG" >DG</option>
		<option value="SECY" >SECY</option>
		<option value="RM" >RM</option>
		<option value="FM" >FM</option>
		<option value="CCS" >CCS</option>
</select>

</td>
<th>
<label style="margin-bottom: -10px;"> Project Sanction No:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
<td >
<input type="text"   name="sano" class="form-control" maxlength="100" required="required">
</td>
</tr>

<tr>
<th>
<label style="margin-bottom: -10px;"> Project Sanction Date:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input type="text"  data-date-format="dd/mm/yyyy"  readonly id="sanc-date" name="sadate" value=""
								class="form-control form-control">
</td>
  <th>
 <label style="margin-bottom: -10px;">Total Sanction Cost (&#8377;):
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input type="text"   id="totalcostid" name="tsancost" value="0.0" class="form-control number-only" required="required"  >
</td>
 </tr>
 
    <tr>
  <th>
 <label style="margin-bottom: -10px;"> Board Of  Reference:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<!-- <input type="text" name="bor" class="form-control" maxlength="50" required="required">
 -->

	<select required="required"
			name="bor"
			class="form-control  form-control selectdee"
			data-width="100%"
			data-live-search="true" >
				<option disabled="disabled" value="" selected="selected">Choose..</option>
				<option value="DMC" >DMC</option>
				<option value="CCM" >CCM</option>														
	</select>



</td>
  <th>
 <label style="margin-bottom: -10px;"> Sanction Cost FE (&#8377;):
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input type="text"   id="fecostid" name="sancostfe"
								class="form-control number-only" value="0.0" maxlength="18" required="required">
</td>
 </tr>
 
 <tr>
  <th>
 <label style="margin-bottom: -10px;">PDC:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input  id="pdc-date"  data-date-format="dd/mm/yyyy" readonly name="pdc" value=""
								class="form-control form-control">
</td>


<th>
 <label style="margin-bottom: -10px;"> Sanction Cost RE (&#8377;):
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
<input type="text"  name="sancostre" id="Recostid"
								class="form-control number-only" value="0.0" maxlength="18" value="0.0" readonly="readonly">
</td>

 </tr>
   <tr>
   <th><label style="margin-bottom: -10px;"> Category: <span class="mandatory" style="color: red;">*</span></label></th>
   <td><select required="required" id="selectbasic1" class="form-control form-control selectdee"
								data-width="100%" data-live-search="true" disabled="disabled" >
															<%
															for (Object[] protype : ProjectTypeList) {
															%>
															<option value="<%=protype[0]%>" <%if(ProjectCatSecDetalis.size()>0 && protype[0].toString().equals(ProjectCatSecDetalis.get(0)[0].toString()) ){ %> selected="selected" <%} %>><%=protype[1]%></option>
															<%
															}
															%>
													</select>
													<input name="projectTypeID" id="projectTypeIDid" hidden="hidden" <%if(ProjectCatSecDetalis.size()>0){ %> value="<%=ProjectCatSecDetalis.get(0)[0].toString() %>" <%} %>>
													</td>
                                 
  <th>
 <label style="margin-bottom: -10px;"> Security Classification:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 					<td >
						<select required="required"  class="form-control form-control selectdee" id="selectbasic2" 
						data-width="80%" disabled="disabled">
							<%for(Object[] protype:CategoryList ){ %>
								<option value="<%=protype[0]%>" <%if(ProjectCatSecDetalis.size()>0 && protype[0].toString().equals(ProjectCatSecDetalis.get(0)[1].toString()) ){ %> selected="selected" <%} %>><%=protype[1].toString() %></option>
							<%} %>
						</select>
						<input name="projectcategory" id="projectcategoryID" hidden="hidden" <%if(ProjectCatSecDetalis.size()>0){ %> value="<%=ProjectCatSecDetalis.get(0)[1].toString() %>" <%} %>>
					</td>

 </tr>
  <tr>
<!--   <th colspan="1">
 <label style="margin-bottom: -10px;">Nodal & Participating Lab:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="3">
	<textarea required="required"  name="Objective" class="form-control " maxlength="5000" rows="5" cols="53"></textarea>
</td>
 </tr> -->
 <tr>
  <th colspan="1">
 <label style="margin-bottom: -10px;"> Objective:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="3">
	<textarea required="required"  name="Objective" class="form-control " maxlength="5000" rows="5" cols="53"></textarea>
</td>
 </tr>
  <tr>
  <th colspan="1">
 <label style="margin-bottom: -10px;"> Deliverable:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td colspan="3">
	<textarea required="required" name="Deliverable" class="form-control "  maxlength="5000" rows="5" cols="53"></textarea>
</td>
 </tr>
 </thead>
 </table>
 </div>
 </div>
				
	
								<div align="center">
									<table>
										<tr>
											<td>
												<button type="submit" name="action" value="submit" class="btn btn-primary btn-sm submit" onclick="return confirm('Are You Sure To Submit!')">Submit</button>
											</td>
											<td>
											    <a class="btn btn-info btn-sm shadow-nohover back" href="ProjectList.htm">Back</a>
											</td>
										</tr>
									</table>
								</div>
		
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

					</form>
				</div>
			</div>
		</div>
		
<!-- -----------------------------------------------------------------------------------body -------------------------- -->		

	</div>
</div>


</div>
  

<script type="text/javascript">

$('#currentdate,#datepicker').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"startDate" : new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});


$(document).ready(function () {
	
	   $('#totalcostid,#fecostid').on('change', function () {
		   var tcost = $('#totalcostid').val();      
	       var fcost = $('#fecostid').val();
	       var tid = parseFloat(tcost.replace(/[^0-9.-]+/g,""));
	       var fid = parseFloat(fcost.replace(/[^0-9.-]+/g,""));
	       var total =tid-fid ;
	       $("#Recostid").val(total);
	       
	   });
	});
function pmainchange(){
	$.ajax({
        type: "get",
        url: "projectCatSencDetalis",
        data: {
			project : $('#selectbasic').val()
		},
		datatype : 'json',
        success: function(result){      
        	var values = JSON.parse(result);
        	$('#selectbasic1').val(values[0][0]).change();        	
        	console.log(values[0][0]);console.log(values[0][1]);
         	$('#selectbasic2').val(values[0][1]).change();
         	$('#projectTypeIDid').val(values[0][0]);
        	$('#projectcategoryID').val(values[0][1]); 	
        }
    });
}

$(function(){

	  $('.number-only').keypress(function(e) {
		  if( e.keyCode === 8  ) {
		        return true; // backspace (8) / delete (46)
		    }
		if(isNaN(this.value+""+String.fromCharCode(e.charCode))) return false;
	  })
	  .on("cut copy paste",function(e){
		e.preventDefault();
	  });

	});
</script>

<script type="text/javascript">

var fromDate=null;
$("#sanc-date").change( function(){	
	 fromDate = $("#sanc-date").val();
	 
	var date1=fromDate.split("-");
	var date= new Date(date1[1]+' '+date1[0]+' '+date1[2]);
		
		$('#pdc-date').daterangepicker({
			
			"singleDatePicker": true,
			"showDropdowns": true,
			"cancelClass": "btn-default",
			"minDate":fromDate,
			"startDate":date ,
			locale: {
		    	format: 'DD-MM-YYYY'
				}
		});
		
});

$('#sanc-date').daterangepicker({
	
	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	/* "minDate":new Date(), */
	"startDate":new Date(), 
	locale: {
    	format: 'DD-MM-YYYY'
		}
});
</script>

</body>
</html>