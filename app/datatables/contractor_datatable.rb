class ContractorDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari
  def_delegators :@view, :link_to, :params, :request

  def sortable_columns
    @sortable_columns ||= ['contractors.company_name',
                           'contractors.categories',
                           'contractors.description',
                           'contractors.address']
  end

  def searchable_columns
    @searchable_columns ||= ['contractors.company_name',
                             'contractors.categories',
                             'contractors.address',
                             'contractors.categories']
  end

  private

  def data
    records.map do |record|
      [
        link_to(record.company_name, record, class: 'unstyled-link'),
        record.categories,
        record.description,
        record.address,
        record.updated_at
      ]
    end
  end

  def get_raw_records
    @contractors = Contractor.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
