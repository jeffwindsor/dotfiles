
status=$1

launchDaemons=(
com.checkpoint.epc.service
com.cirrato.cirratod
com.docker.vmnetd
com.jamf.management.daemon
com.jamfsoftware.startupItem*
com.jamfsoftware.task.1
com.microsoft.autoupdate.helper
com.microsoft.office.licensingV2.helper
com.microsoft.OneDriveStandaloneUpdaterDaemon
com.microsoft.OneDriveUpdaterDaemon
com.microsoft.teams.TeamsUpdaterDaemon
com.paloaltonetworks.gp.pangpsd
us.zoom.ZoomDaemon
com.checkpoint.eps.gui
com.checkpoint.eps.upgrader
com.checkpoint.fw.app
com.cirrato.CirratoHelper
com.crowdstrike.falcon.UserAgent
com.jamf.management.agent
com.microsoft.OneDriveStandaloneUpdater
com.microsoft.update.agent
com.paloaltonetworks.gp.pangpa
com.paloaltonetworks.gp.pangps
com.resources.det.places
)

echo "LAUNCH DAEMONS"
ls -la /Library/LaunchDaemons
echo 
for ld in "${launchDaemons[@]}"
do
  echo "> $status $ld"
  sudo launchctl $status system/$ld
done
echo
# print out target status
sudo launchctl print-disabled system
