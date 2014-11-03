module JobsHelper

	# def job_duration(job)
	# 	"#{ pluralize(job.duration, job.duration_unit.singularize) }"  	
 #  end

  def job_bid_duration(job)
  	if !job.bidding_period.nil?
	  	if job.bidding_period > Date.today
	  		"| Bidding period ends in #{ time_ago_in_words(job.bidding_period) }"
	  	else
	  		"| Bidding period ended #{ time_ago_in_words(job.bidding_period) } ago"
	  	end
	  else
	  	"| This job post has no expiration"
	  end
  end
end
