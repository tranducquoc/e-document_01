$(document).on('turbolinks:load', function() {
  $('.one-div .one-div-title').click(function(event) {
    $(this).toggleClass('green');
    $(this).next().slideToggle(500);
    $('body').animate({
    scrollTop: $(this).offset().top});
  });
});
