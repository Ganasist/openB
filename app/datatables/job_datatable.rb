class JobDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari
  def_delegators :@view, :link_to, :params, :request

  def sortable_columns
    @sortable_columns ||= ['jobs.title',
                           'jobs.categories',
                           'jobs.description'
                           ]
    end

  def searchable_columns
    @searchable_columns ||= ['jobs.title',
                             'jobs.categories',
                             'jobs.description'
                             ]
  end

  private

    def data
      records.map do |record|
        [
          link_to(record.title, record, class: 'unstyled-link'),
          record.categories.to_sentence,
          record.description
        ]
      end
    end

    def get_raw_records
      @jobs = Job.all.searching
    end

  # ==== Insert 'presenter'-like methods below if necessary
end
