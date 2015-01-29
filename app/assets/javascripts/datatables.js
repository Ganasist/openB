$('#all_categories').DataTable({
  responsive: true,
  paging: false
});

var options = {
                columns: [
                  { "width": "20%" },
                  { "width": "20%" },
                  { "width": "45%" },
                  { "width": "15%" }
                ],
                responsive: true,
                processing: true,
                serverSide: true,
                pagingType: "full_numbers"
              }

$('#contractors-table').dataTable(
  options
 );


$('#jobs-table').dataTable(
  options
);
