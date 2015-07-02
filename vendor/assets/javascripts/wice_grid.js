
$(function(){
	$('.wice_grid_form input[type=text]').on('keyup', function(e) {
		if (e.which == 13) {
			$(this).closest('form').submit();	
		}
	});
	$('.wice_grid_form input:not([type="text"]),.wice_grid_form select').change(function(){
		$(this).closest('form').submit();
	});
	$('.datetimepicker').each(function(){
		$(this).datetimepicker();
	});
});

