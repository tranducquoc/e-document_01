$(document).on('turbolinks:load', function(){
  $('#tabs').tab();
  var load_image_star= function(length) {
    $.each($('.star-review'), function(index, key){
      if (index < length){
        $(key).attr('src', '/assets/star-on.png');
      }else {
        $(key).attr('src', '/assets/star-off.png');
      }
    });
  }
  $('.star-review').hover(function() {
    load_image_star($(this).attr('alt'));
  });

  $('.star-review').mouseleave(function() {
    load_image_star($('#review_rating').val());
  });

  $('.star-review').click(function() {
    var value = $(this).attr('alt');
    $('#review_rating').val(value);
    load_image_star(value);
  });

  $('#review-btn').on('click', function(event){
    var method = $(this).val();
    var id = $('#review_id').val();
    var url = '/reviews';
    if (method == 'Update review'){
      url = url+'/'+id;
      method = "PUT";
    }else{
      method = 'POST';
    }
    event.preventDefault();
    var rating = $('#review_rating').val();
    var document_id = $('#review_document_id').val();
    $.ajax({
      url: url,
      method: method,
      data: {
        review: {rating: rating, document_id:document_id}
      },
      dataType: 'JSON',
      success: function(response){
        if(method == 'PUT'){
          $('#review_'+id).fadeOut(0, function(){
            $(this).remove();
          });
          $("#mynewreview").modal("hide");
          $(".reviews-index").prepend(response.content);
        }else{
          $('.star_rewview_document').removeClass('hidden');
          $("#mynewreview").modal("hide");
          $(".reviews-index").prepend(response.content);
          $('.mynewreview').text('Update review');
          $('#review-btn').val('Update review');
          $('#review_id').val(response.review_id);
        }
        $('#star_rewview_document').text(response.star_rewview_document);
        alert(response.status);
      },
      error: function(){
        alert("Error! Please check your review and retry!");
      }
    });
  });
});
