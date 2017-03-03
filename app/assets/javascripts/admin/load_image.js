$(document).on('turbolinks:load', function() {
  function readURL(input) {
    if(input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#image-slide').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $('#search_image').keyup(function() {
    var image_name = $('#search_image_ajax').val();
    load_images(image_name);
  });

  $('#imageslide_image').change(function(){
    readURL(this);
  });
});

function load_images(image_name){
  if($('#images-list-admin') !== null) $('#images-list-admin').remove();
  $.ajax({
    url: '/api/imageslides/',
    method: "GET",
    data: {
      image_name: image_name
    },
    success: function(result){
      $('#table-images-admin').append(result);
    }
  });
}
