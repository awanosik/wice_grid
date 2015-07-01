
$(function(){
	$('input[type=text]').on('keyup', function(e) {
		if (e.which == 13) {
			$(this).closest('form').submit();	
		}
	});
	$('input:not([type="text"]), select').change(function(){
		$(this).closest('form').submit();
	});
	$('.datetimepicker').each(function(){
		$(this).datetimepicker();
	});
});

