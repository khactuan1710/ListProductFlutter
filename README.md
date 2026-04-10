# Product List App

Flutter demo app hiển thị danh sách sản phẩm và trang chi tiết sản phẩm từ API `dummyjson.com`.

## Architecture Overview

Ứng dụng đang áp dụng **Clean Architecture** kết hợp **MVVM-like (Cubit làm ViewModel)**.

```text
UI (Pages/Widgets)
    ↓
ViewModel (Cubit + State)
    ↓
Domain (Repository Interface + Entities)
    ↓
Data (Repository Impl + API Service + Models)
    ↓
Remote API (dummyjson.com)
```

## Project Structure (`lib/`)

```text
lib/
├── main.dart
├── domain/
│   ├── entities/
│   │   ├── product.dart
│   │   └── product_rating.dart
│   └── repositories/
│       └── product_repository_interface.dart
├── data/
│   ├── datasources/
│   │   ├── logger/
│   │   │   └── logging_client.dart
│   │   └── product_api_service.dart
│   ├── models/
│   │   └── product_model.dart
│   ├── repositories/
│   │   └── product_repository_impl.dart
│   └── exceptions/
│       └── product_api_exception.dart
└── presentation/
    ├── router/
    │   └── app_router.dart
    ├── cubits/
    │   ├── product_list/
    │   │   ├── product_list_cubit.dart
    │   │   └── product_list_state.dart
    │   └── product_detail/
    │       ├── product_detail_cubit.dart
    │       └── product_detail_state.dart
    ├── pages/
    │   ├── product_list_page.dart
    │   └── product_detail_page.dart
    └── widgets/
        ├── product_list_view.dart
        ├── product_card.dart
        └── error_view.dart
```

## Responsibility By Layer

- **Presentation**: render UI, điều hướng màn hình, xử lý loading/error/success state.
- **Cubit (ViewModel)**: nhận action từ UI, gọi repository, emit state cho UI.
- **Domain**: định nghĩa entity và contract `ProductRepository` độc lập với data source.
- **Data**: gọi API, parse JSON sang model, map model -> entity, quản lý cache in-memory.
- **Exception handling**: gom lỗi HTTP/network/parse thành lỗi nghiệp vụ dễ hiển thị trên UI.

## Main Features

- Xem danh sách sản phẩm từ API.
- Pull-to-refresh danh sách.
- Xem chi tiết sản phẩm theo `id`.
- Cache dữ liệu ở repository để giảm gọi lại API không cần thiết.
- Hiển thị trạng thái loading / error / empty rõ ràng.

## Quick Start

```bash
flutter pub get
flutter run
```
