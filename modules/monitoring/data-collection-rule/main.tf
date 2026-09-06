resource "azurerm_monitor_data_collection_rule" "compute" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  destinations {
    log_analytics {
      name                  = "log-analytics-destination"
      workspace_resource_id = var.log_analytics_workspace_id
    }
  }

  data_sources {
    performance_counter {
      name                          = "compute-performance-windows"
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60

      counter_specifiers = [
        "\\Processor(_Total)\\% Processor Time",
        "\\Memory\\% Committed Bytes In Use",
        "\\LogicalDisk(_Total)\\% Free Space",
        "\\LogicalDisk(_Total)\\Disk Reads/sec",
        "\\LogicalDisk(_Total)\\Disk Writes/sec"
      ]
    }

    performance_counter {
      name                          = "compute-performance-linux"
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60

      counter_specifiers = [
        "\\Processor(*)\\% Processor Time",
        "\\Memory(*)\\% Used Memory",
        "\\Logical Disk(*)\\% Free Space",
        "\\Logical Disk(*)\\% Used Space",
        "\\Logical Disk(*)\\Disk Reads/sec",
        "\\Logical Disk(*)\\Disk Writes/sec"
      ]
    }

    syslog {
      name           = "linux-syslog"
      streams        = ["Microsoft-Syslog"]
      facility_names = ["auth", "authpriv", "cron", "daemon", "kern", "syslog", "user"]
      log_levels     = ["Debug", "Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
    }

    windows_event_log {
      name    = "windows-event-logs"
      streams = ["Microsoft-Event"]

      x_path_queries = [
        "Application!*[System[(Level=1 or Level=2 or Level=3)]]",
        "System!*[System[(Level=1 or Level=2 or Level=3)]]"
      ]
    }
  }

  data_flow {
    streams      = ["Microsoft-Perf", "Microsoft-Syslog", "Microsoft-Event"]
    destinations = ["log-analytics-destination"]
  }

  tags = var.tags
}