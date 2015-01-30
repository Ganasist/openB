class ContractorDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari
  def_delegators :@view, :link_to

  def sortable_columns
    @sortable_columns ||= [ 'contractors.company_name',
                            'contractors.categories',
                            'contractors.description',
                            'contractors.address'
                          ]
  end

  def searchable_columns
    @searchable_columns ||= [ 'contractors.company_name',
                              'contractors.categories',
                              'contractors.description',
                              'contractors.address'
                            ]
  end

  private

  def data
    records.map do |record|
      [
        link_to(record.company_name, record, class: 'unstyled-link'),
        record.categories.to_sentence,
        record.description,
        record.address,
        record.review_average_total
      ]
    end
  end

  def get_raw_records
    @contractors = Contractor.all.includes(:reviews)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
