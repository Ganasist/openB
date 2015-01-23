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
	
	def message_sender(conversation)
	  message = Mailboxer::Notification.where(conversation_id: conversation.id).where.not(sender_id: current_member.id, sender_type: current_member.class.name)
	  message.first.sender.name if message.any?
	end
end
