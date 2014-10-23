module JobsHelper

	def job_duration(job)
		"#{ pluralize(job.duration, job.duration_unit.singularize) }"  	
  end

  def job_cost(job)
  	"$#{ job.cost }"
  end
end
