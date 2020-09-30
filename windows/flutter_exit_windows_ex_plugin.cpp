#include "include/flutter_exit_windows_ex/flutter_exit_windows_ex_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <map>
#include <memory>
#include <sstream>
#include <iostream>

namespace {
  using namespace std;

  class FlutterExitWindowsExPlugin : public flutter::Plugin {
  public:
    static void RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar);

    FlutterExitWindowsExPlugin();

    virtual ~FlutterExitWindowsExPlugin();

  private:
    // Called when a method is called on this plugin's channel from Dart.
    void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
  };

  // static
  void FlutterExitWindowsExPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows* registrar) {
    auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
        registrar->messenger(), "flutter_exit_windows_ex",
        &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<FlutterExitWindowsExPlugin>();

    channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto& call, auto result) {
      plugin_pointer->HandleMethodCall(call, std::move(result));
    });

    registrar->AddPlugin(std::move(plugin));
  }

  FlutterExitWindowsExPlugin::FlutterExitWindowsExPlugin() {}

  FlutterExitWindowsExPlugin::~FlutterExitWindowsExPlugin() {}

  void FlutterExitWindowsExPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue>& mc,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> r) {

    if (mc.method_name().compare("exitWindowsEx") == 0)
    {
      const auto* uFlags = get_if<int>(mc.arguments());
      if (!uFlags)
      {
        r->Error("arguments Error.");
        return;
      }

      HANDLE hToken;
      if (!OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &hToken))
      {
        r->Success(false);
        return;
      }


      // 获取关闭特权的LUID
      TOKEN_PRIVILEGES tkp;
      LookupPrivilegeValue(NULL, SE_SHUTDOWN_NAME, &tkp.Privileges[0].Luid);

      tkp.PrivilegeCount = 1;  // one privilege to set    
      tkp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;

      // 获取此过程的关闭特权。
      AdjustTokenPrivileges(hToken, FALSE, &tkp, 0, (PTOKEN_PRIVILEGES)NULL, 0);

      if (GetLastError() != ERROR_SUCCESS)
      {
        CloseHandle(hToken);
        r->Success(false);
        return;
      }

      if (!ExitWindowsEx(*uFlags, SHTDN_REASON_MAJOR_OPERATINGSYSTEM | SHTDN_REASON_MINOR_UPGRADE | SHTDN_REASON_FLAG_PLANNED))
      {
        CloseHandle(hToken);
        r->Success(false);
        return;
      }

      r->Success(true);
      return;
    }

    r->NotImplemented();
  }

}  // namespace

void FlutterExitWindowsExPluginRegisterWithRegistrar(
  FlutterDesktopPluginRegistrarRef registrar) {
  FlutterExitWindowsExPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarManager::GetInstance()
    ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
