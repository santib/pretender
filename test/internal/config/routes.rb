Rails.application.routes.draw do
  root "home#index"
  post "impersonate" => "home#impersonate"
  post "stop_impersonating" => "home#stop_impersonating"

  get "page" => "page#index"
  post "page/impersonate" => "page#impersonate"
  post "page/stop_impersonating" => "page#stop_impersonating"
end
