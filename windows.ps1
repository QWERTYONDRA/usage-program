while($true) {
    $time = [int] (Get-Date -UFormat %s)
    
    $cpu = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    $cpu = [Math]::Round($cpu, 2)
    
    $memory = Get-Counter -Counter "\Memory\Committed Bytes"
    $memory_used = $memory.CounterSamples.CookedValue
    $memory_total = (Get-WmiObject Win32_OperatingSystem).TotalVisibleMemorySize * 1024
    $memory_used_mb = [Math]::Round($memory_used / 1MB)
    
    "$time; $cpu; $memory_used_mb" | Out-File -FilePath "usage.log" -Append -Force
    
    Start-Sleep -Seconds 60
}
