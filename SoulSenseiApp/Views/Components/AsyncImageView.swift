import SwiftUI

struct AsyncImageView: View {
    let url: String
    var contentMode: ContentMode = .fill

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.1))

            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)

            case .failure:
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.1))

            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    AsyncImageView(url: "https://soulsensei.gumlet.io/cc513743-5a91-491d-ad30-ed1a46ec0685.jpg")
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 12))
}
