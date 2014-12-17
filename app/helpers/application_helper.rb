module ApplicationHelper
	def mobile?
		request.user_agent =~ /Mobile|webOS/
	end

	def title(page_title)
		content_for(:title) { page_title }
	end
end
