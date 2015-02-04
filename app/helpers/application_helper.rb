module ApplicationHelper
	def mobile?
		request.user_agent =~ /Mobile|webOS/
	end

	def title(page_title)
		content_for(:title) { page_title }
	end

	def review_badge(member)
		case member.review_average_total
		when 0..1.99
			'label label-danger'
		when 2..3.99
			'label label-warning'
		when 4..5.99
			'label label-primary'
		when 6..7.99
			'label label-info'
		when 8..10
			'label label-success'
		else
			'label label-default'
		end
	end
	
	def message_sender(conversation, type)	  
	  receipts = conversation.receipts_for(current_member)
    receipt = receipts.where(mailbox_type: type)
    message = receipt.first.message
	  message.sender.name
	end	
end
