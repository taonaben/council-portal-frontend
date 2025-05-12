List<Map<String, dynamic>> vehicles = [
  {
    'id': "1",
    "plate_number": "AFE 3403",
    "brand": "Mazda",
    "model": "Mazda 3",
    "color": "silver",
    "image": "lib/assets/images/car.jpg",
    "vehicle_type": "car",
    "ticket_count": 21,
    "approval_status": "approved",
    "is_active": false,
  },
  {
    'id': "2",
    "plate_number": "BTR 5678",
    "brand": "Toyota",
    "model": "Hiace",
    "color": "white",
    "image": "lib/assets/images/car.jpg",
    "vehicle_type": "bus",
    "ticket_count": 10,
    "approval_status": "pending",
    "is_active": false,
  },
  {
    'id': "3",
    "plate_number": "MOT 1234",
    "brand": "Honda",
    "model": "CBR500R",
    "color": "red",
    "image": "lib/assets/images/car.jpg",
    "vehicle_type": "motorbike",
    "ticket_count": 5,
    "approval_status": "approved",
    "is_active": false,
  },
  {
    'id': "4",
    "plate_number": "AFD 7890",
    "brand": "Ford",
    "model": "F-150",
    "color": "blue",
    "image": "lib/assets/images/car.jpg",
    "vehicle_type": "truck",
    "ticket_count": 15,
    "approval_status": "rejected",
    "is_active": true,
  },
  {
    "id": "5",
    "plate_number": "OTH 4567",
    "brand": "Tesla",
    "model": "Cybertruck",
    "color": "gray",
    "image": "lib/assets/images/car.jpg",
    "vehicle_type": "other",
    "ticket_count": 8,
    "approval_status": "approved",
    "is_active": false,
  },
  {
    'id': "6",
    "plate_number": "CAR 1122",
    "brand": "BMW",
    "model": "X5",
    "color": "black",
    "image": "lib/assets/images/car.jpg",
    "vehicle_type": "car",
    "ticket_count": 12,
    "approval_status": "pending",
    "is_active": false,
  },
];

Map<String, dynamic>? getActiveVehicle() {
  try {
    return vehicles.firstWhere((vehicle) => vehicle['is_active'] == true);
  } catch (e) {
    return null;
  }
}

void setVehicleActive(String vehicleId) {
  for (var vehicle in vehicles) {
    // Set all vehicles to inactive first
    vehicle['is_active'] = false;
  }
  // Find and set only the selected vehicle to active
  final vehicleToActivate = vehicles.firstWhere(
    (vehicle) => vehicle['id'] == vehicleId,
    orElse: () => throw Exception('Vehicle not found'),
  );
  vehicleToActivate['is_active'] = true;
}
