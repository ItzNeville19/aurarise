import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var appState: AppState
    @State var searchText = ""
    @State var selectedSport: Sport? = nil
    @State var selectedCategory: String? = nil

    var filteredTricks: [Trick] {
        var tricks = appState.tricksForSport(selectedSport ?? appState.selectedSport)

        if !searchText.isEmpty {
            tricks = tricks.filter { trick in
                trick.name.localizedCaseInsensitiveContains(searchText) ||
                    trick.description.localizedCaseInsensitiveContains(searchText)
            }
        }

        if let category = selectedCategory {
            tricks = tricks.filter { $0.category == category }
        }

        return tricks.sorted { $0.progressionLevel.rawValue < $1.progressionLevel.rawValue }
    }

    var availableCategories: [String] {
        let tricks = appState.tricksForSport(selectedSport ?? appState.selectedSport)
        let categories = Set(tricks.map { $0.category })
        return categories.sorted()
    }

    var body: some View {
        NavigationStack {
            ZStack {
                StompColors.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: StompSpacing.sm) {
                        Text("Trick Library")
                            .font(StompTypography.captionLarge)
                            .foregroundColor(StompColors.textSecondary)
                            .tracking(1)

                        Text("Learn Your Skills")
                            .font(StompTypography.headingLarge)
                            .foregroundColor(StompColors.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, StompSpacing.md)
                    .padding(.vertical, StompSpacing.lg)

                    ScrollView {
                        VStack(spacing: StompSpacing.lg) {
                            // Search bar
                            HStack(spacing: StompSpacing.sm) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(StompColors.textSecondary)

                                TextField("Search tricks...", text: $searchText)
                                    .foregroundColor(StompColors.textPrimary)
                                    .tint(StompColors.accent)

                                if !searchText.isEmpty {
                                    Button(action: { searchText = "" }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(StompColors.textSecondary)
                                    }
                                }
                            }
                            .padding(StompSpacing.md)
                            .stompSurface()

                            // Sport filter
                            VStack(alignment: .leading, spacing: StompSpacing.sm) {
                                Text("Sport")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(StompColors.textSecondary)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: StompSpacing.sm) {
                                        ForEach(Sport.allCases) { sport in
                                            SportFilterButton(
                                                sport: sport,
                                                isSelected: selectedSport == sport || (selectedSport == nil && sport == appState.selectedSport),
                                                action: {
                                                    selectedSport = selectedSport == sport ? nil : sport
                                                    selectedCategory = nil
                                                }
                                            )
                                        }
                                    }
                                }
                            }

                            // Category filter
                            if !availableCategories.isEmpty {
                                VStack(alignment: .leading, spacing: StompSpacing.sm) {
                                    Text("Category")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(StompColors.textSecondary)

                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: StompSpacing.sm) {
                                            ForEach(availableCategories, id: \.self) { category in
                                                CategoryFilterButton(
                                                    category: category,
                                                    isSelected: selectedCategory == category,
                                                    action: {
                                                        selectedCategory = selectedCategory == category ? nil : category
                                                    }
                                                )
                                            }
                                        }
                                    }
                                }
                            }

                            // Tricks
                            VStack(alignment: .leading, spacing: StompSpacing.sm) {
                                Text("\(filteredTricks.count) tricks")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(StompColors.textSecondary)

                                VStack(spacing: StompSpacing.sm) {
                                    ForEach(filteredTricks) { trick in
                                        TrickLibraryCard(trick: trick)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, StompSpacing.md)
                        .padding(.bottom, StompSpacing.lg)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Component: Sport Filter Button

struct SportFilterButton: View {
    let sport: Sport
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(sport.displayName)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(isSelected ? .white : StompColors.textSecondary)
                .padding(.horizontal, StompSpacing.md)
                .padding(.vertical, StompSpacing.xs)
                .background(isSelected ? StompColors.accent : StompColors.surfaceSecondary)
                .cornerRadius(StompRadius.md)
                .overlay(
                    RoundedRectangle(cornerRadius: StompRadius.md)
                        .stroke(isSelected ? StompColors.accent : StompColors.border, lineWidth: 1)
                )
        }
    }
}

// MARK: - Component: Category Filter Button

struct CategoryFilterButton: View {
    let category: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(category)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(isSelected ? .white : StompColors.textSecondary)
                .padding(.horizontal, StompSpacing.md)
                .padding(.vertical, StompSpacing.xs)
                .background(isSelected ? StompColors.accent : StompColors.surfaceSecondary)
                .cornerRadius(StompRadius.md)
                .overlay(
                    RoundedRectangle(cornerRadius: StompRadius.md)
                        .stroke(isSelected ? StompColors.accent : StompColors.border, lineWidth: 1)
                )
        }
    }
}

// MARK: - Component: Trick Library Card

struct TrickLibraryCard: View {
    let trick: Trick

    var body: some View {
        VStack(alignment: .leading, spacing: StompSpacing.sm) {
            HStack(spacing: StompSpacing.sm) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(trick.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(StompColors.textPrimary)

                    Text(trick.description)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(StompColors.textSecondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(trick.category)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(StompColors.accent)

                    Text(trick.progressionLevel.rawValue)
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(StompColors.textTertiary)
                }
            }

            Divider()
                .background(StompColors.border.opacity(0.5))

            VStack(alignment: .leading, spacing: StompSpacing.sm) {
                HStack(spacing: StompSpacing.sm) {
                    Text("Cue:")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(StompColors.textSecondary)

                    Text(trick.howToCue)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(StompColors.accentLight)
                }

                HStack(spacing: StompSpacing.sm) {
                    Text("Failure:")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(StompColors.textSecondary)

                    Text(trick.commonFailure)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(StompColors.textSecondary)
                }

                HStack(spacing: StompSpacing.sm) {
                    Text("Block:")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(StompColors.textSecondary)

                    Text(trick.mentalBlock)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(StompColors.warning)
                }
            }
        }
        .padding(StompSpacing.md)
        .stompSurface()
    }
}

#Preview {
    LibraryView()
        .environmentObject(AppState())
}
