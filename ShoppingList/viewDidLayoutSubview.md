# `viewDidLayoutSubviews()` Metodu

`viewDidLayoutSubviews()` metodu, bir `UIViewController`'ın view'i ve altındaki bileşenlerin (subviews) yerleşim (layout) işlemleri tamamlandıktan sonra çağrılan bir metodudur.

## Özellikleri

- **Yerleşim İşlemleri Tamamlandıktan Sonra Çağrılır:** `viewDidLayoutSubviews()` metodu, view ve altındaki tüm subview'lerin yerleşim işlemleri tamamlandıktan sonra çağrılır. Yani, view ve subview'lerin boyutları ve konumları bu metodun içinde güncel durumdadır.

- **Manuel Boyutlandırma ve Konumlandırma İşlemleri İçin Uygundur:** `viewDidLayoutSubviews()` metodunu kullanarak, view ve subview'lerin boyutlarını veya konumlarını güncellemek mümkündür. Örneğin, ekran boyutlarına bağlı olarak bileşenlerin boyutlarını ayarlamak veya konumlarını değiştirmek için bu metod idealdir.

- **Auto Layout Sonrası Güncellemeler İçin Kullanılır:** Eğer storyboard veya programatik olarak Auto Layout kullanıyorsanız, bileşenlerin yerleşimi Auto Layout motoru tarafından hesaplandıktan sonra, `viewDidLayoutSubviews()` metodu içinde bileşenlerin boyutlarını veya konumlarını güncellemek uygun olabilir.

- **Dikkat Edilmesi Gereken Noktalar:** `viewDidLayoutSubviews()` metodu, view'in her güncelleme döngüsünde çağrılır. Bu nedenle, performansı etkilememesi için gereksiz yere sıkça kullanılmamalıdır. Ayrıca, bu metod içinde başka bir layout değişikliği yapacak metodları çağırmak, döngüsel bir çağrıya neden olabilir.

## Örnek Kullanım

```swift
import UIKit

class YourViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ViewDidLoad metodu genellikle bir kere çalıştırılır
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Örneğin, imageView'ın boyutunu ve konumunu güncellemek için:
        let screenHeight = UIScreen.main.bounds.height
        let targetHeight = screenHeight * 0.8
        imageView.frame.size.height = targetHeight
    }
}

