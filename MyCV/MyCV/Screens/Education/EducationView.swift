//
//  EducationView.swift
//  MyCV
//

import CoreUI
import Services
import SwiftUI

struct EducationView: View {

    init(viewModel: EducationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            // Hero image: fills ~45% of the screen height and crops the overflow.
            Color.clear
                .containerRelativeFrame(.vertical) { height, _ in height * 0.45 }
                .overlay {
                    Images.edtech.swiftUIImage
                        .resizable()
                        .scaledToFill()
                }
                .clipped()

            EducationTabs(selection: $viewModel.selectedPage)

            TabView(selection: $viewModel.selectedPage) {
                SchoolPage(school: viewModel.school)
                    .tag(EducationViewModel.Page.school)
                UniversityPage(details: viewModel.universityDetails)
                    .tag(EducationViewModel.Page.university)
                CoursesPage(courses: viewModel.courses)
                    .tag(EducationViewModel.Page.courses)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            PageIndicator(selection: viewModel.selectedPage)
                .padding(.vertical, Spacing.s)
        }
        .sectionNavigationBar(title: viewModel.title)
        .task {
            await viewModel.load()
        }
    }

    // MARK: - Private Properties

    @State private var viewModel: EducationViewModel

}

// MARK: - Tabs

/// Text-only tabs with an animated underline, replacing the custom segmented control.
private struct EducationTabs: View {

    @Binding var selection: EducationViewModel.Page

    private static let underlineHeight: CGFloat = 5

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(EducationViewModel.Page.allCases) { page in
                    Button {
                        selection = page
                    } label: {
                        Text(page.title)
                            .typography(.Interface.segment)
                            .foregroundStyle(
                                selection == page ? Colors.neonCyan.swiftUIColor : Colors.textSecondary.swiftUIColor
                            )
                            .frame(maxWidth: .infinity, minHeight: 32)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                }
            }

            GeometryReader { geometry in
                let segmentWidth = geometry.size.width / CGFloat(EducationViewModel.Page.allCases.count)

                Rectangle()
                    .fill(Colors.neonCyan.swiftUIColor)
                    .frame(width: segmentWidth, height: Self.underlineHeight)
                    .offset(x: segmentWidth * CGFloat(selection.rawValue))
            }
            .frame(height: Self.underlineHeight)
        }
        .animation(.easeInOut(duration: 0.3), value: selection)
    }

}

private struct PageIndicator: View {

    let selection: EducationViewModel.Page

    var body: some View {
        HStack(spacing: Spacing.xs) {
            ForEach(EducationViewModel.Page.allCases) { page in
                Circle()
                    .fill(page == selection ? Colors.neonCyan.swiftUIColor : Colors.hairline.swiftUIColor)
                    .frame(width: 7, height: 7)
            }
        }
    }

}

// MARK: - Pages

private struct SchoolPage: View {

    let school: String

    var body: some View {
        Text(school)
            .typography(.Interface.title3)
            .multilineTextAlignment(.center)
            .padding(.horizontal, Spacing.xl)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

private struct UniversityPage: View {

    let details: [EducationViewModel.UniversityDetail]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.s) {
                ForEach(details) { detail in
                    UniversityDetailRow(title: detail.title, value: detail.value)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Spacing.l)
        }
    }

}

private struct UniversityDetailRow: View {

    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: Spacing.s) {
            Text(title)
                .typography(.Interface.headline)
                .frame(width: 110, alignment: .leading)
            Text(value)
                .typography(.Interface.body)
        }
    }

}

private struct CoursesPage: View {

    let courses: [EducationViewModel.Course]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.s) {
                ForEach(courses) { course in
                    Text(verbatim: "\(course.number). \(course.name)")
                        .typography(.Interface.body)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Spacing.l)
        }
    }

}

#Preview {
    NavigationStack {
        EducationView(viewModel: EducationViewModel(service: ServiceBuilder.makeAPIService()))
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
