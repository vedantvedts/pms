/* 
  Alphanumeric validation JS
  - Use class "names" in the  inputs fields to apply the validatons.
*/

document.addEventListener('DOMContentLoaded', function () {
	
  // Allow only alphanumeric (no spaces)
  document.querySelectorAll('.alphanum-only').forEach(input => {
    input.addEventListener('input', function () {
      let value = this.value;

      value = value.replace(/[^A-Za-z0-9]/g, '');

      this.value = value;
    });
  });
  
  // Allow alphanumeric + space (not at start) 
  document.querySelectorAll('.alphanum-no-leading-space').forEach(input => {
    input.addEventListener('input', function () {
      let value = this.value;

      value = value.replace(/[^A-Za-z0-9 ]/g, '');

      value = value.replace(/^ +/, '');

      this.value = value;
    });
  });

  
  // Letters only (no spaces allowed)
  document.querySelectorAll('.alpha-only').forEach(input => {
	input.addEventListener('input', function () {
	  let value = this.value;
	
	  value = value.replace(/[^A-Za-z]/g, '');
	
	  this.value = value;
    });
  });
  
  // Letters + space (no leading space)
  document.querySelectorAll('.alpha-no-leading-space').forEach(input => {
    input.addEventListener('input', function () {
      let value = this.value;

      value = value.replace(/[^A-Za-z ]/g, '');

      value = value.replace(/^ +/, '');

      this.value = value;
    });
  });
  
  // Numbers only (no spaces allowed)
  document.querySelectorAll('.numeric-only').forEach(input => {
    input.addEventListener('input', function () {
      let value = this.value;

    value = value.replace(/[^0-9]/g, '');

    this.value = value;
   });
 });

  
  
});

