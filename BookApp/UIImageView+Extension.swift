import UIKit

extension UIImageView {
    final func loadImageFromUrl(path: Int?, size: CoverSize) {
        let pathString = String(path ?? 0)
        let urlString = "https://covers.openlibrary.org/b/id/\(pathString)-\(size.rawValue).jpg"
        let placeholder = UIImage(systemName: "photo.circle")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        self.image = placeholder

        let imageCache = NSCache<NSString, UIImage>()
        let key = NSString(string: urlString)

        if let cachedImage = imageCache.object(forKey: key) {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async() {
                if let data = data,
                   let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: key)
                    self.image = image
                }
            }
        }
        task.resume()
    }
}

enum CoverSize: String {
    case m = "M"
    case l = "L"
}
