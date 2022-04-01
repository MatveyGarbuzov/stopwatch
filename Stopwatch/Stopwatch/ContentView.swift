//
//  ContentView.swift
//  Stopwatch
//
//  Created by Matvey Garbuzov on 01.04.2022.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @ObservedObject var managerClass: ManagerClass = ManagerClass()
    @State private var lapTimings: [LapClass] = []
    
    @State var data = [Double]()
   
    
    var hours: String {
        managerClass.time / 3600 < 24 ? "0" + String(managerClass.time / 3600) : String(managerClass.time / 3600)
    }

    var minutes: String {
        (managerClass.time % 3600) / 60 < 10 ? "0" + String((managerClass.time % 3600) / 60) : String((managerClass.time % 3600) / 60)
    }

    var seconds: String {
        managerClass.time % 60 < 10 ? "0" + String(managerClass.time % 60) : String(managerClass.time % 60)
    }
    
    var body: some View {
        VStack {
            Text("\(hours):\(minutes):\(seconds)")
                .font(.largeTitle)
            switch managerClass.state {
            case .stop:
                HStack {
                    withAnimation {
                        Button(action: {
                            managerClass.start()
                        }, label: {
                            Image(systemName: "play")
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(100)
                        })
                    }
                    withAnimation {
                        Button(action: {
                            
                            lapTimings = []
                        }, label: {
                            Image(systemName: "clear")
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                                .background(Color.yellow)
                                .cornerRadius(100)
                        })
                    }
                }
                
            case .run:
                HStack {
                    withAnimation {
                        Button(action: {
                            managerClass.stop()
                        }, label: {
                            Image(systemName: "stop")
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(100)
                        })
                    }
                    withAnimation {
                        Button(action: {
                            let newLap = LapClass("\(hours):\(minutes):\(seconds)")
                            
                            lapTimings.append(newLap)
                            
                        }, label: {
                            Image(systemName: "stopwatch")
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(100)
                        })
                    }
                    withAnimation {
                        Button(action: {
                            managerClass.pause()
                        }, label: {
                            Image(systemName: "pause.circle")
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(100)
                        })
                    }
                    withAnimation {
                        Button(action: {
                            for i in lapTimings {
                                let text = i.lap
                                let hours = String(text.prefix(2))
                                let start = text.index(text.startIndex, offsetBy: 3)
                                let end = text.index(text.startIndex, offsetBy: 4)
                                let range = start...end
                                let minutes = String(text[range])
                                let seconds = String(text.suffix(2))
                                guard let final_hours = Int(hours) else {
                                    return
                                }
                                guard let final_minutes = Int(minutes) else {
                                    return
                                }
                                guard let final_seconds = Int(seconds) else {
                                    return
                                }
                                let total:Double = Double(final_hours * 3600 + final_minutes * 60 + final_seconds)
                                
                                data.append(total)
                                
                                
                            }
                            print(data)
                            
                            lapTimings = []
                        }, label: {
                            Image(systemName: "clear")
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                                .background(Color.yellow)
                                .cornerRadius(100)
                        })
                    }
                }
                
            case .pause:
                HStack {
                    withAnimation {
                        Button(action: {
                            managerClass.start()
                        }, label: {
                            Image(systemName: "play")
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(100)
                        })
                    }
                    withAnimation {
                        Button(action: {
                            managerClass.stop()
                            
                        }, label: {
                            Image(systemName: "stop")
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(100)
                        })
                    }
                    withAnimation {
                        Button(action: {
                            lapTimings = []
                        }, label: {
                            Image(systemName: "clear")
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                                .background(Color.yellow)
                                .cornerRadius(100)
                        })
                    }
                }
    
            }
            
            List(lapTimings) { lap in
                Text("\(String(lap.lap))")
            }
            
            LineChartView(data: data, title: "ebipufnie")
            
        }
    }
}

struct BarChartView: View {
    var body: some View {
        Text("hello")
    }
}

struct LapClass: Identifiable {
    var id = UUID()
    let lap: String
    init(_ lap: String) {
        self.lap = lap
    }
}

enum state {
    case run
    case stop
    case pause
}

class ManagerClass: ObservableObject {
    @Published var time: Int = 0
    @Published var state: state = .stop
    
    var timer = Timer()
    
    func start() {
        state = .run
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            self.time += 1
        }
    }
    
    func stop() {
        timer.invalidate()
        time = 0
        state = .stop
    }
    
    func pause() {
        timer.invalidate()
        state = .pause
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
