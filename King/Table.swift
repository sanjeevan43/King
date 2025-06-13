import SwiftUI

struct TableView: View {
    @State private var subjects = [
        Subject(name: "Tamil", internalMarks: "95", theory: "95", total: "190", pass: "P"),
        Subject(name: "English", internalMarks: "80", theory: "80", total: "160", pass: "P"),
        Subject(name: "Maths", internalMarks: "70", theory: "70", total: "140", pass: "P"),
        Subject(name: "Computer", internalMarks: "75", theory: "75", total: "150", pass: "P"),
        Subject(name: "TOTAL", internalMarks: "", theory: "", total: "500", pass: "Pass")
    ]

    var body: some View {
        ScrollView {
           
                
                
                VStack(spacing: 16) {
                    VStack(spacing: 4) {
                        Text("Government of Tamil Nadu")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        Text("Directorate of Government Examinations")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    
                    VStack(spacing: 4) {
                        Text("HSE (+2) Examination Results")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("March 2025")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(10)
                    
                    HStack {
                        Text("Name of the student:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("(Roll Number)")
                    }
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(8)
                                        ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            Text("Subject").frame(maxWidth: .infinity, alignment: .leading)
                            Text("Internal").frame(width: 80)
                            Text("Theory").frame(width: 80)
                            Text("Total").frame(width: 80)
                            Text("Pass").frame(width: 60)
                        }
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                        
                        ForEach(subjects) { subject in
                            HStack {
                                Text(subject.name).frame(maxWidth: .infinity, alignment: .leading)
                                Text(subject.internalMarks).frame(width: 80)
                                Text(subject.theory).frame(width: 80)
                                Text(subject.total).frame(width: 80)
                                Text(subject.pass)
                                    .frame(width: 60)
                                    .foregroundColor(subject.pass.lowercased().hasPrefix("p") ? .green : .red)
                            }
                            .padding(.vertical, 6)
                            .background(subject.name == "TOTAL" ? Color.yellow.opacity(0.3) : Color.clear)
                            .cornerRadius(6)
                        }
                    }
                    
                    Button(action: {
                        // Handle back action
                    }) {
                        Text("Go Back")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                
            }
            .padding()
        }
    }
}

struct Subject: Identifiable {
    let id = UUID()
    let name: String
    let internalMarks: String
    let theory: String
    let total: String
    let pass: String
}

#Preview {
    TableView()
}
