$Cache = Get-WmiObject -Namespace 'ROOT\CCM\SoftMgmtAgent' -Class CacheConfig
$Cache.Size = '14246'
$Cache.Put()
Restart-Service -Name CcmExec