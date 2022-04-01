////
////  ContentView.swift
////  Stopwatch
////
////  Created by Matvey Garbuzov on 01.04.2022.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @ObservedObject var managerClass: ManagerClass = ManagerClass()
//    @State private var lapTimings: [LapClass] = []
//    
//    var body: some View {
//        VStack {
//            Text(String(managerClass.time))
//                .font(.largeTitle)
//            switch managerClass.state {
//            case .stop:
//                HStack {
//                    withAnimation {
//                        Button(action: {
//                            managerClass.start()
//                        }, label: {
//                            Image(systemName: "play")
//                                .foregroundColor(.black)
//                                .font(.title)
//                                .padding()
//                                .background(Color.green)
//                                .cornerRadius(100)
//                        })
//                    }
//                    withAnimation {
//                        Button(action: {
//                            lapTimings = []
//                        }, label: {
//                            Image(systemName: "clear")
//                                .foregroundColor(.black)
//                                .font(.title)
//                                .padding()
//                                .background(Color.yellow)
//                                .cornerRadius(100)
//                        })
//                    }
//                }
//
//
//            case .run:
//                HStack {
//                    withAnimation {
//                        Button(action: {
//                            managerClass.stop()
//                        }, label: {
//                            Image(systemName: "stop")
//                                .foregroundColor(.black)
//                                .font(.title)
//                                .padding()
//                                .background(Color.red)
//                                .cornerRadius(100)
//                        })
//                    }
//                    withAnimation {
//                        Button(action: {
//                            let newLap = LapClass(managerClass.time)
//                            lapTimings.append(newLap)
//                        }, label: {
//                            Image(systemName: "stopwatch")
//                                .foregroundColor(.black)
//                                .font(.title)
//                                .padding()
//                                .background(Color.green)
//                                .cornerRadius(100)
//                        })
//                    }
//                    withAnimation {
//                        Button(action: {
//                            managerClass.pause()
//                        }, label: {
//                            Image(systemName: "pause.circle")
//                                .foregroundColor(.black)
//                                .font(.title)
//                                .padding()
//                                .background(Color.red)
//                                .cornerRadius(100)
//                        })
//                    }
//                    withAnimation {
//                        Button(action: {
//                            lapTimings = []
//                        }, label: {
//                            Image(systemName: "clear")
//                                .foregroundColor(.black)
//                                .font(.title)
//                                .padding()
//                                .background(Color.yellow)
//                                .cornerRadius(100)
//                        })
//                    }
//                }
//
//            case .pause:
//                HStack {
//                    withAnimation {
//                        Button(action: {
//                            managerClass.start()
//                        }, label: {
//                            Image(systemName: "play")
//                                .foregroundColor(.black)
//                                .font(.title)
//                                .padding()
//                                .background(Color.green)
//                                .cornerRadius(100)
//                        })
//                    }
//                    withAnimation {
//                        Button(action: {
//                            managerClass.stop()
//
//                        }, label: {
//                            Image(systemName: "stop")
//                                .foregroundColor(.black)
//                                .font(.title)
//                                .padding()
//                                .background(Color.red)
//                                .cornerRadius(100)
//                        })
//                    }
//                    withAnimation {
//                        Button(action: {
//                            lapTimings = []
//                        }, label: {
//                            Image(systemName: "clear")
//                                .foregroundColor(.black)
//                                .font(.title)
//                                .padding()
//                                .background(Color.yellow)
//                                .cornerRadius(100)
//                        })
//                    }
//                }
//
//            }
//
//            List(lapTimings) { lap in
//                Text("\(String(lap.lap)) seconds")
//            }
//        }
//
//
//
//    }
//}
//
//struct LapClass: Identifiable {
//    var id = UUID()
//    let lap: Int
//    init(_ lap: Int) {
//        self.lap = lap
//    }
//}
//
//enum state {
//    case run
//    case stop
//    case pause
//}
//
//class ManagerClass: ObservableObject {
//    @Published var time: Int = 0
//    @Published var state: state = .stop
//    var timer = Timer()
//
//    func start() {
//        state = .run
//        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
//            self.time += 1
//        }
//    }
//
//    func stop() {
//        timer.invalidate()
//        time = 0
//        state = .stop
//    }
//
//    func pause() {
//        timer.invalidate()
//        state = .pause
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
