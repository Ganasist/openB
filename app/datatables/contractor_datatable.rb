class ContractorDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :truncate, :image_tag

  def sortable_columns
    @sortable_columns ||= [ 'Contractor.company_name',
                            'Contractor.categories',
                            'Contractor.description',
                            'Contractor.address'
                          ]
  end

  def searchable_columns
    @searchable_columns ||= [ 'Contractor.company_name',
                              'Contractor.categories',
                              'Contractor.description',
                              'Contractor.address'
                            ]
  end

  private

  def data
    records.map do |record|
      [
        image_link(record),
        link_to(record.company_name, record, class: 'unstyled-link'),
        record.categories.to_sentence,
        truncate(record.description, length: 120),
        record.address,
        record.review_average_total
      ]
    end
  end

  def get_raw_records
    @contractors = Contractor.all.includes(:reviews, :upload)
  end

  # ==== Insert 'presenter'-like methods below if necessary
  def image_link(record)
    if record.upload.present?
      link_to record do
        image_tag record.upload.image.url(:thumb)
      end
    else
      'No Logo'
    end
  end
end
