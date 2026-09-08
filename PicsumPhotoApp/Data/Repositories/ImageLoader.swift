import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 150 // Tối ưu dung lượng RAM
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        let cacheKey = NSString(string: urlString)
        
        // Trả về ảnh ngay lập tức nếu đã lưu trong Memory Cache
        if let cachedImage = cache.object(forKey: cacheKey) {
            completion(cachedImage)
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return nil
        }
        
        // Tải ảnh bất đồng bộ (Async) tránh gây lag UI khi scroll
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            self?.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
        return task
    }
}