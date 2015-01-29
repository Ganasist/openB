$('#all_categories').DataTable({
  responsive: true,
  paging: false
});


$('#contractors-table').dataTable({
  columns: [
    { "width": "20%" },
    { "width": "20%" },
    { "width": "45%" },
    { "width": "15%" }
    ],
  responsive: true,
  processing: true,
  serverSide: true,
  ajax: $('#contractors-table').data('source'),
  pagingType: "full_numbers"
});


$('#jobs-table').dataTable({
  columns: [
{ "width": "20%" },
{ "width": "20%" },
{ "width": "45%" },
{ "width": "15%" }
],
responsive: true,
processing: true,
serverSide: true,
ajax: $('#contractors-table').data('source'),
pagingType: "full_numbers"
});
