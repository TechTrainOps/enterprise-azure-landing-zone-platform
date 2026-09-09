# Monitoring Module Documentation

Generated documentation for the implemented monitoring modules in the repository.

Included modules: 8.

## Implemented modules

### `action-group`

Creates an Azure Monitor Action Group for alert notifications.

**Purpose**
- Defines notification receivers and the action-group configuration used by Azure Monitor alerts.

### `activity-log-alert`

Creates an Azure Monitor Activity Log Alert.

**Purpose**
- Detects administrative or platform-level events from the Azure Activity Log.
- Supports criteria and action-group notification configuration.

### `data-collection-rule`

Creates an Azure Monitor Data Collection Rule.

**Purpose**
- Defines telemetry collection for supported guest and platform data sources.
- Sends collected data to configured Azure Monitor destinations such as Log Analytics.

### `data-collection-rule-association`

Associates a Data Collection Rule with a supported Azure resource.

**Purpose**
- Applies the configured DCR to compute resources so guest telemetry can be collected.

### `diagnostic-setting`

Creates Azure Monitor Diagnostic Settings.

**Purpose**
- Routes resource logs and metrics to configured monitoring destinations.

### `log-analytics`

Creates an Azure Log Analytics Workspace.

**Purpose**
- Provides the central Log Analytics destination for monitoring and query-based analysis.

### `metric-alert`

Creates an Azure Monitor Metric Alert.

**Purpose**
- Monitors Azure resource metrics against configurable thresholds.
- Supports aggregation, operators, frequency, evaluation windows, severity, scopes, and action groups.

### `scheduled-query-alert`

Creates an Azure Monitor Scheduled Query Rule Alert.

**Purpose**
- Evaluates Kusto Query Language (KQL) queries against Log Analytics data on a schedule.
- Supports metric aggregation, thresholds, operators, evaluation frequency, and action groups.

**Files**
Each monitoring module contains:
- `main.tf`
- `variables.tf`
- `output.tf`

**Typical use**
Provides the monitoring layer for platform resources and compute workloads, including guest performance telemetry, activity logs, metrics, and KQL-based alerts.

END