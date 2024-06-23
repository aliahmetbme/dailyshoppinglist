## Daily Shopping List
Using Core Data, adding and removing products, and taking images from the camera or gallery are performed.

### Core Data
The 'Shopping' entity is defined in Core Data to add a product, and the necessary fields (name, quantity, cost, image, etc.) are created. During the process of adding a new product, the information received from the user is assigned to this object and saved in the Core Data context. Product deletion is done by fetching the relevant product and deleting it using the `context.delete` method.

### UIImagePickerController
`UIImagePickerController` is used to retrieve images from the camera or gallery. When the user wants to add a picture on the product adding screen, the camera or gallery is selected with 'UIImagePickerController' and the selected picture is taken with 'UIImagePickerControllerDelegate' methods and saved to Core Data. With these operations, the user can add and view images to their products.


![shoppingListBanner](https://github.com/aliahmetbme/dailyshoppinglist/assets/110021045/1daa353c-1985-4e4e-bcdf-93a5de4afeca)
