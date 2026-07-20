# Catalog Browser

A Flutter application that displays a searchable catalog of 2,000 mock products with category filtering, favorite management, and a live summary. The project was built as a take-home assignment with a strong focus on Clean Architecture, rendering efficiency, and smooth performance.

---

## Project Overview

The application loads an in-memory dataset of 2,000 products, each containing an ID, name, category, price, and placeholder image. Users can browse the catalog, search products by name, filter by category, mark products as favorites, and view a persistent summary showing the number of favorite items and their total price.

No backend or API is used, as required by the assignment.

---

## Approach

The project follows **Clean Architecture**, separating the application into three layers:

* **Domain:** Business entities and repository contracts.
* **Data:** In-memory data source and repository implementation.
* **Presentation:** GetX controller, screens, and reusable widgets.

**GetX** was selected because it is lightweight, fast, and well-suited for a feature of this size. It provides simple reactive state management with minimal boilerplate, making it easy to keep business logic separate from the UI while ensuring efficient widget updates. This allowed the application to update only the affected widgets (such as a single favorite button or the summary card) without rebuilding the entire product list, helping maintain smooth scrolling and responsive interactions.

---

## Performance Decisions

Performance was the primary focus during implementation.

The following techniques were used:

* `GridView.builder` for lazy rendering of products.
* 300ms debounced search to prevent unnecessary filtering while typing.
* Efficient filtering over an in-memory dataset.
* Per-item reactive updates so toggling a favorite rebuilds only the affected product card instead of the entire list.
* Cached network images with placeholders.
* Use of `const` widgets where applicable to reduce unnecessary rebuilds.
* Preservation of scroll position during favorite updates.

---

## Trade-offs

Since the assignment explicitly requested an in-memory dataset, products are generated locally instead of using Firebase or a REST API. The repository abstraction was maintained so the local data source can easily be replaced with a remote implementation in the future without affecting the presentation layer.

Category filtering was added as a small enhancement to complement the provided UI design while preserving the required search functionality.

---

## Performance Verification

Performance was verified using:

* `flutter analyze` to ensure a clean codebase.
* Manual testing with 2,000 products.
* Rapid typing tests to verify smooth debounced search.
* Continuous scrolling to ensure no noticeable jank.
* Favorite toggling while scrolling to verify instant updates and preserved scroll position.

---

## Assumptions

* Products are generated locally because no backend or API was provided.
* Placeholder network images are used for demonstration purposes.
* Category filtering was added to improve the browsing experience while maintaining all assignment requirements.

---

## AI Usage

AI tools (Google Gemini and Antigravity IDE) were used to help scaffold parts of the feature, generate initial widget layouts, and review architecture and performance decisions. All AI-generated code was manually reviewed, adapted to the project's architecture, and validated through `flutter analyze` and manual testing before submission.
