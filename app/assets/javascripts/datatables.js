$('#all_categories').DataTable({
  responsive: true,
  paging: false
});

$('#contractors-table').dataTable({
  columns: [
    { width : 10 },
    { width : 15 },
    { width : 10 },
    { width : 35 },
    { width : 15 },
    { width : 15, orderable: false }
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
    { width : 10 },
    { width : 25 },
    { width : 15 },
    { width : 50, orderable: false }
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
