# PowerShell module to transform .NET xml configuration files.
Can be used in deployments as part of a script.

### Import module 

```powershell
Import-Module ./ServelecSomeService-Module.psm1
```

### Scenario 1 - with only mandatory parameters

```powershell
Start-Config `
    -systemConnectionName 'appWorks' `
    -systemConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -globalConnectionName 'appWorks' `
    -globalConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -monitoredSystemName 'Default'
```

### Scenario 2 - with mandatory and optional parameters set

```powershell
Start-Config `
    -systemConnectionName 'appWorks' `
    -systemConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -globalConnectionName 'appWorks' `
    -globalConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -monitoredSystemName 'Default' `
    -value1 'RC' `
    -value2 'RTM' `
    -logLevel 'TRACE' `
    -endpointAddress 'localhost:8080'
```

#### Scenario 2a - only with `value1` parameter set

```powershell
Start-Config `
    -systemConnectionName 'appWorks' `
    -systemConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -globalConnectionName 'appWorks' `
    -globalConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -monitoredSystemName 'Default' `
    -value1 'RC' `
    -logLevel 'TRACE' `
    -endpointAddress 'localhost:8080'
```

#### Scenario 2b - only with `value2` parameter set

```powershell
Start-Config `
    -systemConnectionName 'appWorks' `
    -systemConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -globalConnectionName 'appWorks' `
    -globalConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -monitoredSystemName 'Default' `
    -value2 'RTM' `
    -logLevel 'TRACE' `
    -endpointAddress 'localhost:8080'
```

#### Scenario 2c - only with `logLevel` parameter set

```powershell
Start-Config `
    -systemConnectionName 'appWorks' `
    -systemConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -globalConnectionName 'appWorks' `
    -globalConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -monitoredSystemName 'Default' `
    -logLevel 'TRACE'
```

#### Scenario 2d - only with `endpointAddress` parameter set

```powershell
Start-Config `
    -systemConnectionName 'appWorks' `
    -systemConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -globalConnectionName 'appWorks' `
    -globalConnectionString 'Server=jdbc:sqlserver://localhost:1433; Database=appWorks; IntegratedSecurity=GSSAPI;' `
    -monitoredSystemName 'Default' `
    -endpointAddress 'localhost:8080'
```

### Scenario 3 - with only optional parameters set

```powershell
Start-Config `
    -value1 'RC' `
    -value2 'RTM' `
    -logLevel 'TRACE' `
    -endpointAddress 'localhost:8080'
```

#### Expected output (Read host params):

```powershell
cmdlet Start-Config at command pipeline position 1
Supply values for the following parameters:
systemConnectionName:
```

### Scenario 4 - no parameters

```powershell
Start-Config
```

#### Expected output (Read host params):

```powershell
cmdlet Start-Config at command pipeline position 1
Supply values for the following parameters:
systemConnectionName:
```
