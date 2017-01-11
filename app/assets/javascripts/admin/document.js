$(document).on('turbolinks:load', function() {
  $('#doc_select').change(function() {
    var category_id = $('#doc_select').val();
    load_documents(category_id);
  });
});

function load_documents(category_id){
  if($('#documents-list-admin') !== null) $('#documents-list-admin').remove();
  $.ajax({
    url: '/api/documents/',
    data: {
      category_id: category_id
    },
    method: "GET",
    success: function(result){
      $('#table-documents-admin').append(result);
    }
  });
}
