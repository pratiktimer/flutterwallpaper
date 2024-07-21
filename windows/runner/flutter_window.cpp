#include "flutter_window.h"

#include <optional>
#include <urlmon.h>

#include "flutter/generated_plugin_registrant.h"
#include "flutter/method_channel.h"
#include "flutter/standard_method_codec.h"

#pragma comment(lib, "urlmon.lib")

bool DownloadImage(const std::wstring &url, const std::wstring &file_path) {
  HRESULT hr = URLDownloadToFile(nullptr, url.c_str(), file_path.c_str(), 0, nullptr);
  return SUCCEEDED(hr);
}

void SetWallpaper(const std::wstring &file_path) {
  SystemParametersInfoW(SPI_SETDESKWALLPAPER, 0, (void *)file_path.c_str(), SPIF_UPDATEINIFILE | SPIF_SENDCHANGE);
}

FlutterWindow::FlutterWindow(const flutter::DartProject& project)
    : project_(project) {}

FlutterWindow::~FlutterWindow() {}

bool FlutterWindow::OnCreate() {
  if (!Win32Window::OnCreate()) {
    return false;
  }

  RECT frame = GetClientArea();

  flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
      frame.right - frame.left, frame.bottom - frame.top, project_);

  if (!flutter_controller_->engine() || !flutter_controller_->view()) {
    return false;
  }

  RegisterPlugins(flutter_controller_->engine());
  SetChildContent(flutter_controller_->view()->GetNativeWindow());

  flutter_controller_->engine()->SetNextFrameCallback([&]() {
    this->Show();
  });

  flutter_controller_->ForceRedraw();

  // Set up the method channel
  auto channel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
      flutter_controller_->engine()->messenger(), "your_channel_name",
      &flutter::StandardMethodCodec::GetInstance());

  channel->SetMethodCallHandler(
      [](const flutter::MethodCall<flutter::EncodableValue> &call,
         std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        if (call.method_name().compare("setWallpaperFromUrl") == 0) {
          const auto *arguments = std::get_if<flutter::EncodableMap>(call.arguments());
          if (arguments) {
            auto url = std::get_if<std::string>(&arguments->at(flutter::EncodableValue("url")));
            auto file_path = std::get_if<std::string>(&arguments->at(flutter::EncodableValue("filePath")));
            if (url && file_path) {
              std::wstring w_url = std::wstring(url->begin(), url->end());
              std::wstring w_file_path = std::wstring(file_path->begin(), file_path->end());
              if (DownloadImage(w_url, w_file_path)) {
                SetWallpaper(w_file_path);
                result->Success(flutter::EncodableValue(true));
                return;
              }
            }
          }
          result->Error("Invalid Arguments", "Invalid arguments provided to method");
        } else {
          result->NotImplemented();
        }
      });

  return true;
}

void FlutterWindow::OnDestroy() {
  if (flutter_controller_) {
    flutter_controller_ = nullptr;
  }

  Win32Window::OnDestroy();
}

LRESULT FlutterWindow::MessageHandler(HWND hwnd, UINT const message, WPARAM const wparam, LPARAM const lparam) noexcept {
  if (flutter_controller_) {
    std::optional<LRESULT> result =
        flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam, lparam);
    if (result) {
      return *result;
    }
  }

  switch (message) {
    case WM_FONTCHANGE:
      flutter_controller_->engine()->ReloadSystemFonts();
      break;
  }

  return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}
