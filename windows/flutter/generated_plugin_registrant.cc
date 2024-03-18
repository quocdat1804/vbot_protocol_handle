//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <protocol_handler_windows/protocol_handler_windows_plugin_c_api.h>
#include <windows_single_instance/windows_single_instance_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  ProtocolHandlerWindowsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ProtocolHandlerWindowsPluginCApi"));
  WindowsSingleInstancePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowsSingleInstancePlugin"));
}
