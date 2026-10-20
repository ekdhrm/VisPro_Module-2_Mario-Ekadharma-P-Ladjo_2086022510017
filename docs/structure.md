# Architectural Breakdown

To fulfill the AFL 1 requirement of keeping files under ~200 lines and maintaining a single, consistent convention, the application is separated into a feature-based folder structure:

*   **`lib/core/`**: Contains only genuinely shared, application-wide configurations. 
    *   `colors.dart` defines the centralized color palette.
    *   `theme.dart` provides the Material 3 `ThemeData` for both light and dark modes, ensuring zero hard-coded colors exist in the UI feature code.
*   **`lib/model/`**: Houses the pure data structures.
    *   `game.dart` defines `GameProgress` and `TodoItem`. Separating this early ensured strong typing across the app instead of passing raw Maps or Strings between screens.
*   **`lib/screens/`**: Contains the top-level routing destinations. These act as "smart" components that manage page-level state and layout.
    *   `home_screen.dart`: Manages the main list state, search filtering, and assembles the smaller widgets.
    *   `detail_screen.dart`: Uses a `CustomScrollView` and `SliverAppBar` for the detailed hero view.
    *   `add_screen.dart`: Manages form validation and captures user input.
*   **`lib/widgets/`**: Contains reusable, "dumb" UI components (e.g., `game_card.dart`, `game_search_field.dart`, `progress_summary.dart`). These widgets rely entirely on data passed through their constructors and bubble user interactions back up via callback functions. Extracting these ensured the screen files remained strictly under the size limit.