# Completion for jobrunner
# This essentially provides completion for commands being given to jobrunner
# as well as some common flags
function __jobrunner_remaining_args
   set -l tokens (commandline -poc) (commandline -ct)
   set -e tokens[1]

   set -l opts h/help v d/state-dir= rc-file= debug debugLocking robot-format q/quiet
   set -a opts f/foreground monitor c/command= retry= r/reminder= done k/key=
   set -a opts m/mail= t/to= cc= tw this-workspace tp this-pane b/blocked-by=
   set -a opts B/blocked-by-success= w/wait= i/isolate input= auto-job count l/list
   set -a opts dot png svg L/list-inactive W/watch s/show= K/last-key n/index=
   set -a opts pid= g/get-log= G/get-all-logs info int= stop= delete= prune
   set -a opts prune-except= p/since-checkpoint P/set-checkpoint=
   set -a opts a/activity A/activity-window=

   argparse -s $opts -- $tokens 2>/dev/null

   # The remaining argv is the subcommand with all its options, which is what
   # we want.
   if test -n "$argv"; and not string match -qr '^-' $argv[1]
      string join0 -- $argv
      return 0
   else
      return 1
   end
end

function __jobrunner_no_subcommand
   not __jobrunner_remaining_args >/dev/null
end

function __jobrunner_complete_subcommand
   set -l args (__jobrunner_remaining_args | string split0)
   __fish_complete_subcommand --commandline $args
end

# Completion for some common options

# Grab all the most recent keys used
set -l jobKeys (job -L | tail -n 20 | string match -r '\[[_a-zA-Z]+\]' | string trim -c '[]' | sort | uniq)
complete -c job -n __fish_no_arguments -x -s h -l help -d "Display help and exit"
complete -c job -n __jobrunner_no_subcommand -x -s v -d "Increase verbosity (multiple times for more verbose)"
complete -c job -n __jobrunner_no_subcommand -x -s q -l quiet -d "Do not print any messages"
complete -c job -n __jobrunner_no_subcommand -x -s f -l foreground -d "Do not fork, run in foreground"
complete -c job -n __jobrunner_no_subcommand -x -l monitor -d "Run in the background, but monitor output"
complete -c job -n __jobrunner_no_subcommand -x -l retry -d "Retry job specfied by KEY" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -s k -l key -d "Specify job key to use" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -s m -l mail -d "Send mail on job completion for KEY" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -s b -l blocked-by -d "Specify that this job depends on KEY" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -s B -l blocked-by-success -d "Specify that this job depends on the success of KEY" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -s w -l wait -d "Wait for job specfied by KEY to finish" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -s l -l list -d "List active jobs"
complete -c job -n __jobrunner_no_subcommand -x -s L -l list-inactive -d "List inactive jobs"
complete -c job -n __jobrunner_no_subcommand -x -s W -l watch -d "Watch for any job activity"
complete -c job -n __jobrunner_no_subcommand -x -s s -l show -d "Get details for job specfied by KEY" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -s K -l last-key -d "Get the latest key"
complete -c job -n __jobrunner_no_subcommand -x -s g -l get-log -d "Get log file name for job specfied by KEY" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -s G -l get-all-logs -d "Get all log file names for running jobs"
complete -c job -n __jobrunner_no_subcommand -x -l int -d "Kill (INT) the specfied job using its PID" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -l stop -d "Force job status 'stopped' for the job specfied by KEY" -a "$jobKeys"
complete -c job -n __jobrunner_no_subcommand -x -l prune -d "Prune inactive jobs and log files"
complete -c job -n __jobrunner_no_subcommand -x -l prune-except -d "Prune inactive jobs and log files except the last COUNT"

# Complete the command we are giving the jobrunner
complete -c job -x -a "(__jobrunner_complete_subcommand)"

# Aliases of job
complete -c jb --wraps job
complete -c jm --wraps job
