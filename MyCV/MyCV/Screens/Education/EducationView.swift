//
//  EducationView.swift
//  MyCV
//

import SwiftUI

struct EducationView: View {

    @State private var viewModel = EducationViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Hero image: fills ~45% of the screen height and crops the overflow.
            Color.clear
                .containerRelativeFrame(.vertical) { height, _ in height * 0.45 }
                .overlay {
                    Image("edtech")
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
                .padding(.vertical, 12)
        }
        .sectionNavigationBar(title: viewModel.title)
        .task {
            await viewModel.load()
        }
    }

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
                            .font(.custom("GillSans-Italic", size: 18))
                            .foregroundStyle(selection == page ? Color(.accent) : Color(.segmentGray))
                            .frame(maxWidth: .infinity, minHeight: 32)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                }
            }

            GeometryReader { geometry in
                let segmentWidth = geometry.size.width / CGFloat(EducationViewModel.Page.allCases.count)

                Rectangle()
                    .fill(Color(.accent))
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
        HStack(spacing: 8) {
            ForEach(EducationViewModel.Page.allCases) { page in
                Circle()
                    .fill(page == selection ? Color(.accent) : Color(.lightGray))
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
            .font(.title3)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

private struct UniversityPage: View {

    let details: [EducationViewModel.UniversityDetail]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(details) { detail in
                    UniversityDetailRow(title: detail.title, value: detail.value)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
        }
    }

}

private struct UniversityDetailRow: View {

    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(title)
                .font(.headline)
                .frame(width: 110, alignment: .leading)
            Text(value)
                .font(.body)
        }
    }

}

private struct CoursesPage: View {

    let courses: [EducationViewModel.Course]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(courses) { course in
                    Text(verbatim: "\(course.number). \(course.name)")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
        }
    }

}

#Preview {
    SectionSheet {
        EducationView()
    }
}
