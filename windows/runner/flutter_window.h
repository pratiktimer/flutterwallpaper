#ifndef FLUTTER_WINDOW_H_
#define FLUTTER_WINDOW_H_

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>

#include <memory>

#include "win32_window.h"

class FlutterWindow : public Win32Window {
 public:
  FlutterWindow(const flutter::DartProject& project);
  virtual ~FlutterWindow();

 protected:
  bool OnCreate() override;
  void OnDestroy() override;
  LRESULT MessageHandler(HWND hwnd, UINT const message, WPARAM const wparam, LPARAM const lparam) noexcept override;

 private:
  std::unique_ptr<flutter::FlutterViewController> flutter_controller_;
  flutter::DartProject project_;
};

#endif  // FLUTTER_WINDOW_H_
