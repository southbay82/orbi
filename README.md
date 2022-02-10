# orbi
Orbi Network Device Utilities


* invoke-reboot-orbi 
  * Ready for use, choose your own secure secret management to pass to shellscript.
  * This was developed after a series of updates to the Orbi router which impacts both RBR40 and RBR50 series that cause the wireless to degrade down to roughly 30Mbps.  
  * Add this script to fire by cron 1 to 2 times per week.
   * For RBR40 only needed a reboot once a week.
   * For RBR50 seems to require a twice a week reboot. 
* orbictl
  * No longer active, this was a small golang project, paused to deliver a quick result with the shellscript. 
