$( document ).on('turbolinks:load', function() {
  $('#search_organization_document_ajax').keyup(function() {
    var name = $('#search_organization_document_ajax').val();
    var organization_id = $('#search_organization_id').val();
    load_organization_documents(name, organization_id);
  });
});

function load_organization_documents(name, id){
  $.ajax({
    url: '/api/organization_documents/',
    method: "GET",
    data: {
      name: name,
      id: id
    },
    success: function(result){
      if($('#list-documents') !== null) $('#list-documents').remove();
      $('#table-document').append(result);
      $('.select-share-document').select2({
        width: 100
      });
      $('.share-content').hide();
      $('.share-content-1').hide();
      $('.btn-default.btn-share').click(function(){
        document_id = $(this).attr('id');
        $('#document_detail_'+document_id).slideToggle(500);
      });
      $('.btn-default.btn-share-1').click(function(){
        $('.share-content-1').slideToggle(500);
      });
    }
  });
}
