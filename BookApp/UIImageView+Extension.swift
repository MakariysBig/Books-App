import UIKit

extension UIImageView {
    func loadImageFromUrl(path: Int?, size: CoverSize) {
        guard let path = path else {
            self.image = UIImage(systemName: "photo.circle")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
            return
        }

        let urlString = "https://covers.openlibrary.org/b/id/\(path)-\(size.rawValue).jpg"
        let placeholder = UIImage(systemName: "photo.circle")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        self.image = placeholder

        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }
        task.resume()
    }
}

enum CoverSize: String {
    case m = "M"
    case l = "L"
}
