import SwiftUI
import RealityKit

struct ContentView: View {
    var body: some View {
        RealityView { content in
            // Add 5 random objects when the app starts
            for _ in 0..<5 {
                let position = getRandomPosition()
                let object = createRandomObject()
                object.position = position
                content.add(object)  // Add the object to the RealityKit scene
            }
        }
    }
}

// MARK: - Helper Functions

/// Generate random positions within a visible range
func getRandomPosition() -> SIMD3<Float> {
    let x = Float.random(in: -0.2 ... 0.2)  // Narrower range for left/right positioning
    let y = Float.random(in: -0.1 ... 0.3)  // Objects appear slightly elevated
    let z = Float.random(in: -1.0 ... -0.2) // Objects are in front of the user
    return SIMD3(x, y, z)
}

/// Create a random object (box or sphere) with a random color
func createRandomObject() -> Entity {
    let isBox = Bool.random()  // 50% chance to choose a box or sphere
    
    // Create the shape: box or sphere
    let shape = isBox
        ? MeshResource.generateBox(size: 0.2)   // Box with size 0.2 meters
        : MeshResource.generateSphere(radius: 0.1) // Sphere with radius 0.1 meters
    
    // Generate a random color
    let color = UIColor(
        red: CGFloat.random(in: 0.0 ... 1.0),
        green: CGFloat.random(in: 0.0 ... 1.0),
        blue: CGFloat.random(in: 0.0 ... 1.0),
        alpha: 1.0
    )
    let material = SimpleMaterial(color: color, isMetallic: false)
    
    // Create a ModelEntity with the shape and material
    let entity = ModelEntity(mesh: shape, materials: [material])
    return entity
}
