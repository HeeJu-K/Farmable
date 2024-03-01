//
//  PhotoPicker.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/28/24.
//

import SwiftUI
import PhotosUI
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}


struct ImagePickerView: View {
    @State private var image: UIImage?
//    @State private var image: UIImage? = nil
    @State private var isPhotoPickerPresented = false

    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image(uiImage: self.image ?? UIImage(systemName:"photo")!)
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: geometry.size.width*0.8, height: 200)
                    .position(x:geometry.size.width*0.5, y:100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Rectangle())
                    .onTapGesture {
                        isPhotoPickerPresented.toggle()
                    }
                
                    .sheet(isPresented: $isPhotoPickerPresented) {
                        ImagePicker(image: self.$image)
                    }
            }
        }
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}
