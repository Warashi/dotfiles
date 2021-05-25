begin
	set -g gtm_status ""
	set -g gtm_next_update 0
	set -g gtm_last_dir $PWD
	function __git-time-metric --on-event fish_prompt
		set epoch (date +%s)
		if test $gtm_last_dir != $PWD -o $epoch -ge $gtm_next_update
			set gtm_next_update (math $epoch + 30)
			set gtm_last_dir $PWD
			if set -q gtm_status_ONLY
				set gtm_status (gtm status -total-only)
			else
				set gtm_status (gtm record -terminal -status)
			end
			if test $status -ne 0
				echo "Error running 'gtm record -terminal -status', you may need to install gtm or upgrade to the latest"
				echo "See http://www.github.com/git-time-metric/gtm for how to install"
			end
		end
	end
end
