class ExamplesController < ApplicationController

	def new
		@contractor = Contractor.find(params[:contractor_id])
		@example = @contractor.examples.build	
	end
end
