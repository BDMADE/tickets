// for data table generation
$(document).ready(function() {
  $('#example1').dataTable();
  $('#example2').dataTable({ 'scrollX': true,
    });
} );

$(document).ready(function() {
  $('#example4').DataTable( {
    'scrollX': false,
    "bFilter": false,
    "bPaginate": false,
    dom: 'Bfrtip',
    buttons: [
      'pdfHtml5'
    ],
    orientation: 'portrait',
    className: 'buttons-pdf',
    pageSize: 'A4'

  });
});

// for iCheck button
$(function () {
  $('input').iCheck({
    checkboxClass: 'icheckbox_square-blue',
    radioClass: 'iradio_square-blue',
    increaseArea: '20%' // optional
  });
});

// for alert close out
$(document).ready(function() {
  setTimeout(function(){
    $('.alert').fadeTo('slow', 0.001, function(){
      $('.alert').alert('close')
    });
  }, 2000)}
);

// error validation
$(document).ready(function () {
  $("form").validate({
    errorClass: "my-error-class",
    validClass: "my-valid-class"
  });
});
