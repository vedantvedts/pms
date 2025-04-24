<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%


String ForceResetPwd = (String)request.getAttribute("ForcePwd"); 
 
%>

<meta charset="UTF-8">

     

<%if(ForceResetPwd!=null && ForceResetPwd.equals("N")){ %>
	<jsp:include page="../static/header.jsp"></jsp:include> 
<%}else{ %>
	<jsp:include page="../static/dependancy.jsp"></jsp:include>
	<title>Reset Password</title>
<%} %>


</head>
<body>

	<% String ses = (String) request.getParameter("result"); 
       String ses1 = (String) request.getParameter("resultfail");
       if (ses1 != null) { %>
        <div align="center">
            <div class="alert alert-danger" role="alert">
                <%= ses1 %>
            </div>
        </div>
    <% } if (ses != null) { %>
        <div align="center">
            <div class="alert alert-success" role="alert">
                <%= ses %>
            </div>
        </div>
    <% } %>

	<div class="container-fluid">
       
    	<div class="card shadow-nohover">
        	<div class="card-header" style="background-color: #055C9D;">
        		<div class="row">
					<div class="col-md-3">
						<h5 class="text-white">Password Change</h5>
					</div>
					<div class="col-md-9 ">
					</div>	
				</div>
        	</div>
        	
        	<div class="card-body" >		
				<div class="row"> 
	            	<div class="col-md-1"></div>
	            	<div class="col-md-11">
						<%if(ForceResetPwd!=null && ForceResetPwd.equals("Y")){ %>
							<span style="font-weight: bold;color:#EB1D36;font-size:20px;">Note : </span> 
							<span style="font-size:20px; ">Please reset Your default Password to continue.</span>
							<br><br>
						<%} %>
					</div>
				</div>
					
					
				<form action="PasswordChanges.htm" method="POST" name="myfrm" id="myfrm">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="text" name="username" id="username" value="${sessionScope.Username}" autocomplete="username" style="display: none;" aria-hidden="true">
					
                	<div class="row"> 
                		<div class="col-md-1"></div>
                   		<div class="col-md-3">
                       		<div class="form-group">
                             	<label class="control-label">Old Password</label><span class="mandatory">*</span>
                            	<input  class="form-control form-control" type="password" placeholder="Old Password " required name="OldPassword" id="Oldpassword" autocomplete="current-password">
                       		</div>
                   		</div>
         					
                   		<div class="col-md-3">
                       		<div class="form-group">
								<label class="control-label">New Password</label><span class="mandatory">*</span>
								<div class="input-group">
									<input class="form-control" type="password" placeholder="New Password" required name="NewPassword" id="password" autocomplete="new-password">
									<div class="input-group-append">
										<span class="input-group-text" onclick="togglePassword('password', this)" style="cursor:pointer;">
											<i class="fa fa-eye"></i>
										</span>
									</div>
								</div>
								<small id="passwordHelp" class="form-text text-muted"></small>
								<div id="strengthBar" style="height: 5px; background-color: #e0e0e0; margin-top: 5px;">
									<div id="strengthIndicator" style="height: 100%; width: 0%; background-color: red;"></div>
								</div>
							</div>
                   		</div>
                    		
                   		<div class="col-md-3">
                       		<div class="form-group">
								<label class="control-label">Confirm New Password</label><span class="mandatory">*</span>
								<div class="input-group">
									<input class="form-control" type="password" placeholder="Confirm New Password" required name="NewPassword" id="confirm_password" autocomplete="new-password">
									<div class="input-group-append">
										<span class="input-group-text" onclick="togglePassword('confirm_password', this)" style="cursor:pointer;">
											<i class="fa fa-eye"></i>
										</span>
									</div>
								</div>
								<small id="pwd-rules" class="text-muted">
								  <ul style="list-style-type: none; padding-left: 0; margin-top: 5px;">
								    <li id="rule-length" style="color:red;">❌ At least 8 characters</li>
								    <li id="rule-uppercase" style="color:red;">❌ At least 1 uppercase letter</li>
								    <li id="rule-lowercase" style="color:red;">❌ At least 1 lowercase letter</li>
								    <li id="rule-number" style="color:red;">❌ At least 1 number</li>
								    <li id="rule-special" style="color:red;">❌ At least 1 special character</li>
								  </ul>
								</small>
								<span id='message'></span>

							</div>
                   		</div>
					</div> 
	                        
                    <div align="center"> 
                    	<input type="hidden" name="type" value="AD"/>
                    	<input type="hidden" name="ForcePwd" value="<%=ForceResetPwd%>"/>
                      <input type="button" class="btn btn-sm submit" id="sub" value="SUBMIT" name="sub"  onclick="return checkoldPassword()"  > 
                    </div>
	                          
				</form>      
	  		</div>
	  		
        </div>
	</div>
	

