_:

{

  # Power management.
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    powerKey = "hibernate";
    powerKeyLongPress = "poweroff";
  };

#   # 确保acpid服务不会与systemd-logind的行为冲突
#   services.acpid = {
#     enable = true;
#     lidEventCommands = "";
    
#     # 保持powerEventCommands可以让电源按钮事件使系统挂起。
#     powerEventCommands = "systemctl suspend";
#   };

}
