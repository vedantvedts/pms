<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.requirements.model.SpecificationMaster"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta charset="ISO-8859-1">

<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/js/excel.js" var="excel" />
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />



<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<style>

label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}
 .toggle-switch {
       position: relative;
       display: inline-block;
       width: 60px;
       height: 34px;
   }

   .toggle-switch input {
       display: none;
   }
    .toggle-switch .label {
       margin-left: 10px;
       vertical-align: middle;
       font-weight: bold;
       font-size: 18px;
   }
      .slider {
       position: absolute;
       cursor: pointer;
       top: 0;
       left: 0;
       right: 0;
       bottom: 0;
       background-color: #ccc;
       transition: .4s;
       border-radius: 34px;
   }

   .slider:before {
       position: absolute;
       content: "";
       height: 26px;
       width: 26px;
       left: 4px;
       bottom: 4px;
       background-color: white;
       transition: .4s;
       border-radius: 50%;
   }

   input:checked + .slider {
       background-color: green;
   }

   input:checked + .slider:before {
       transform: translateX(26px);
   }
body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}




.multiselect {
	padding: 4px 90px;
	background-color: white;
	border: 1px solid #ced4da;
	height: calc(2.25rem + 2px);
}


#container {
    background-color: white;
    display: inline-block;
    margin-left: 2%;
    margin-top: 1%;
 
}



</style>
</head>
<body>