<script type="text/javascript">
$(document).ready(function () {
	var $password = $('#password');
	var $confirmPassword = $('#confirm_password');
	var $submitBtn = $('#sub');
	var $message = $('#message');
	var $passwordHelp = $('#passwordHelp');
	var $strengthIndicator = $('#strengthIndicator');

	var strongPasswordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

	$submitBtn.prop('disabled', true);

	$password.on('input', function () {
		var value = $password.val();
		var strength = 0;

		// Visual strength calculation
		if (value.length >= 8) strength += 1;
		if (/[A-Z]/.test(value)) strength += 1;
		if (/[a-z]/.test(value)) strength += 1;
		if (/\d/.test(value)) strength += 1;
		if (/[@$!%*?&]/.test(value)) strength += 1;

		var strengthPercent = (strength / 5) * 100;
		var color = 'red';
		if (strengthPercent >= 80) color = 'green';
		else if (strengthPercent >= 60) color = 'orange';

		$strengthIndicator.css({
			width: strengthPercent + '%',
			backgroundColor: color
		});

		var allValid = updateChecklist(value);

		if (!strongPasswordRegex.test(value)) {
			$passwordHelp.text('Must include uppercase, lowercase, number & special character').css('color', 'orange');
			$submitBtn.prop('disabled', true);
		} else {
			$passwordHelp.text('Strong password').css('color', 'green');
			if (value === $confirmPassword.val()) {
				$submitBtn.prop('disabled', false);
				$message.text('');
			}
		}
	});

	$password.on('paste copy cut', function (e) {
		e.preventDefault();
	});
	
	$confirmPassword.on('input', function () {
		if ($password.val() !== $confirmPassword.val()) {
			$message.text('Passwords do not match ❌').css('color', 'red');
			$submitBtn.prop('disabled', true);
		} else {
			$message.text('Passwords match ✔').css('color', 'green');
			if (strongPasswordRegex.test($password.val())) {
				$submitBtn.prop('disabled', false);
			}
		}
	});
	
	$confirmPassword.on('paste copy cut', function (e) {
	    e.preventDefault();
	});
});

function updateChecklist(password) {
	var rules = {
		length: password.length >= 8,
		uppercase: /[A-Z]/.test(password),
		lowercase: /[a-z]/.test(password),
		number: /\d/.test(password),
		special: /[@$!%*?&]/.test(password)
	};

	$('#rule-length').css('color', rules.length ? 'green' : 'red')
		.text((rules.length ? '✅ ' : '❌ ') + 'At least 8 characters');
	$('#rule-uppercase').css('color', rules.uppercase ? 'green' : 'red')
		.text((rules.uppercase ? '✅ ' : '❌ ') + 'At least 1 uppercase letter');
	$('#rule-lowercase').css('color', rules.lowercase ? 'green' : 'red')
		.text((rules.lowercase ? '✅ ' : '❌ ') + 'At least 1 lowercase letter');
	$('#rule-number').css('color', rules.number ? 'green' : 'red')
		.text((rules.number ? '✅ ' : '❌ ') + 'At least 1 number');
	$('#rule-special').css('color', rules.special ? 'green' : 'red')
		.text((rules.special ? '✅ ' : '❌ ') + 'At least 1 special character');

	return Object.values(rules).every(Boolean);
}

function togglePassword(fieldId, icon) {
	var input = document.getElementById(fieldId);
	var iconElement = icon.querySelector('i');
	if (input.type === "password") {
		input.type = "text";
		iconElement.classList.remove('fa-eye');
		iconElement.classList.add('fa-eye-slash');
	} else {
		input.type = "password";
		iconElement.classList.remove('fa-eye-slash');
		iconElement.classList.add('fa-eye');
	}
}

function checkoldPassword() {
	var Npwd = $('#password').val();
	var cpwd = $('#confirm_password').val();
	var Opwd = $('#Oldpassword').val();

	if (Npwd && cpwd && Opwd) {
		$.ajax({
			type: "GET",
			url: "NewPasswordChangeCheck.htm",
			data: { oldpass: Opwd },
			datatype: 'json',
			success: function (result) {
				if (result === '1') {
					if (Npwd === Opwd) {
						alert('Your New Password Should Not Be Same as Your Old Password');
					} else if (Npwd === '123' || Npwd === '1234') {
						alert('Default or Weak Passwords are not Allowed');
					} else if (confirm("Are You Sure To Submit?")) {
						$('#myfrm').submit();
					}
				} else {
					alert('Please Enter Correct Old Password.');
				}
			}
		});
	} else {
		alert("Please Enter All Fields!");
		return false;
	}
}
</script>


</body>
</html>