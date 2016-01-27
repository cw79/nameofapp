function ratyfy(){
	$('.rating').raty( { path: '/assets', scoreName: 'comment[rating]' });
	$('.rated').raty({ path: '/assets',
		readOnly: true,
		score: function() {
			return $(this).attr('data-score');
		}
	});
}




$(document).on('ready page:load', function(){
	ratyfy();

	var folded = new OriDomi('.stgeorge', {vPanels: 9, speed: 0, perspective: 900});
	folded.accordion("-88%").setSpeed(1600);
    var $window = $(window);

	var stGeorgeImage = $('img.st-george-image');
	var unfoldWhenScrolledIntoView = function() {
		if (isScrolledFullyIntoView(stGeorgeImage)) {
			$window.unbind("scroll", unfoldWhenScrolledIntoView);
			folded.reveal(0);
		}
	};

	$window.bind("scroll", unfoldWhenScrolledIntoView);

	function isScrolledFullyIntoView(elem)
	{
		var docViewTop = $window.scrollTop();
	    var docViewBottom = docViewTop + $window.height();
	    var elemTop = elem.offset().top;
	    var elemBottom = elemTop + elem.height();
	    return docViewBottom > elemBottom;
	}
	
});
