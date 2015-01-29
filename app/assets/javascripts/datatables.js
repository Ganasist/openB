$('#all_categories').DataTable({
  responsive: true,
  paging: false
});

$('#contractors-table').dataTable({
  columns: [
    { "width": "20%" },
    { "width": "15%" },
    { "width": "40%" },
    { "width": "25%" }
  ],
  responsive: true,
  processing: true,
  serverSide: true,
  ajax: $('#contractors-table').data('source'),
  pagingType: "full_numbers",
  language: {
    search: "_INPUT_",
    searchPlaceholder: "Search Contractors"
  }
});


$('#jobs-table').dataTable({
  columns: [
    { "width": "25%" },
    { "width": "20%" },
    { "width": "55%" }
  ],
  responsive: true,
  processing: true,
  serverSide: true,
  ajax: $('#jobs-table').data('source'),
  pagingType: "full_numbers",
  language: {
    search: "_INPUT_",
    searchPlaceholder: "Search Jobs"
  }
});
