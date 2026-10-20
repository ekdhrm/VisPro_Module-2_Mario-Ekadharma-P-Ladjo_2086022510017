# Week 5 Reflection

**1. Which structural decision from Week 1 helped you most by Week 5?**
Strictly defining the `GameProgress` data model and separating my UI into the `lib/widgets/` directory helped the most. When it came time to implement complex UI features like the search filter or the Material 3 `CustomScrollView` in the Detail Screen, I didn't have to fight a massive 600-line widget tree. Passing strongly typed objects to clean, isolated widgets made it easy to meet the <200 lines-per-file constraint.

**2. Which one cost you time, and what would you do differently?**
Initially testing the application inside a massive, monolithic `LabHarness` directly in `main.dart` cost me a lot of refactoring time. I had to manually untangle the mock data, the theme testing constraints, and the UI layout into the correct `core/`, `screens/`, and `widgets/` folders later on. Next time, I will set up the proper directory architecture on day one and build components in isolation rather than writing a giant test environment first.

**3. Where is your app's state right now, and what will be hard about moving it in Module 2?**
Right now, the app's state (the list of games and the search query) is completely local, managed via `setState` inside `HomeScreen`. When adding a new game, I rely on `Navigator.pop(context, newGame)` to pass data back and manually update the array. Moving into Module 2 (which will likely introduce proper State Management like Provider, Riverpod, or BLoC), the hardest part will be decoupling this state from the UI tree. I will have to rip out the `Navigator.pop` logic, lift `_allGames` into a global controller or provider, and rewrite the screens to passively listen to state changes rather than actively mutating local variables.