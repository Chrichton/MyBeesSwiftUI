import SwiftUI

struct ContentView: View {
    @ObservedObject var store: LocationStore
    
    func createLocation() {
        store.locations.append(LocationViewModel(name: "New Name", street: "New Street", color: .purple))
    }
    
    var body: some View {
        NavigationView {
            List(store.locations) { locationViewModel in
                LocationCell(viewModel: locationViewModel)
            }.navigationBarTitle("Locations")
                .navigationBarItems(leading: Button("Map") {}, trailing: Button("+") { self.createLocation()})
        }
        
    }
}

class LocationStore: ObservableObject {
    @Published var locations: [LocationViewModel]
    
    init(locations: [LocationViewModel] = []) {
        self.locations = locations
    }
}

class LocationViewModel: Identifiable {
    var name: String
    var street: String
    var color: UIColor
    
    init(name: String, street: String, color: UIColor) {
        self.name = name
        self.street = street
        self.color = color
    }
}

struct LocationCell: View {
    let viewModel: LocationViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            ColorRectangle(color: viewModel.color)
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                Text(viewModel.street)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ColorRectangle: View {
    let color: UIColor
    
    var body: some View {
        Rectangle()
            .frame(width: 40, height: 40)
            .foregroundColor(Color(color))
            .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let testData = [
        LocationViewModel(name: "Hamburg", street: "Ochsenwerder Landscheideweg", color: .yellow),
        LocationViewModel(name: "Leezen", street: "Kastanienweg", color: .red)
    ]
    
    static var previews: some View {
        ContentView(store: LocationStore(locations: testData))
            .environment(\.sizeCategory, .extraExtraExtraLarge)
    }
}