<%
SpecificationMaster sp = (SpecificationMaster)request.getAttribute("SpecificationMaster");
List<Object[]>systemList = (List<Object[]>)request.getAttribute("systemList");
List<Object[]>productTreeList = (List<Object[]>)request.getAttribute("productTreeList");
List<Object[]>subSpecificationList = (List<Object[]>)request.getAttribute("subSpecificationList");
String mainId = sp.getMainId()!=null ?sp.getMainId().toString():"0";
String specid = sp.getSpecsInitiationId()!=null ?sp.getSpecsInitiationId().split("_")[0].toString():"0";
List<Object[]>subLevel1Child=new ArrayList<>();
int NumberOfChild=subLevel1Child.size();
String HasChild = "N";//for edit I am taking this value
String hasUnit = sp.getSpecsUnit()!=null&& sp.getSpecsUnit().length()>0 ?"Y":"N";
if(subSpecificationList!=null && subSpecificationList.size()>0 && sp.getSpecsMasterId()!=null){
	subLevel1Child=subSpecificationList.stream().filter(e->e[14].toString().equalsIgnoreCase(sp.getSpecsMasterId()+"")).collect(Collectors.toList());
	NumberOfChild=subLevel1Child.size();
	if(NumberOfChild>0){
		HasChild="Y";
	}
}
%>
			<div class="container" id="container" style="max-width:95%">
			<form action="specificationMasterAddSubmit.htm" method="POST">
			<div class="row" id="row1">
			
				<div class="col-md-12" id="reqdiv" style="background: white;">
					<div class="card-body" id="cardbody">
							<div class="row">
							      <div class="col-md-2">
                            		<label style="font-size: 17px; margin-top: 2%; color: #07689f">System Name :<span class="mandatory" style="color: red;">*</span></label>
                            		</div>
                            		<div class="col-md-2" >
                              		<select class="form-control selectdee" id="sid" required="required" name="sid" onchange="getSubSystem()" >
    									<option disabled selected value="">Choose...</option>
    										<% for (Object[] obj : systemList) {
    										%>
											<option value="<%=obj[0]%>" data-system="<%=obj[2].toString() %>" <%if(sp.getSid()!=null && sp.getSid().toString().equalsIgnoreCase(obj[0].toString())) {%> selected <%} %> > <%=obj[2]%>  </option>
											<%} %>
  									</select>
  									</div>
  									
  									 <div class="col-md-2">
                            		<label style="font-size: 17px; margin-top: 2%; color: #07689f;float: right">Sub-System Name :<span class="mandatory" style="color: red;">*</span></label>
                            		</div>
                            		<div class="col-md-4" >
                              		<select class="form-control selectdee" id="subid" required="required" name="subid" onchange="" >
    								
  									</select>
  									</div>
							</div>
							<br><hr>
								<div class="row">
								<div class="col-md-3">
								   <span> <label style="font-size: 17px; margin-top: 2%; color: #07689f;">Contain child?</label></span>
					               <span><input type="radio" name="IsChild" onchange="getValue('Y')"  <%if(NumberOfChild>0) {%> checked="checked" <%} %>>&nbsp; YES  &nbsp;&nbsp; 
					               <input type="radio" name="IsChild" onchange="getValue('N')" <%if(NumberOfChild==0) {%> checked="checked" <%} %>>&nbsp;&nbsp;&nbsp; NO &nbsp;&nbsp;&nbsp;   </span>                  
								</div>
								<div class="col-md-4" id="childdiv" >
								<span><label style="font-size: 17px; margin-top: 2%; color: #07689f;">Number of Child :</label></span>
								<input type="number" name="numberOfChild" id="childNo" class="form-control" style="width:20%;display: inline" max="50" min="0" value="<%=NumberOfChild %>"oninput="handleChildNoChange(this)">
								</div>
								<div class="col-md-4" id="unitDiv">
								 <span> <label style="font-size: 17px; margin-top: 2%; color: #07689f;">Units Required?</label></span>
					             <span><input type="radio" name="IsUnit" value="Y"  <%if(hasUnit.equalsIgnoreCase("Y")) {%>  checked="checked" <%} %> onchange="getUnits('Y')" >&nbsp; YES  &nbsp;&nbsp; 
					             <input type="radio" name="IsUnit"  value="N" <%if(hasUnit.equalsIgnoreCase("N")) {%>  checked="checked" <%} %> onchange="getUnits('N')" >&nbsp;&nbsp;&nbsp; NO &nbsp;&nbsp;&nbsp;   </span>                  
								</div>
								</div>
								
							
								<div id="mainDiv" >
							<%-- 	<div class="row">
								<div class="col-md-3">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Description: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-9" id="Editor">
			   					<%=sp.getDescription()!=null?sp.getDescription():"" %>

								</div>
    								<textarea name="description" style="display: none;"  id="ConclusionDetails"></textarea>	
								</div> --%>
								
						
						<%-- 	<div class="row mt-2" id="onlyParameterDiv" style="display: none;">
							<div class="col-md-1">
							<label style="font-size: 15px; margin-top: 5%; color: #07689f">Parameter: <span class="mandatory" style="color: red;">*</span></label>
							</div>
							<div class="col-md-4">
							<input type="text" class="form-control" name="specParameter" id="specParameter" required="required" value="<%=sp.getSpecsParameter()!=null?sp.getSpecsParameter():"" %>">
							</div>
							<div class="col-md-2">
							<label style="font-size: 15px; margin-top: 5%; color: #07689f">Parameter value: <span class="mandatory" style="color: red;">*</span></label>
							</div>
							<div class="col-md-3">
							<input type="text" class="form-control" name="specValue" id="specParameterMainValue" required="required" value="">
							</div>
							</div> --%>
							<hr class="mt-2">
								<div class="row mt-2">
								<div class="col-md-2">
								<label style="font-size: 17px; margin-top: 5%; color: #07689f">Description: <span class="mandatory" style="color: red;">*</span></label>
								</div>
								<div class="col-md-9">
			   					<textarea class="form-control" name="description"   id="ConclusionDetails" rows="4" maxlength="1000" placeholder="Maximum 1000 characters"><%=sp.getDescription()!=null?sp.getDescription():"" %></textarea>	
								</div>
    								
								</div>
							<br>
							<div class="row mt-2" id="ParameterDiv" style="">
							<div class="col-md-1">
							<label style="font-size: 15px; margin-top: 5%; color: #07689f">Parameter: <span class="mandatory" style="color: red;">*</span></label>
							</div>
							<div class="col-md-3">
							<input type="text" class="form-control" name="specParameter" id="specParameter" required="required" value="<%=sp.getSpecsParameter()!=null?sp.getSpecsParameter():"" %>">
							</div>
								
							<div class="col-md-1">
							<label style="font-size: 15px; margin-top: 5%;float:right; color: #07689f">Unit: <span class="mandatory" style="color: red;">*</span></label>
							</div>
							<div class="col-md-1">
							<input type="text" class="form-control" name="specUnit" id="specUnit" required="required" value="<%=sp.getSpecsUnit()!=null?sp.getSpecsUnit():"" %>">
							</div>
							<div class="">
							<label style="font-size: 15px; margin-top: 5%;float:right; color: #07689f">Typical Value: <span class="mandatory" style="color: red;">*</span></label>
							</div>
							<div class="col-md-1">
							<input type="text" class="form-control" name="specValue" id="specValue" required="required" value="<%=sp.getSpecValue()!=null?sp.getSpecValue():"" %>">
							</div>
							<div class="">
							<label style="font-size: 15px; margin-top: 5%;float:right; color: #07689f">Min Value: </label>
							</div>
							<div class="col-md-1">
							<input type="text" class="form-control" name="minValue" id="minValue"  value="<%=sp.getMinimumValue()!=null?sp.getMinimumValue():"" %>">
							</div>
							<div class="">
							<label style="font-size: 15px; margin-top: 5%;float:right; color: #07689f">Max Value:</label>
							</div>
							<div class="col-md-1">
							<input type="text" class="form-control" name="maxValue" id="maxValue"  value="<%=sp.getMaximumValue()!=null?sp.getMaximumValue():"" %>">
							</div>
							</div>
							</div>
							<hr class="mt-2">
							<div class="row mt-2" id="tablediv" >
							<table class="table table-bordered table-striped">
							<thead class="bg-primary text-light">
							<tr>
							<th>SN</th>
							<th style="text-align:center;width:20%;">Parameter</th>
							<th style="text-align:center;">Unit</th>
							<th style="text-align:center;">Typical Value &nbsp;/&nbsp;Value</th>
							<th style="text-align:center;">Max Value</th>
							<th style="text-align:center;">Min Value</th>
							<th style="text-align:center;width:30%;">Description</th>
							<th>Action</th>
							</tr>
							</thead>
							<tbody id="tbody">
							<%int count=0;int subrowCount=0;
							for(Object[]obj:subLevel1Child){ %>
							<tr class="main-row" data-row="<%=++count%>">
							<td><%=count%>.</td>
							<td><input type="text" class="form-control specParameter" name="specParameter_<%=count %>" required="required" value="<%=obj[3]!=null?obj[3].toString():"" %>"></td>
							<td><input type="text" class="form-control specUnit" name="specUnit_<%=count %>" required="required" value="<%=obj[4]!=null?obj[4].toString():"" %>"></td>
							<td><input type="text" class="form-control specValue" name="specValue_<%=count %>" required="required" value="<%=obj[6]!=null?obj[6].toString():"" %>">
							</td>
							<td><input type="text" class="form-control maxValue" name="maxValue_<%=count %>" required="required" value="<%=obj[15]!=null?obj[15].toString():"" %>"></td>
							<td><input type="text" class="form-control minValue" name="minValue_<%=count %>" required="required" value="<%=obj[16]!=null?obj[16].toString():"" %>"></td>
							<td>
							<textarea class="form-control description" name="description_<%=count %>" required="required"><%=obj[2].toString() %></textarea></td>
							<td>
							<button type="button" class="btn btn-sm add-sub-row" data-row="<%=count %>"><i class="fa fa-plus" aria-hidden="true" style="color:green"></i></button>
							</td></tr>
							
							<% for(Object[]obj1:subSpecificationList){
							if(obj1[14].toString().equalsIgnoreCase(obj[0].toString())){
							%>
							
							<tr class="sub-row" data-parent="<%=count %>" data-sub-row="<%=++subrowCount%>">
							<td style="text-align:center;"><%=count %>.<%=subrowCount %></td>
							<td><input type="text" class="form-control specParameter" name="<%=count %>_specParameter" required="required" value="<%=obj1[3]!=null?obj1[3].toString():"" %>"></td>
							<td><input type="text" class="form-control specUnit" name="<%=count %>_specUnit" required="required" value="<%=obj1[4]!=null?obj1[4].toString():"" %>"></td>
							<td><input type="text" class="form-control specValue" name="<%=count %>_specValue" required="required" value="<%=obj1[6]!=null?obj1[6].toString():"" %>"></td>
							<td><input type="text" class="form-control maxValue" name="<%=count %>_maxValue" required="required" value="<%=obj1[15]!=null?obj1[15].toString():"" %>"></td>
							<td><input type="text" class="form-control minValue" name="<%=count %>_minValue" required="required" value="<%=obj1[16]!=null? obj1[16].toString():"" %>"></td>
							<td><textarea type="text" class="form-control decription" name="<%=count %>_description" required="required"><%=obj1[2]!=null? obj1[2].toString():"" %></textarea></td>
							<td>
							<button type="button" class="btn btn-sm remove-sub-row" data-parent="<%=count %>"><i class="fa fa-minus" aria-hidden="true" style="color:red"></i></button>
							</td>
							</tr>
							
							
							
							
							<%}} %>
							<%} %>
							</tbody>
							</table>
							</div>
							
								<div align="center" class="mt-2">
								<%if(sp.getSpecsMasterId()!=null){ %>
								<button id="editbtn" type="submit" class="btn btn-sm edit"  onclick="submitData()" name="action" value="update">UPDATE </button>
								<input type="hidden" name="SpecsMasterId" value="<%=sp.getSpecsMasterId()%>">
								<%}else{ %>
								<button id="submitbtn" type="submit" class="btn btn-sm submit" onclick="submitData()" name="action" value="add">SUBMIT </button>
								<%} %>
								<a class="btn btn-info btn-sm back" href="SpecificationMasters.htm">Back</a>
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								</div>
								</div>
								</div>
								</form>	
								</div>
								
	<script>
	$('#Editor').summernote({
		width: 1000,
	     toolbar: [
             // Adding font-size, font-family, and font-color options along with other features
             ['style', ['bold', 'italic', 'underline', 'clear']],
             ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
             ['insert', ['picture', 'table']],  // 'picture' for image upload, 'table' for table insertion
             ['para', ['ul', 'ol', 'paragraph']],
             ['height', ['height']]
         ],
         fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],  // Font size options
         fontNames: ['Arial', 'Courier New', 'Helvetica', 'Times New Roman', 'Verdana'],  // Font family options
         buttons: {
             // Custom superscript and subscript buttons
             superscript: function() {
                 return $.summernote.ui.button({
                     contents: '<sup>S</sup>',
                     tooltip: 'Superscript',
                     click: function() {
                         document.execCommand('superscript');
                     }
                 }).render();
             },
             subscript: function() {
                 return $.summernote.ui.button({
                     contents: '<sub>S</sub>',
                     tooltip: 'Subscript',
                     click: function() {
                         document.execCommand('subscript');
                     }
                 }).render();
             }
         },
 
	   	height:150
	    });					
	function submitData(){
		  /*  $('textarea[name=description]').val($('#Editor').summernote('code')); */
		   if(confirm('Are you sure to submit?')){
			   
		   }else{
			   event.preventDefault();
			   return false;
		   }
	}	
	$( document ).ready(function() {
		
		getValue('<%=HasChild%>')
		getSubSystem();
		getUnits('<%=hasUnit%>')
	});
	function getSubSystem(){
		var sid =$('#sid').val();
		var systemName =  $('#sid option:selected').attr('data-system');
		var systemID = "0#"+ systemName;
		console.log($('#sid').val())
		$.ajax({
			type:'get',
			url:'getSubsystem.htm',
			data:{
				sid:sid,
			},
			datatype:'json',
			success:function (result){
				var ajaxresult = JSON.parse(result);
				var s = '';
				s += '<option   value="">SELECT</option>';
				/* 	if($AssigneeLabCode == '@EXP'){} */
				s+='<option   value="'+systemID+'">'+systemName+'</option>'
				for (i = 0; i < ajaxresult.length; i++) 
				{
					<%if(sp.getMainId()!=null) {%> 
					s += '<option value="'+ajaxresult[i][0]+"#"+ajaxresult[i][10]+'" disabled>' +ajaxresult[i][3] + '</option>';

					<%}else{ %>
					s += '<option value="'+ajaxresult[i][0]+"#"+ajaxresult[i][10]+'" >' +ajaxresult[i][3] + '</option>';
					<%}%>
					
				} 
				var mainId = '<%=mainId%>';
				var specid = '<%=specid%>';
				$('#subid').html(s);
				$('#subid').val(mainId+"#"+specid).trigger('change'); 
			}
		})
	}
	
	function getValue(a){
		if(a==='N'){
			/* $('#mainDiv').show(); */
		
			/* $('#childdiv').hide(); */
			 $('#tablediv').hide(); 
			/* $('input[name="IsUnit"][value="Y"]').prop('checked', true).trigger('change'); */
		
			$('#tbody').html("");
			previousValue=0;
		/* 	document.querySelectorAll('#specParameter,#specValue,#specUnit, #maxValue, #minValue').forEach(function (input) {
			    input.required = true; // Applies readonly to all elements with any of these classes
			}); */
		}else{
			/* $('#mainDiv').hide(); */
/* 			$('input[name="IsUnit"][value="Y"]').prop('checked', true).trigger('change') */;
			/* $('#childdiv').show(); */
			 $('#tablediv').show();
			 <%if(NumberOfChild==0){%>
			$('#childNo').val('1');
			<%}%>
			handleChildNoChange();
		/* 	document.querySelectorAll('#specParameter,#specValue,#specUnit, #maxValue, #minValue').forEach(function (input) {
			    input.required = false; // Applies readonly to all elements with any of these classes
			}); */
		}
	}
	
	function getUnits(a){
		if(a==='N'){
		/* 	$('#onlyParameterDiv').show();*/
			$('#ParameterDiv').show(); 
			document.querySelectorAll('.specUnit, .maxValue, .minValue').forEach(function (input) {
			    input.readOnly = true; // Applies readonly to all elements with any of these classes
			});
			document.querySelectorAll('#specUnit, #maxValue, #minValue').forEach(function (input) {
			    input.readOnly = true; // Applies readonly to all elements with any of these classes
			});
		}else{
			$('#ParameterDiv').show();
			/* $('#onlyParameterDiv').hide(); */
			document.querySelectorAll('.specUnit, .maxValue, .minValue').forEach(function (input) {
			    input.readOnly = false; // Applies readonly to all elements with any of these classes
			});
			document.querySelectorAll('#specUnit, #maxValue, #minValue').forEach(function (input) {
			    input.readOnly = false; // Applies readonly to all elements with any of these classes
			});
		}
	}
		var previousValue=<%=NumberOfChild%>;
		function handleChildNoChange(input) {
			
	    var value = $('#childNo').val(); // Get the current value of the input box
	   	var difference = value-previousValue;
	   	previousValue=value;
	    const tbody = $('#tbody');
		var html="";
		if (difference > 0) {
            // Add main rows
            for (var i = 0; i < difference; i++) {
                var rowNumber = tbody.children('tr.main-row').length + 1;
                var html = '<tr class="main-row" data-row="' + rowNumber + '">' +
                    '<td >' + rowNumber + '.</td>' +
                    '<td><input type="text" class="form-control specParameter" name="specParameter_'+rowNumber+'" required="required"></td>' +
                    '<td><input type="text" class="form-control specUnit" name="specUnit_'+rowNumber+'" required="required"></td>' +
                    '<td><input type="text" class="form-control specValue" name="specValue_'+rowNumber+'" required="required"></td>' +
                    '<td><input type="text" class="form-control maxValue" name="maxValue_'+rowNumber+'" required="required"></td>' +
                    '<td><input type="text" class="form-control minValue" name="minValue_'+rowNumber+'" required="required"></td>' +
                    '<td><textarea type="text" class="form-control description" name="description_'+rowNumber+'" required="required"></textarea></td>' +
                    '<td>' +
                    '<button type="button" class="btn btn-sm add-sub-row" data-row="' + rowNumber + '">' +
                    '<i class="fa fa-plus" aria-hidden="true" style="color:green"></i>' +
                    '</button>' +
                    '</td>' +
                    '</tr>';
                tbody.append(html);
            }
        } else if (difference < 0) {
            // Remove main rows and their sub-rows
            for (var i = 0; i < Math.abs(difference); i++) {
                var lastRow = tbody.children('tr.main-row').last();
                var rowNumber = lastRow.data('row');
                tbody.find('tr[data-parent="' + rowNumber + '"]').remove(); // Remove sub-rows
                lastRow.remove(); // Remove the main row
            }
	    
	}
		var IsUnit = $('input[name="IsUnit"]:checked').val();
		getUnits(IsUnit);
		}
		
		 $(document).on('click', '.add-sub-row', function () {
		        var mainRow = $(this).data('row');
		        var tbody = $('#tbody');
		        var subRows = $('tr[data-parent="' + mainRow + '"]');

		        // Calculate next sub-row number
		        var subRowCount = subRows.length + 1;

		        var html = '<tr class="sub-row" data-parent="' + mainRow + '" data-sub-row="' + subRowCount + '">' +
		            '<td style="text-align:center;">' + mainRow + '.' + subRowCount + '</td>' +
		            '<td><input type="text" class="form-control specParameter" name="'+mainRow+'_specParameter" required="required"></td>' +
		            '<td><input type="text" class="form-control specUnit" name="'+mainRow+'_specUnit" required="required"></td>' +
		            '<td><input type="text" class="form-control specValue" name="'+mainRow+'_specValue" required="required"></td>' +
		            '<td><input type="text" class="form-control maxValue" name="'+mainRow+'_maxValue" required="required"></td>' +
		            '<td><input type="text" class="form-control minValue" name="'+mainRow+'_minValue" required="required"></td>' +
		            '<td><textarea type="text" class="form-control decription" name="'+mainRow+'_description" required="required"></textarea></td>' +
		            '<td>' +
		            '<button type="button" class="btn btn-sm remove-sub-row" data-parent="' + mainRow + '">' +
		            '<i class="fa fa-minus" aria-hidden="true" style="color:red"></i>' +
		            '</button>' +
		            '</td>' +
		            '</tr>';

		        // Append sub-row directly after the last sub-row or main row
		        if (subRows.length > 0) {
		            subRows.last().after(html);
		        } else {
		            $('tr[data-row="' + mainRow + '"]').after(html);
		        }
		        
		    	var IsUnit = $('input[name="IsUnit"]:checked').val();
				getUnits(IsUnit);
		    });
		 
		   $(document).on('click', '.remove-sub-row', function () {
		        var rowToRemove = $(this).closest('tr');
		        var parentRow = rowToRemove.data('parent');

		        // Remove the sub-row
		        rowToRemove.remove();

		        // Renumber remaining sub-rows for this parent
		        $('tr[data-parent="' + parentRow + '"]').each(function (index) {
		            $(this).find('td:first').text(parentRow + '.' + (index + 1));
		            $(this).attr('data-sub-row', index + 1);
		        });
		    });
	</script>

</body>
</html>