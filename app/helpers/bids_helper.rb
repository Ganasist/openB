module BidsHelper

	def bid_button_text(bid)
		if bid.contractor == current_contractor
			"Update your bid"
		else
			"Submit your bid"
		end
	end

	def bid_button_color(bid)
		if bid.contractor == current_contractor
			'btn btn-warning'
		else
			'btn btn-success'
		end		
	end
end
