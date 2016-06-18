//= require active_admin/base
//= require tinymce-jquery

$(document).ready(function() {
  tinyMCE.init({
     mode: 'textareas',
     toolbar: 'undo redo | styleselect | bold italic | link | table',
     menubar: 'edit format',
     width: '100%'
   });
});

