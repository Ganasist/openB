module ApplicationHelper

	def mobile?
		request.user_agent =~ /Mobile|webOS/
	end
end
