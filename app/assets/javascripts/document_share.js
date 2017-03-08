$(document).on('turbolinks:load', function() {
  $('.carousel-inner .item').first().addClass('active');
  $('#document_category_id').select2();
  $('#document_serie_id').select2();
  $('.select-share-document').select2();
  $('.share-content').hide();
  $('.share-content-1').hide();
  $('.btn-default.btn-share').click(function(){
    document_id = $(this).attr('id');
    $('#document_detail_'+document_id).slideToggle(500);
  });
  $('.btn-default.btn-share-1').click(function(){
    $('.share-content-1').slideToggle(500);
  });
});
