
import 'dart:async';

import 'package:flutter/services.dart';

/// Beginning with Windows 8:  You can prepare the system for a faster startup by combining the EWX_HYBRID_SHUTDOWN flag with the EWX_SHUTDOWN flag.
const int EWX_HYBRID_SHUTDOWN = 0x00400000;

/// Shuts down all processes running in the logon session of the process that called the ExitWindowsEx function. Then it logs the user off.
/// 
/// This flag can be used only by processes running in an interactive user's logon session.
const int EWX_LOGOFF = 0;

/// Shuts down the system and turns off the power. The system must support the power-off feature.
/// 
/// The calling process must have the SE_SHUTDOWN_NAME privilege. For more information, see the following Remarks section.
const int EWX_POWEROFF = 0x00000008;

/// Shuts down the system and then restarts the system.
///
/// The calling process must have the SE_SHUTDOWN_NAME privilege. For more information, see the following Remarks section.
const int EWX_REBOOT = 0x00000002;

/// Shuts down the system and then restarts it, as well as any applications that have been registered for restart using the RegisterApplicationRestart function. These application receive the WM_QUERYENDSESSION message with lParam set to the ENDSESSION_CLOSEAPP value. For more information, see Guidelines for Applications.
const int EWX_RESTARTAPPS = 0x00000040;

/// Shuts down the system to a point at which it is safe to turn off the power. All file buffers have been flushed to disk, and all running processes have stopped.
/// 
/// The calling process must have the SE_SHUTDOWN_NAME privilege. For more information, see the following Remarks section.
const int EWX_SHUTDOWN = 0x00000001;

/// This flag has no effect if terminal services is enabled. Otherwise, the system does not send the WM_QUERYENDSESSION message. This can cause applications to lose data. Therefore, you should only use this flag in an emergency.
const int EWX_FORCE = 0x00000004;

/// Forces processes to terminate if they do not respond to the WM_QUERYENDSESSION or WM_ENDSESSION message within the timeout interval. For more information, see the Remarks.
const int EWX_FORCEIFHUNG = 0x00000010;



/// 注销交互式用户、关闭系统或关闭并重新启动系统。
/// 
/// See alseo:
/// https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-exitwindowsex
class FlutterExitWindowsEx {
  static const MethodChannel _channel =
      const MethodChannel('flutter_exit_windows_ex');

  static Future<bool> exitWindowsEx(int uFlags) async {
    return await _channel.invokeMethod('exitWindowsEx', uFlags);
  }
}
