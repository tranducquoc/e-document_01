$(document).on('turbolinks:load', function() {
  $('.carousel-inner .item').first().addClass('active');
  $('#document_category_id, #document_serie_id').select2({
    width: 200
  });
  $('.select-share-document, .select-share-team').select2({
    width: 100
  });
  $('.share-content, .share-team').hide();
  $('.share-content-1, .share-team-1').hide();
  $('.btn-default.btn-share').click(function(){
    document_id = $(this).attr('id');
    $('.signal').remove();
    $('.share-team, .share-team-1').hide();
    $('.share-team li').each(function(){
      $(this).remove();
    })
    $('#document_detail_'+document_id).slideToggle(500);
  });
  $('.btn-default.btn-share-team').click(function(){
    id = $(this).attr('id');
    $('.share-content, .share-content-1').hide();
    $('.share-content li').each(function(){
      $(this).remove();
    })
    $('#share_team_detail_'+id).slideToggle(500);
    input = '<input type="hidden" name="share_team" class="signal" value ="true">'
    $('#share_team_detail_'+id+' form').prepend(input)
  });
  $('.btn-default.btn-share-1').click(function(){
    $('.share-content-1').slideToggle(500);
  });
  $('.btn-default.btn-share-team-1').click(function(){
    $('.share-team-1').slideToggle(500);
  });
  $('#create-series-area').hide();
  $('#create-series').click(function(){
    $('#create-series-area').slideToggle(200);
    $('#choose-series').hide();
  });
  $('#series-current').click(function(){
    $('#create-series-area').hide();
    $('#create-series-area input').each(function(){
      $(this).val('');
    })
    $('#choose-series').slideToggle(200);
  });
});
