//
//  StartStartedSectionsView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows a glass button for each section of the CV.
struct StartStartedSectionsView: View {

    let configuration: StartStartedSectionsViewConfiguration

    // MARK: - View

    var body: some View {
        VStack(spacing: Spacing.xs) {
            ForEach(configuration.sections) { section in
                Button {
                    section.select()
                } label: {
                    Text(section.title)
                        .typography(.Interface.buttonLarge)
                        .foregroundStyle(Colors.textPrimary.swiftUIColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .rounded(.infinity)
                        .backgroundBlur(.regular, tint: Colors.glassFill.swiftUIColor)
                        .border(color: Colors.glassStroke.swiftUIColor, lineWidth: .m)
                        .boxShadow(.glass)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
