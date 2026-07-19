# Catalog Browser

A Flutter application that displays and browses a catalog of 2,000 products with real-time search, category filtering, favorite management, and a live summary — all running entirely in-memory with no backend dependency.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Architecture](#2-architecture)
3. [State Management](#3-state-management)
4. [Performance Decisions](#4-performance-decisions)
5. [Functional Features](#5-functional-features)
6. [Performance Verification](#6-performance-verification)
7. [Trade-offs](#7-trade-offs)
8. [AI Usage](#8-ai-usage)
9. [Validation Checklist](#9-validation-checklist)

---

## 1. Project Overview

Catalog Browser is a Flutter feature that lets users explore a catalog of 2,000 products generated deterministically in memory. Users can:

- Browse all products in a paginated 2-column grid
- Search products by name with debounced input
- Filter by category using a horizontal chip bar
- Favorite individual products and track the aggregate count and total price in a persistent summary card
- Experience graceful loading, empty, and error states throughout

The feature was built as a take-home assignment demonstrating Clean Architecture, GetX state management, and Flutter performance best practices.

---

## 2. Architecture

### Clean Architecture

The feature follows a strict three-layer Clean Architecture, which was maintained throughout all 12 implementation phases:

```
lib/features/catalog/
├── domain/                      # Layer 1 — pure business rules
│   ├── entities/
│   │   └── product_entity.dart  # Immutable domain model (Equatable)
│   └── repositories/
│       └── catalog_repository.dart  # Abstract contract (no impl details)
│
├── data/                        # Layer 2 — data source + mapping
│   ├── models/
│   │   └── product_model.dart   # Extends ProductEntity (no extra fields)
│   ├── datasources/
│   │   └── catalog_local_data_source.dart  # In-memory generator, cached
│   └── repositories/
│       └── catalog_repository_impl.dart    # Implements domain contract
│
└── presentation/                # Layer 3 — UI and state
    ├── controllers/
    │   └── catalog_controller.dart  # All business logic for the feature
    ├── screens/
    │   └── catalog_screen.dart      # Pure view, no logic
    └── widgets/
        ├── product_card_widget.dart
        ├── summary_card_widget.dart
        ├── category_filter_widget.dart
        └── search_bar_widget.dart
```

### Layer Responsibilities

| Layer | Responsibility | Depends on |
|---|---|---|
| **Domain** | Defines the `ProductEntity` contract and the `CatalogRepository` interface. No Flutter imports, no data source knowledge. | Nothing |
| **Data** | Implements `CatalogRepository` using an in-memory `CatalogLocalDataSource`. `ProductModel` extends `ProductEntity` to avoid unnecessary mapping code. | Domain |
| **Presentation** | `CatalogController` holds all state. Widgets are pure receivers of data and callbacks. No `BuildContext` in the controller. | Domain |

### Why Clean Architecture Was Maintained

- **Testability** — each layer can be tested in isolation. The domain has no Flutter dependency. The controller can be unit-tested by injecting a mock `CatalogRepository`.
- **Replaceability** — swapping the local data source for a remote API (e.g. Dio + REST or Firebase) requires changing only the data layer. The domain and presentation layers stay identical.
- **Clarity** — strict separation enforces a single-responsibility discipline that makes reasoning about each file straightforward.

---

## 3. State Management

### Why GetX

GetX was already established in the project template. It was retained because:

- **Zero boilerplate for reactive state** — `RxBool`, `RxInt`, `RxDouble`, `RxList`, and `Rxn<T>` remove the need for `StreamController` or `ChangeNotifier` wrappers.
- **Fine-grained `Obx` scope** — each `Obx` subscribes only to the specific `Rx` values it reads. This makes surgical rebuild targeting straightforward.
- **Dependency injection** — `Get.find<CatalogController>()` provides controller instances anywhere without `BuildContext`.

### How State Updates Are Handled Efficiently

The controller manages four distinct reactive scopes, each updating independently:

| Scope | Rx backing | Triggered by |
|---|---|---|
| Product grid | `RxList<ProductEntity> _filteredProducts` | search / category filter changes |
| Per-card favorite icon | `Map<String, RxBool> _favoriteRxMap` | `toggleFavorite()` |
| Summary card | `RxInt _favoriteCount` + `RxDouble _favoriteTotalPrice` | `toggleFavorite()` |
| UI state (loading / error) | `RxBool _isLoading` + `Rxn<String> _errorMessage` | `loadProducts()` |

### How Rebuilds Are Minimized

**Favorite toggle** — the most frequent interaction — performs exactly three O(1) writes:
1. Replace the element in `_allProducts` (plain `List`, not reactive — the master list is never observed by UI directly)
2. Flip `_favoriteRxMap[id].value` → triggers **only** the `Obx` wrapping the tapped card
3. Increment/decrement `_favoriteCount` and adjust `_favoriteTotalPrice` → triggers **only** the summary `Obx`

The grid structure (`_filteredProducts`) is never touched on a favorite toggle. Scroll position and all other cards are completely unaffected.

---

## 4. Performance Decisions

### `GridView.builder` / `ListView.builder`

The product grid uses `GridView.builder`, which creates items lazily. With 2,000 products only the ~10 visible cards are alive in memory at any time. Scrolled-away cards are disposed. No full-list widget tree is ever built.

### 300 ms Search Debounce

`CatalogController.onSearchChanged()` cancels and restarts a `Timer(_kDebounceDelay, _applyFilters)` on every keystroke. The `_applyFilters` call (which scans up to 2,000 items) only fires after the user pauses for 300 ms. This eliminates redundant filter passes during fast typing.

### Single-Pass `_applyFilters`

When both category and search filters are active, the implementation uses a single combined `where()` predicate instead of two sequential `where().toList()` calls. This avoids allocating an intermediate list on every filter operation.

### Single-Pass `loadProducts` Initialisation

At startup the controller iterates `_allProducts` exactly once to simultaneously:
- Populate `_favoriteRxMap` (one `RxBool` per product)
- Seed `_favoriteCount` and `_favoriteTotalPrice`

Two separate passes (which were the original implementation) have been collapsed into one.

### Per-Card `Obx` Wrapping

Each `ProductCardWidget` is wrapped in its own `Obx` that reads only `controller.isFavorite(productId)`. This `RxBool` is owned exclusively by that product. When a user taps the heart, GetX rebuilds exactly one `Obx` — never the grid.

### `const` Widget Propagation

- `_CatalogAppBar` has a `const` constructor and is instantiated with `const`. The AppBar subtree is identity-stable across rebuilds.
- All `SizedBox`, `EdgeInsets`, `BorderRadius`, `SliverGridDelegate`, and icon widgets in the subtree are `const`.
- The skeleton loading grid constants (`_kSkeletonCardCount = 8`) are named to avoid magic numbers.

### Shimmer Colour Computation

The loading skeleton's `AnimationController` drives `AnimatedBuilder`. The theme-derived shimmer colours (`base`, `highlight`) are computed once per frame at the `AnimatedBuilder` level, then passed as constructor parameters to all 8 `_SkeletonCard` instances. This avoids 8 redundant `Theme.of(context)` calls per animation frame.

### Cached Network Images

Product images are loaded via `CustomCachedImage` (backed by `cached_network_image_plus`). Images are cached to disk on first load and served from cache on subsequent scrolls. A lightweight placeholder is shown during loading and an error widget is shown on failure — no blank or broken image states.

### Scroll Position Preservation

Because `_filteredProducts` is untouched by `toggleFavorite`, the `GridView.builder` receives no new `itemCount` or item identity changes on a favorite tap. The `ScrollController` position is naturally preserved.

### Category Cache

`_buildCategories()` is called exactly once after `loadProducts()` completes and the result is stored in `_cachedCategories`. Category chip rendering never re-scans `_allProducts`.

---

## 5. Functional Features

| Feature | Status |
|---|---|
| Display 2,000 products in a 2-column grid | ✔ |
| Deterministic, seeded product data (stable across runs) | ✔ |
| Real-time name search | ✔ |
| 300 ms debounce on search input | ✔ |
| Category filter chips (horizontal scrollable) | ✔ |
| Combined search + category filter | ✔ |
| Favorite toggle per product | ✔ |
| Live summary — favorite count | ✔ |
| Live summary — total favorite price | ✔ |
| Summary always reflects ALL products (not just visible) | ✔ |
| Shimmer skeleton loading state | ✔ |
| Empty state with "Clear Filters" button | ✔ |
| Error state with retry button | ✔ |
| Cached network images with placeholder and error widget | ✔ |
| Scroll position preserved on favorite toggle | ✔ |

---

## 6. Performance Verification

### Tools Used

| Tool | Purpose |
|---|---|
| **`flutter analyze`** | Static analysis — run after every phase. Zero issues on final submission. |
| **`dart format`** | Formatting consistency — applied to all 11 files in the feature directory. |
| **Flutter DevTools → Performance** | Frame timeline inspection for jank during scroll and favorite toggle. |
| **Flutter DevTools → Widget Rebuild Tracker** | Verified that toggling a favorite rebuilds exactly one `Obx` (the card) + one `Obx` (the summary), not the grid. |
| **Performance Overlay** (`showPerformanceOverlay: true`) | Visual confirmation that the UI thread and raster thread remain below 16 ms during grid scroll. |
| **Manual scrolling tests** | Fling scroll from top to bottom of 2,000-item grid verified to be jank-free. |

### What Was Tested

- **Scroll performance** — fling scroll through the full 2,000-item grid, both with and without an active search filter.
- **Search + debounce** — rapid typing confirmed that `_applyFilters` fires only once per keystroke burst, not on every character.
- **Favorite toggle** — tapping the heart icon while the grid is scrolled mid-way confirms the scroll position does not jump.
- **Summary correctness** — favorites toggled while a search filter is active still update the summary with the full count, not the filtered count.
- **State transitions** — forced error state by temporarily returning a thrown exception from `getProducts()` to verify the error screen and retry button behave correctly.
- **Clear Filters** — confirmed that the "Clear Filters" button in the empty state resets both the search text and category chip simultaneously.

---

## 7. Trade-offs

### In-Memory Data Source

The assignment specifies 2,000 products without a backend requirement. An in-memory generator (`CatalogLocalDataSourceImpl`) was used because:

- It satisfies the stated requirements without introducing network latency variability that would complicate performance testing.
- The `CatalogRepository` abstraction means the data source can be replaced with a Dio/REST or Firebase implementation by changing only `catalog_repository_impl.dart` and registering a different binding — zero changes to the domain or presentation layers.
- The generated data uses a fixed random seed (`Random(42)`) to produce stable, reproducible products across runs.

### No Firebase / Remote Backend

Firebase was not introduced because:
- The assignment does not require persistence or real-time sync.
- Adding Firebase would introduce network dependency, authentication concerns, and quota management that are outside the scope of a catalog browser UI exercise.
- The clean architecture means Firebase could be added as a new data source without touching the controller or any widget.

### `ProductModel extends ProductEntity`

Rather than writing a separate mapping function (`ProductModel.toEntity()`), `ProductModel` simply extends `ProductEntity`. This is a deliberate trade-off: it keeps the data layer minimal and avoids boilerplate copy-constructors when the data model and the domain entity are identical in structure. In a production scenario where the API response shape differs from the domain model, a separate mapping function would be warranted.

### Favorite State Is In-Memory Only

Favorite state is not persisted between app launches. This matches the assignment scope. Persistence could be added by writing to `get_storage` inside `toggleFavorite()` — the controller's encapsulation means no other file would need changing.

---

## 8. AI Usage

AI assistance (Google Gemini / Antigravity IDE) was used throughout the implementation of this assignment.

### What AI Helped With

- **Phase scaffolding** — generating the initial Clean Architecture folder structure and boilerplate (entity, repository interface, model, repository implementation, controller skeleton, binding).
- **Widget layout** — producing the initial `ProductCardWidget`, `SummaryCardWidget`, and `CategoryFilterWidget` layout code, which was then reviewed and adjusted.
- **Reactive architecture decisions** — the `Map<String, RxBool>` per-card approach (Phase 9) and the `RxInt`/`RxDouble` accumulator pattern (Phase 10) were proposed by the AI and accepted after manual review of their correctness.
- **Shimmer skeleton implementation** — the `AnimationController` + `ShaderMask` + `LinearGradient` sweep approach was AI-generated and accepted as it avoids a third-party dependency.
- **Performance review** — Phase 12 identified the double-pass initialisation, intermediate list allocation in `_applyFilters`, and `Theme.of(context)` call duplication in the skeleton builder.
- **Documentation** — this README was drafted with AI assistance.

### What Was Modified or Rejected

- Several AI suggestions to use `GetBuilder` instead of `Obx` were rejected because `Obx` with explicit `Rx` fields provides finer-grained rebuild control for this use case.
- An early suggestion to store the full filtered list in an `RxList` and update it on every favorite toggle was rejected; instead, favorites are tracked separately so the product list is never reassigned on a toggle.
- AI-generated `_applyFilters` originally used two chained `.where().toList()` calls sequentially; this was accepted initially and then refactored in Phase 12 into a single-pass combined predicate.

### Verification

All AI-generated code was manually reviewed for correctness, idiomatic Dart style, and adherence to the Clean Architecture boundaries before being committed. `flutter analyze` was run after every phase to confirm zero lints.

---

## 9. Validation Checklist

### Static Analysis

| Check | Result |
|---|---|
| `flutter analyze lib/features/catalog` | ✅ No issues found |
| `dart format lib/features/catalog` | ✅ 0 files changed (already formatted) |
| Debug `print()` statements | ✅ None |
| `TODO` / `FIXME` / `HACK` comments | ✅ None |
| Dead code / unreachable branches | ✅ None |
| Unused imports | ✅ None |

### Architecture Review

| Criterion | Result |
|---|---|
| Clean Architecture respected | ✅ Domain has zero Flutter/data dependencies |
| SOLID principles followed | ✅ SRP per layer; OCP via repository abstraction; DIP via injected `CatalogRepository` |
| Naming conventions consistent | ✅ `_kConstantName`, `_privateField`, `publicMethod`, `WidgetName` throughout |
| Widgets are reusable and presentation-only | ✅ No business logic in any widget |
| Code is readable and documented | ✅ Every public API has a doc comment |
| Folder structure organised | ✅ `domain / data / presentation` with `entities / repositories / models / datasources / controllers / screens / widgets` |

### Functional Verification

| Scenario | Expected | Verified |
|---|---|---|
| Scroll 2,000 items | Smooth, no jank | ✅ |
| Type quickly in search | Filter fires once after pause | ✅ |
| Select category while search active | Both filters applied, single pass | ✅ |
| Toggle favorite mid-scroll | Only heart icon rebuilds, position preserved | ✅ |
| Summary with active search | Reflects ALL favorites, not just visible | ✅ |
| Clear Filters button | Resets search and category simultaneously | ✅ |
| Retry after error | Calls `loadProducts()` cleanly | ✅ |
