# flutter_exit_windows_ex

Logs off the interactive user, shuts down the system

## Install
```
dependencies:
  flutter_exit_windows_ex:
```

## Example
Shutdown:
```dart
import 'package:flutter_exit_windows_ex/flutter_exit_windows_ex.dart';
await FlutterExitWindowsEx.exitWindowsEx(EWX_SHUTDOWN);
```

Logoff:
```dart
import 'package:flutter_exit_windows_ex/flutter_exit_windows_ex.dart';
await FlutterExitWindowsEx.exitWindowsEx(EWX_LOGOFF);
```

Reboot:
```dart
import 'package:flutter_exit_windows_ex/flutter_exit_windows_ex.dart';
await FlutterExitWindowsEx.exitWindowsEx(EWX_REBOOT);
```

## 创建指令
```sh
λ flutter create -t plugin --platforms windows --org com.ajanuw --project-name flutter_exit_windows_ex ./
```

See also:
- https://docs.microsoft.com/en-us/windows/win32/shutdown/how-to-shut-down-the-system