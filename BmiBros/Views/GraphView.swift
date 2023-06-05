//
//  GraphView.swift
//  BmiBros
//
//  Created by MacBook Pro on 05/06/23.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    var body: some View {
        VStack {
            Text("BMI Graph")
            Text("Average BMI: \(String(format: "%.1f", userViewModel.userInfos.reduce(0, { $0 + $1.bmi })))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            Chart {
                ForEach(userViewModel.userInfos) { userInfo in
                    BarMark(
                        x: .value("Day", userInfo.date, unit: .day),
                        y: .value("BMI", userInfo.bmi)
                    )
                    .foregroundStyle(Color.blue.gradient)
                }
            }
            .frame(height: 180)
            .padding(.bottom, 50)
            .chartXAxis {
                AxisMarks(values: userViewModel.userInfos.map { $0.date }) { date in
                    AxisValueLabel(format: .dateTime.weekday())
                }
            }
            
            Text("Calories Graph")
            Text("Average Calories: \(String(format: "%.0f", userViewModel.userInfos.reduce(0, { $0 + $1.calories }))) / day")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            Chart {
                RuleMark(y: .value("Goal", 50))
                    .foregroundStyle(Color.pink)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                ForEach(userViewModel.userInfos) { userInfo in
                    LineMark(
                        x: .value("Day", userInfo.date, unit: .day),
                        y: .value("BMI", userInfo.bmi)
                    )
                }
            }
            .frame(height: 180)
            .chartXAxis {
                AxisMarks(values: userViewModel.userInfos.map { $0.date }) { date in
                    AxisValueLabel(format: .dateTime.day())
                }
            }
        }
        .padding()
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
            .environmentObject(UserViewModel())
            .environmentObject(AppEnvironment())
    }
}

extension Date {
    static func from(year: Int, month: Int, day:Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
