class JobDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :request, :truncate, :image_tag

  def sortable_columns
    @sortable_columns ||= %W(Job.title Job.categories)

    end

  def searchable_columns
    @searchable_columns ||= %W(Job.title Job.categories Job.description)
  end

  private

    def data
      records.map do |record|
        [
          image_link(record),
          link_to(record.title, record, class: 'unstyled-link'),
          record.categories.to_sentence,
          truncate(record.description, length: 200)
        ]
      end
    end

    def get_raw_records
      if params[:scoped].blank?
        @jobs = Job.all.includes(:uploads)
      else
        @jobs = Job.all.relevant_categories(params[:scoped]).includes(:uploads)
      end
    end

  # ==== Insert 'presenter'-like methods below if necessary
  def image_link(record)
    if record.uploads.first.present?
      link_to record do
        image_tag record.uploads.first.image.url(:thumb)
      end
    else
      'No Images'
    end
  end
end
