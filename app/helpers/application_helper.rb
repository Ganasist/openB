module ApplicationHelper
	def mobile?
		request.user_agent =~ /Mobile|webOS/
	end

	def title(page_title)
		content_for(:title) { page_title }
	end

	def bid_status(bid)
		case bid
		when bid.accepted
			"Accepted"
		when bid.rejected
			"Rejected"
		else
			"No decision yet"
		end
	end
end
