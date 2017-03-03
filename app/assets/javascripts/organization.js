$(document).on('turbolinks:load', function() {
  function fetch_data(id, url, method) {
    $.ajax({
      url: url,
      method: method,
      data: {tab_id: id},
      success: function (data) {
        $('#'+id).html(data);
      }
    });
}

  $('.tab-ajax a').on('click', function () {
    var id = $(this).attr('data-destination-id');
    var url = window.location.pathname;
    var method = 'GET';
    if (id != 'documents'){
      fetch_data(id, url, method);
    }
  });

  $('.select-user-to-add').select2({
    placeholder: I18n.t("organizations.show.select_user"),
    allowClear: true
  });
  
  $('#add-organization-member-btn').on('click', function () {
    var url = window.location.pathname + '/group_members/';
    var user_id = $('#organization-select-user').val();
    $.ajax({
      url: url,
      method: 'POST',
      data: {user_id: user_id},
      success: function (data) {
        alert(data);
      }
    })
  })
});
